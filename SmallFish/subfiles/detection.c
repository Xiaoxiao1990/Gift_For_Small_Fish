#include "includes.h"
#define V_TRIP (PF_IDR&0x10)	//PF_IDR_4
#define I_TRIP (PE_IDR&0x20)	//PE_IDR_5
#define Phase	 (PA_IDR&0x0E)	//PA_IDR_1,2,3

void _detection_Initial(void)
{
	//I_Trip
	EXTI_CR2 = 0B11111110;	//PE5 Interrupt Negedge
	//V_Trip
	EXTI_CR1 &= 0B01111111;
	EXTI_CR1 |= 0B10000000;	//PD7/TLI Interrupt Posedge
	
	CurrentDetectCounter = DetectTimeDelay; //Detect Over Current after 5S
	//Clear
	Phase_Status = 0B00001110;
}
/*
void losePhase(void)
{
	static uchar time_CNT0 = 0;
	static uchar time_CNT1 = 0;
	
	if(isCanDetectPhase)//
	{
		isCanDetectPhase = Reset;
		
		if(ErrorCode & 0B01110000)
		{
			if(++time_CNT0 >= 5)//´ý¶¨
			{
				time_CNT0 = 0;
				ErrorCode |= Lose_Phase_Error;
			}
			time_CNT1 = 0;			//Clear conter 1
		}
		else
		{
			if(++time_CNT1 >= 5)
			{
				time_CNT1 = 0;
				ErrorCode &= ~Lose_Phase_Error;
			}
			time_CNT0 = 0;			//Clear counter 2
		}
	}
}
void overCurrent(void)
{
	static uchar time_CNT0 = 0;
	static uchar time_CNT1 = 0;
	if(isCanDetectCurrent)
	{
		isCanDetectCurrent = Reset;
		
		if(ErrorCode & 0B00000111)
		{
			if(++time_CNT0 >= 4)
			{
				time_CNT0 = 0;
				ErrorCode |= Over_Current_Error;
			}
			time_CNT1 = 0;
		}
		else
		{
			if(++time_CNT1 >= 4)
			{
				time_CNT1 = 0;
				ErrorCode &= ~Over_Current_Error;
				isUpdateDisplay = Yes;
			}
			time_CNT0 = 0;
		}
	}
}
*/
/*################ Confirm lost phase ##############*/
/*
PA3,PA2,PA1
0	0 1
0 1 0
0 1 1
1 0 0
1 0 1
1 1 0
1 1 1
*/

void phaseDetect(void)
{
	if(isCanDetectPhase)	//Every 500mS detect once
	{
		isCanDetectPhase = No;
		//Phase A
		if(Phase_Status & 0B00000010)
		{
			ErrorCode |= Lose_Phase_A_Error;//Phase_A_Error
		}
		else
		{
			ErrorCode &= ~Lose_Phase_A_Error;
		}
		//Phase B
		if(Phase_Status & 0B00000100)
		{
			ErrorCode |= Lose_Phase_B_Error;//Phase_B_Error
		}
		else
		{
			ErrorCode &= ~Lose_Phase_B_Error;
		}
		//Phase C
		if(Phase_Status & 0B00001000)
		{
			ErrorCode |= Lose_Phase_C_Error;//Phase_C_Error
		}
		else
		{
			ErrorCode &= ~Lose_Phase_C_Error;
		}
		
		if(ErrorCode & 0B01110000)
		{
			ErrorCode |= Lose_Phase_Error;
			PhaseDetectCounter = DetectTimeDelay; //Recovery delay more than 5 seconds
		}
		else
		{
			if(PhaseDetectCounter == 0)ErrorCode &= ~Lose_Phase_Error;
		}
	
		//Clear
		Phase_Status = 0B00001110;
	}
	else
	{
		Phase_Status &= Phase;
	}
}

void _detection(void)
{
	/*
	GPIO Detection
	//losePhase();
	//overCurrent();
	*/

	//Interrupt Detection
	if(CurrentDetectCounter == 0)
	{
		//Enable interrupt
		//I_Trip
		PE_CR2 |= 0B00100000;			//EXTI INT
		currentDetect();
	}
	else
	{
		PE_CR2 &= 0B11011111;			//Disable INT input
	}
	
	if(PhaseDetectCounter == 0)
	{
		//Enalbe Interrupt
		//V_Trip
		PD_CR2 |= 0B10000000;		//EXTI INT
	}
	else
	{
		PD_CR2 &= 0B01111111;			//Disable INT input
	}
	phaseDetect();
}