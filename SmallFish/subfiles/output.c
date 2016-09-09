#include "includes.h"

#define PIR			PD_IDR_1

#define ON   0
#define OFF	 1

void beeper(void)
{
	static uchar time_CNT = 0;
	// Í¨¹ýÉèÖÃ·äÃùÆ÷¿ØÖÆ¼Ä´æÆ÷£¬À´´ò¿ª·äÃùÆ÷µÄ¹¦ÄÜ,·äÃùÆ÷¿ØÖÆ¼Ä´æÆ÷µÄÉèÖÃ£º
	// BEEPDIV[1:0] = 00 BEEPDIV[4:0] = 0e BEEPEN = 1
	// ·äÃùÆ÷µÄÊä³öÆµÂÊ = Fls / ( 8 * (BEEPDIV + 2) )= 128K / (8 * 16) = 1K
	if(isBeeper)
	{
		if(time_CNT == 0)BEEP_CSR = 0x2a;//2K
		if(++time_CNT > 120)
		{
			isBeeper = 0;
		}
	}
	else
	{
		BEEP_CSR = 0x1a; // ¹Ø±Õ·äÃùÆ÷
		time_CNT = 0;
	}
}
//Auto Adjust Lightness
void LightnessAdjust(void)
{
	static uchar time_CNT = 0,time_CNT1 = 0;
	static uint grayscale = 0;
	
	if(!PIR)
	{
		if(++time_CNT1 > 200)
		{
			time_CNT1 = 0;
			LittleFishWakeUp = 2;//Delay 20S
			isPIR = 1;
			GrayScale = 500;
		}
	}
	else
	{
		GrayScale = 0;
		time_CNT1 = 0;
	}
	
	//Auto
	if(isCanUpdateGrayScale)
	{
		if(++time_CNT > 20)//60ms
		{
			time_CNT = 0;
			if(GrayScale > 500)GrayScale = 500;//check value
			if(grayscale == GrayScale)isCanUpdateGrayScale = 0;
			if(grayscale > GrayScale)grayscale--;
			if(grayscale < GrayScale)grayscale++;
			
			//PWM Ratio for digital grayscale
			TIM2_CCR2H = grayscale>>8;
			TIM2_CCR2L = grayscale&0xFF;
		}
	}
}

void recoder(void)
{
	
}

void _output(void)
{
	beeper();
	LightnessAdjust();
	
}