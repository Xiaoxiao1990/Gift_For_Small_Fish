#include "includes.h"

#define SDAT  PD_ODR_5
#define SCLK	PC_ODR_7
#define RCLK	PC_ODR_5
#define DEN		PD_ODR_3

#define MAX_MODE								4				//display mode
#define ANIMOTION_TIME					2				//n * 50ms
#define STANDBY_TIME_TIME				200			//n * 50ms
#define STANDBY_TIME_TEMP				100			//n * 50ms
/*******************************************
*_display() with key scan subroutine
********************************************/

const uchar LEDCode[]={//Share Cathode
	0b00111111,	//0
	0b00000110,	//1
	0b01011011,	//2
	0b01001111,	//3
	0b01100110,	//4
	0b01101101,	//5
	0b01111101,	//6
	0b00000111,	//7
	0b01111111,	//8
	0b01101111, //9
	0b01000000, //- //0x0a
	0b01110001, //F //0x0b
	0b01100001, //c //0x0c
	0b01110110, //H //0x0d
	0b01110011, //P //0x0e
	0b00000000, //Null //0x0f
	0b00110111, //N 0x10
	0b01000110, //-1  0x11
	0b00011100, //u		0x12
	0b01010100,	//n		0x13
	0b01110111, //R		0x14
	0b01111001, //E		0x15
	0b00111001  //C		0x16
};
const uchar BIT_CODE[]={0xFE,0xFD,0xFB,0xF7,0xEF,0xDF,0x7F,0xBF,0xFF};
void tempdecode(signed int temp)
{
	if(temp < 0)
	{
		if(temp > -100)
		{
			LED_Buf[0] = LEDCode[0x0A];//-
			LED_Buf[1] = LEDCode[-temp%100/10]|0x80;//with dot
			LED_Buf[2] = LEDCode[-temp%10];
		}
		else
		{
			LED_Buf[0] = LEDCode[0x11];//-1
			LED_Buf[1] = LEDCode[-temp%100/10]|0x80;//without dot
			LED_Buf[2] = LEDCode[-temp%10];
		}
	}
	else
	{/**100C**/
		if(temp > 999)
		{
			LED_Buf[0] = LEDCode[temp/1000];
			LED_Buf[1] = LEDCode[temp%1000/100];
			LED_Buf[2] = LEDCode[temp/10];
		}
		else if(temp < 100)
		{/**0.0~9.9C**/
			LED_Buf[0] = LEDCode[0x0F];//Null
			LED_Buf[1] = LEDCode[temp%100/10]|0x80;
			LED_Buf[2] = LEDCode[temp%10];
		}
		else
		{/**10.0~99.9C**/
			LED_Buf[0] = LEDCode[temp/100];
			LED_Buf[1] = LEDCode[temp%100/10]|0x80;
			LED_Buf[2] = LEDCode[temp%10];
		}
	}
	LED_Buf[3] = LEDCode[0x0C];//c
	LED_Buf[4] = LED_Buf[5] = LEDCode[0x0F];//Null;
	LED_Buf[6] = BIT_CODE[6];//Temp Dot  ON:6,OFF:8 
	LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
}
void timedecode(Time_TypeDef *Time)
{
	//Time
	LED_Buf[0] = LEDCode[Time->Hour/10];//Null
	LED_Buf[1] = LEDCode[Time->Hour%10];//Null
	LED_Buf[2] = LEDCode[Time->Minute/10];//Null
	LED_Buf[3] = LEDCode[Time->Minute%10];//Null
	LED_Buf[4] = LEDCode[Time->Second/10];//Null
	LED_Buf[5] = LEDCode[Time->Second%10];//Null
	
	LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
	LED_Buf[7] = (isFlash1Hz)?BIT_CODE[7]:BIT_CODE[8];//Time Dot  ON:7,OFF:8
}
//rand seed by light value ADC
uchar rand(uchar cnt)
{
	return (uchar)RandSeed%cnt;
}

//display style
/*
显示类型种数：
temp = dismode*direct
time = dismode*direct
total = temp*time = 64
*/
void displayStyle(void)
{
	static dismode = 0;
	static uchar buf[7],timeCNT1 = 0;
	static uchar step = 0,CNT = 0,direct = 0,rollCNT = 0;
	static _Bool isChangeContent = 0;
	static uint timeCNT = 0;//switch content counter
	uchar i;
	uint standby_time;
	
	uchar masktbl[] = {
		0B00000001,//a
		0B00100010,//b,f
		0B01000000,//g
		0B00010100,//d,e
		0B00001000,//c
		0B10000000 //dp
	};
	switch(dismode)
	{
		case 0:
		{//cycle round left or right
			switch(step)
			{
				case 0:
				{//parse -> restore -> clear
					if(!isChangeContent)timedecode(&Now);
					else tempdecode(CurrentTemp);
					
					for(i = 0;i < 8;i++)
					{
						buf[i] = LED_Buf[i];
						LED_Buf[i] = LEDCode[0x0f];//Null clear
					}
					LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
					LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
					step++;
					//get direction
					if(LightValue&0x01)direct = 0x01;
					else direct = 0x80;
					CNT = 0;//Clear
				}break;
				case 1:
				{
					if(is50ms)
					{
						is50ms = 0;
						if(++timeCNT > ANIMOTION_TIME)
						{//animotions
							timeCNT = 0;
							for(i = 0;i < 8;i++)
							{
								if(direct == 0x01)LED_Buf[i] |= (buf[i]&(direct<<CNT));			//R
								else if(direct == 0x80)LED_Buf[i] |= (buf[i]&(direct>>CNT));//L
							}
							CNT++;
						}
						if(CNT >= 8)
						{
							CNT = 0;
							step++;
						}
					}
				}break;
				case 2:
				{//standby
					if(!isChangeContent)
					{
						timedecode(&Now);
						standby_time = STANDBY_TIME_TIME;
					}
					else
					{
						tempdecode(CurrentTemp);
						standby_time = STANDBY_TIME_TEMP;
					}
					
					if(is50ms)
					{
						is50ms = 0;
						if(++timeCNT > standby_time)
						{
							timeCNT = 0;
							if(++CNT > 1)
							{
								CNT = 0;
								step = 0;
								if(!isChangeContent)
								{
									isChangeContent = 1;
								}
								else
								{
									isChangeContent = 0;
								}
								dismode = rand(MAX_MODE);
							}
						}
					}
				}break;
				default:step = 0;
			}
		}break;
		case 1:
		{//appear
			switch(step)
			{
				case 0:
				{
					if(!isChangeContent)timedecode(&Now);
					else tempdecode(CurrentTemp);
					
					for(i = 0;i < 8;i++)
					{
						buf[i] = LED_Buf[i];
						LED_Buf[i] = LEDCode[0x0f];//Null clear
					}
					LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
					LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
					step++;
					direct = LightValue&0x01;//0:Up->Down,1:Down->Up
					CNT = 0;//Clear
				}break;
				case 1:
				{
					if(is50ms)
					{
						is50ms = 0;
						if(++timeCNT > ANIMOTION_TIME+1)
						{//per 500ms
							timeCNT = 0;
							for(i = 0;i < 8;i++)
							{
								if(direct)LED_Buf[i] |= (buf[i]&(masktbl[5-CNT]));//Down->Up
								else LED_Buf[i] |= (buf[i]&(masktbl[CNT]));		  	//Up->Down
							}
							CNT++;
						}
						if(CNT >= 6)
						{
							CNT = 0;
							step++;
						}
					}
				}break;
				case 2:
				{
					if(!isChangeContent)
					{
						timedecode(&Now);
						standby_time = STANDBY_TIME_TIME;
					}
					else
					{
						tempdecode(CurrentTemp);
						standby_time = STANDBY_TIME_TEMP;
					}
					if(is50ms)
					{
						is50ms = 0;
						if(++timeCNT > standby_time)//20S
						{
							timeCNT = 0;
							if(++CNT > 1)
							{
								CNT = 0;
								step = 0;
								if(!isChangeContent)
								{
									isChangeContent = 1;
								}
								else
								{
									isChangeContent = 0;
								}
								dismode = rand(MAX_MODE);
							}
						}
					}
				}break;
				default:step = 0;
			}
		}break;
		case 2:
		{//flow
			switch(step)
			{
				case 0:
				{
					if(!isChangeContent)timedecode(&Now);
					else tempdecode(CurrentTemp);
					
					for(i = 0;i < 8;i++)
					{
						buf[i] = LED_Buf[i];
						LED_Buf[i] = LEDCode[0x0f];//Null clear
					}
					LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
					LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
					step++;
					direct = LightValue&0x01;//0:Up->Down,1:Down->Up
					if((!direct)&&(isChangeContent))rollCNT = 2;
					else rollCNT = 0;
					CNT = 0;//Set
				}break;
				case 1:
				{
					if(is50ms)
					{
						is50ms = 0;
						if(++timeCNT > ANIMOTION_TIME-1)
						{//per 500ms
							timeCNT = 0;
							if(direct)
							{
								for(i = rollCNT; i < 6;i++)LED_Buf[i] = 0;//Clear
								LED_Buf[5 - CNT] = buf[rollCNT];
								if(++CNT >= (6 - rollCNT))
								{
									CNT = 0;
									if(++rollCNT >= 6)
									{
										rollCNT = 0;
										step++;
									}
								}
							}
							else
							{
								for(i = 0; i < (5 - rollCNT);i++)LED_Buf[i] = 0;//Clear
								LED_Buf[CNT] = buf[5 - rollCNT];
								if(++CNT >= (6 - rollCNT))
								{
									CNT = 0;
									if(++rollCNT >= 6)
									{
										rollCNT = 0;
										step++;
									}
								}
							}
						}
					}
				}break;
				case 2:
				{
					if(!isChangeContent)
					{
						timedecode(&Now);
						standby_time = STANDBY_TIME_TIME;
					}
					else
					{
						tempdecode(CurrentTemp);
						standby_time = STANDBY_TIME_TEMP;
					}
					if(is50ms)
					{
						is50ms = 0;
						if(++timeCNT > standby_time)//20S
						{
							timeCNT = 0;
							if(++CNT > 1)
							{
								step = 0;
								if(!isChangeContent)
								{
									isChangeContent = 1;
								}
								else
								{
									isChangeContent = 0;
								}
								dismode = rand(MAX_MODE);
							}
						}
					}
				}break;
				default:step = 0;
			}
		}break;
		case 3:
		{//rand(num)
			switch(step)
			{
				case 0:
				{				
					for(i = 0;i < 8;i++)
					{
						LED_Buf[i] = LEDCode[0x0f];//Null clear
					}
					LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
					LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
					step++;
				}break;
				case 1:
				{
					if(is50ms)
					{//for display
						is50ms = 0;
						if(++timeCNT > ANIMOTION_TIME-1)
						{
							timeCNT = 0;
							if(isChangeContent)
							{//Temp
								for(i = 0;i < 3;i++)
								{
									LED_Buf[i] = buf[i];
								}
								LED_Buf[1] |= 0x80;//Dot
								LED_Buf[3] = LEDCode[0x0C];//c
								LED_Buf[4] = LED_Buf[5] = LEDCode[0x0F];//Null;
								LED_Buf[6] = BIT_CODE[6];//Temp Dot  ON:6,OFF:8 
								LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
							}
							else
							{//Time
								for(i = 0;i < 6;i++)
								{
									LED_Buf[i] = buf[i];
								}
								LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
								LED_Buf[7] = BIT_CODE[7];//Time Dot  ON:7,OFF:8
							}
							if(++CNT > 40)
							{
								CNT = 0;
								step++;
							}
						}
					}
					else
					{
						if(++timeCNT1 > 16)//32ms per number
						{//avoid the same value
							timeCNT1 = 0;
							if(rollCNT < 6)
							{
								buf[rollCNT] = LEDCode[rand(10)];//get random seed
								rollCNT++;
							}
							else rollCNT = 0;
						}
					}
				}break;
				case 2:
				{
					if(!isChangeContent)
					{
						timedecode(&Now);
						standby_time = STANDBY_TIME_TIME;
					}
					else
					{
						tempdecode(CurrentTemp);
						standby_time = STANDBY_TIME_TEMP;
					}
					if(is50ms)
					{
						is50ms = 0;
						if(++timeCNT > standby_time)//20S
						{
							timeCNT = 0;
							if(++CNT > 1)
							{
								step = 0;
								if(!isChangeContent)
								{
									isChangeContent = 1;
								}
								else
								{
									isChangeContent = 0;
								}
								dismode = rand(MAX_MODE);
							}
						}
					}
				}break;
				default:step = 0;
			}
		}break;
		default:;
	}
}

void _displayDecode(void)
{
	static uchar type = 0;
	/****************Start LED decode subtoutine*********/
	switch(MachineStatus)
	{
		case IDEL:
		{
			displayStyle();
			/*
			switch(DisplayMode)
			{
				case 0:timedecode(&Now);break;
				case 1:tempdecode(CurrentTemp);break;
				default:;
			}*/
		}break;
		case SELECT://Temperature Control
		{
			LED_Buf[0] = LEDCode[0x0b];//F
			LED_Buf[1] = LEDCode[0x12];//u
			LED_Buf[2] = LEDCode[0x13];//n
			LED_Buf[3] = LEDCode[SetMenu];//Null
			LED_Buf[4] = LEDCode[0x0f];//Null
			LED_Buf[5] = LEDCode[0x0f];//Null
			
			LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
			LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
		}break;
		case SETTING:
		{
			switch(SetMenu)
			{
				case FUNCTION_0:
				{
					LED_Buf[0] = LEDCode[0x14];//R
					LED_Buf[1] = LEDCode[0x15];//E
					LED_Buf[2] = LEDCode[0x16];//C
					LED_Buf[3] = LEDCode[0x0f];//Null
					LED_Buf[4] = LEDCode[0x0f];//Null
					LED_Buf[5] = LEDCode[0x0f];//Null
					
					LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
					LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
				}break;
				case FUNCTION_1:
				{
					timedecode(&Now);
					if(isFlash1Hz)LED_Buf[SetStep] = LEDCode[0x0f];//Null
				}break;
				case FUNCTION_2:tempdecode(CorrectTemp);break;
				case FUNCTION_3:break;
				case FUNCTION_4:break;
				case FUNCTION_5:break;
				case FUNCTION_6:break;
				default:;
			}
		}break;
		default:;
	}
/*	
	testValue = LightValue;

	LED_Buf[0] = LEDCode[testValue/10000];//Null
	LED_Buf[1] = LEDCode[testValue%10000/1000];//Null
	LED_Buf[2] = LEDCode[testValue%1000/100];//Null
	LED_Buf[3] = LEDCode[LightValue%100/10];//Null
	LED_Buf[4] = LEDCode[LightValue%10];//Null
	LED_Buf[5] = LEDCode[0x0f];//Null
	
	LED_Buf[6] = BIT_CODE[8];//Dot ON
	LED_Buf[7] = BIT_CODE[8];//Dot OFF
*/
	/****************End LED decode subtoutine***********/
}
extern void keyscan(void);

void hc_595_driver(uchar bit,uchar data)
{
	uchar i;
	
	//Bits
	//RCLK = 0;
	for(i = 0;i < 8 ;i++)//deliver bit select data
	{
		SCLK = 0;//Is very important to add on this syntax
		SDAT = bit & 0x80;
		bit <<= 1;
		_asm("nop");//waitting for stable data
		SCLK = 1;//posedge srclk
		//_asm("nop");
		//SCLK = 0;
	}
	//Ditial
	for(i = 0;i < 8 ;i++)//deliver bit select data
	{
		SCLK = 0;//Is very important to add on this syntax
		SDAT = data & 0x80;
		data <<= 1;
		_asm("nop");//waitting for stable data
		SCLK = 1;//posedge srclk
		//_asm("nop");
		//SCLK = 0;
	}
	
	RCLK = 1;//posedge rclk.
	_asm("nop");
	RCLK = 0;
}

void _Display(void)
{
	static uchar digitalNum = 0;
	uchar i = 0;
	//DEN = 1;
	if(digitalNum < 6)
	{
		hc_595_driver(BIT_CODE[digitalNum],LED_Buf[digitalNum]);
	}
	else if(digitalNum == 6)hc_595_driver(LED_Buf[6],0);
	else if(digitalNum == 7)hc_595_driver(LED_Buf[7],0);
	
	if(++digitalNum > 7)digitalNum = 0;
	//for(;i > 100;i++);
}