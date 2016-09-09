#include "includes.h"

#define PORT_KEY 	(((PD_IDR&0B01000000)>>6)|\
									 ((PC_IDR&0B01000000)>>5)|\
									 ((PA_IDR&0B00001000)>>1))

#define KEYRELEASE_PORTVALUE	0b00000000
	/*
	PD2----S1
	PD3----S2
	PD5----S3
	PD6----S4
	*/
#define KEY_ADD		 					0b00000100   //S3
#define KEY_SET							0b00000001   //S1
#define KEY_SUB							0b00000010   //S2

#define KEY_SHORT_PRESS 30
#define KEY_LONG_PRESS  700

#define LONG_PRESS_ADD_UINT 4
#define LONG_PRESS_COUNT		8000
#define LONG_PRESS_LIMIT		3000
#define LONG_PRESS_SUB_UNIT 180

uchar keyActiveValue;
uint longPressCnt;
uint longPressBase;
_Bool isKeyLongPress;
_Bool isKeyProcess;
_Bool isCanEffect;
/*####### Update All LED status #######*/

void _IOInitial(void)
{
	
}

void _keyScan(void)
{
	static uchar keyNewValue = KEYRELEASE_PORTVALUE;
	static uint keyScanCnt;
	static uchar steps;
	uchar  keyStatus;
	static uchar time_CNT = 0;
	
	if(++time_CNT < 10)
	{
		return;
	}
	time_CNT = 0;
	
	keyStatus = PORT_KEY ^ KEYRELEASE_PORTVALUE;
	switch(steps)
	{
		case 0:														//keys has been pressed
		{
			if(keyStatus != 0)
			{
				keyNewValue = keyStatus; 			//store the keys value;
				steps++;											//turn to next step
			}
			else
			{
				keyScanCnt = 0;
				isKeyLongPress = 0;
				isCanEffect = 1;
			}
		}break;
		case 1:														//confirm keys has been pressed
		{
			if(keyStatus == keyNewValue)		//if the keys value is not change
			{
				if(++keyScanCnt > KEY_SHORT_PRESS)					//dealy
				{
					keyScanCnt = 0;							//clear counter
					steps++;										//turn to next step
					keyActiveValue = keyNewValue;
				}
			}
			else
			{
				keyScanCnt = 0;								//clear time counter
				steps--;       								//back to first step
			}
		}break;
		case 2:														//clarify long press & short press.
		{
			if(keyStatus != keyNewValue)//Key release
			{
				if(!isKeyLongPress)isKeyProcess = 1;
				steps = 0;
				keyScanCnt = 0;
				longPressBase = LONG_PRESS_COUNT;
				REC = 0;//Release Recoder
			}
			else
			{
				if(++keyScanCnt > KEY_LONG_PRESS)  //if key long time press
				{
					keyScanCnt = KEY_SHORT_PRESS;
					isKeyLongPress = 1;						  //set key long time press flag
				}
				inSetTimer = 0;										//Any key is pressed clear the time counter
			}
		}break;
		default:;
	}
}

void opreat(uchar opcode)
{
	if(opcode == KEY_ADD)
	{
		switch(SetMenu)
		{
			case FUNCTION_0:/*In Contiune press*/break;//Recoder
			case FUNCTION_1:			//Clock
			{
				switch(SetStep)
				{
					case SET_TIME_HH:
					{
						if(Now.Hour < 14)Now.Hour += 10;
						else Now.Hour = 20;
					}break;
					case SET_TIME_HL:
					{
						if(Now.Hour < 20)
						{
							if(Now.Hour%10 < 9)Now.Hour++;
						}
						else
						{
							if(Now.Hour < 23)Now.Hour++;
						}
					}break;
					case SET_TIME_MH:
					{
						if(Now.Minute < 50)Now.Minute += 10;
					};break;
					case SET_TIME_ML:
					{
						if(Now.Minute%10 < 9)Now.Minute++;
					}break;
					case SET_TIME_SH:
					{
						if(Now.Second < 50)Now.Second += 10;
					}break;
					case SET_TIME_SL:
					{
						if(Now.Second%10 < 9)Now.Second++;
					}break;
					default:;
				}
			}break;
			case FUNCTION_2:
			{
				if(CorrectTemp < 100)CorrectTemp++;
				else CorrectTemp = 100;
			}break;
			case FUNCTION_3:break;
			case FUNCTION_4:break;
			case FUNCTION_5:break;
			case FUNCTION_6:break;
			default:;
		}
	}
	else if(opcode == KEY_SUB)
	{
		switch(SetMenu)
		{
			case FUNCTION_0:PLAYE = 0;PLAYE = 1;break;
			case FUNCTION_1:
			{
				switch(SetStep)
				{
					case SET_TIME_HH:
					{
						if(Now.Hour > 9)Now.Hour -= 10;
					}break;
					case SET_TIME_HL:
					{
						if(Now.Hour%10 > 0)
						{
							Now.Hour--;
						}
					}break;
					case SET_TIME_MH:
					{
						if(Now.Minute > 9)Now.Minute -= 10;
					};break;
					case SET_TIME_ML:
					{
						if(Now.Minute%10 > 0)Now.Minute--;
					}break;
					case SET_TIME_SH:
					{
						if(Now.Second > 9)Now.Second -= 10;
					}break;
					case SET_TIME_SL:
					{
						if(Now.Second%10 > 0)Now.Second--;
					}break;
					default:;
				}
			}break;
			case FUNCTION_2:
			{
				if(CorrectTemp > -100)CorrectTemp--;
				else CorrectTemp = -100;
			}break;
			case FUNCTION_3:break;
			case FUNCTION_4:break;
			case FUNCTION_5:break;
			case FUNCTION_6:break;
			default:;
		}
	}
	else
	{
		switch(SetMenu)
		{
			case FUNCTION_0:MachineStatus = SELECT;break;
			case FUNCTION_1:
			{
				switch(SetStep)
				{
					case SET_TIME_HH:
					case SET_TIME_HL:
					case SET_TIME_MH:
					case SET_TIME_ML:
					case SET_TIME_SH:SetStep++;break;
					case SET_TIME_SL:
					{
						SetStep = 0;
						MachineStatus = SELECT;
						_setTime();
					}break;
					default:;
				}
			}break;
			case FUNCTION_2:MachineStatus = SELECT;break;
			case FUNCTION_3:break;
			case FUNCTION_4:break;
			case FUNCTION_5:break;
			case FUNCTION_6:break;
			default:;
		}
	}
}

void keyaddprocess(void)
{
	switch(MachineStatus)
	{
		case IDEL:break;
		case SELECT:
		{
			if(++SetMenu > FUNCTION_6)SetMenu = FUNCTION_0;
		}break;
		case SETTING:
		{
			opreat(KEY_ADD);
		}break;
		default:;
	}
}

void keysubprocess(void)
{
	switch(MachineStatus)
	{
		case IDEL:break;
		case SELECT:
		{
			if(SetMenu > FUNCTION_0)SetMenu--;
			else SetMenu = FUNCTION_6;
		}break;
		case SETTING:
		{
			opreat(KEY_SUB);
		}break;
		default:;
	}
}

void keysetprocess(void)
{
	switch(MachineStatus)
	{
		case IDEL:
		{
			MachineStatus++;
			SetMenu = 0;
		}break;
		case SELECT:
		{
			MachineStatus++;
			SetStep = 0;
		}break;
		case SETTING:
		{
			opreat(KEY_SET);
		}break;
		default:;
	}
}

void _keyScanProcess(void)
{
	if (isKeyLongPress)
	{
		longPressCnt += LONG_PRESS_ADD_UINT;
		if(++longPressCnt > longPressBase)
		{
			longPressCnt = 0;
			if(longPressBase > LONG_PRESS_LIMIT)
			{
				longPressBase -= LONG_PRESS_SUB_UNIT;
			}
			//Key Long Press
			if(keyActiveValue == KEY_ADD)
			{
				if(MachineStatus == SETTING)
				{
					inSetTimer = 0;
					if(SetMenu == FUNCTION_0)//recoder
					{
						REC = 1;
					}
					else isKeyProcess = 1;
				}
			}
			else if(keyActiveValue == KEY_SET)
			{//Long Press SET 
				MachineStatus = SELECT;
				SetMenu = FUNCTION_0;
				inSetTimer = 0;
			}
		}
	}
	if(isKeyProcess)
	{
		isKeyProcess = 0;
		isBeeper = 1;
		isUpdateDisplay = Yes;
		inSetTimer = 0;
		switch(keyActiveValue)
		{
			case KEY_SET:
			{
				keysetprocess();
			}
			break;
			case KEY_ADD:
			{
				keyaddprocess();
			}break;
			case KEY_SUB:
			{
				keysubprocess();
			}break;
			default:;
		}
	}
}
