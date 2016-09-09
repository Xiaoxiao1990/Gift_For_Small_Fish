#include "includes.h"
#include "stm8s_adc1.h"

#define RES_UPVALUE	1000// 10000/10

//============== resister =============

#define RESISTOR_TEMP_UPLIMIT 42	//110C
#define RESISTOR_TEMP_LOWLIMIT 59339	//-50C
/*--30 .... 70--*/
/*
const uint tempTable[] = {
37810,35840,34010,32305,30885,29433,28015,26833,25470,24298,23190,
22079,21034,19997,18981,17995,17047,16141,15281,14468,13703,12984,
12311,11681,11094,10545,9985,9475,9006,8571,8165,7783,7422,7079,
6751,6438,6137,5849,5573,5307,5053,4806,4574,4356,4150,3956,3772,
3598,3434,3277,3130,2990,2857,2731,2612,2500,2394,2294,2200,2111,
2028,1945,1865,1788,1713,1641,1572,1505,1442,1381,1323,1269,1217,
1170,1126,1085,1045,1006,968,932,897,864,831,800,771,742,715,689,
664,640,617,595,574,554,534,514,496,478460,444,428,413,399,385,373,361
};
*/
//-50~110
const uint tempTable[]={
9910,9345,8816,8320,7854,7418,7009,6625,6264,5926,5607,5308,
5026,4761,4512,4277,4056,3848,3652,3467,3292,3127,2972,2825,
2686,2555,2431,2314,2203,2098,1999,1904,1815,1731,1651,1575,
1503,1435,1371,1309,1251,1195,1143,1093,1045,1000,957,916,
877,840,805,771,739,709,680,652,625,600,576,553,531,510,490,
471,453,435 ,419,403,387,373,359,345,333,320,309,297,287,
276,266,257,248,239,230,222,215,207,200,193,187,180,174,168,
163,157,152,147,142,138,133,129,125,121,117,113,110,106,103,
100,97,94,91,88,86,83,81,78,76,74,71,69,67,65,64,62,60,58,
57,55,53,52,51,49,48,47,45,44,43,42,41,40,38,37,36,36,35,34
};
/***************************************************************
===================== _AD_resister initialize ==================

****************************************************************/
void _ADC_Initial(void)
{
	uchar i;

	ADC_CR2 = ADC1_ALIGN_RIGHT; // A/D data rigth align
	ADC_CR1 = 0x00; // ADC clock=main clock/2=4MHZm,sigle converterm,disable convert
	ADC_CSR = 0x02; // choose channel 2
	//ADC_TDRL = 0x20;
	bitADC1_CR1_ADON = 1;	//ADC_CR1 = 0x01; // enable AD start
	
	for(i=0;i<100;i++); // wait at least 7us
	for(i=0;i<100;i++); // wait at least 7us
	bitADC1_CR1_ADON = 1;
	bitADC1_CSR_EOC = 0;
}

void _AD_Conversion(void)
{
	int temp0;
	uchar i;
	uint	ResistorValue;
	static uchar sumTimes = 0,sumTimes1 = 0;
	static uint	sum_AD_value = 0,sum_AD_value1 = 0;
	static signed int CurrentTempBkp = 0,CurrentTempValue = 0;
	static uint lightValue = 0;
	static _Bool Channel = 0;//0:temp,1:light
	
	if (ADC1_GetFlagStatus(ADC1_FLAG_EOC)== 0) return;// SET or RESET
	RandSeed = ADC1_GetConversionValue();//For random
	if(Channel)
	{
		Channel = 0;
		sum_AD_value1 += RandSeed;
		ADC_CSR = 0x02;//For Temp
		bitADC1_CR1_ADON = 1;//
		if(++sumTimes1 >= 16)
		{
			sumTimes1 = 0;
			sum_AD_value1 >>= 4;
			lightValue = (13*lightValue + sum_AD_value1*3)>>4;//filter
			LightValue = lightValue;
			sum_AD_value1 = 0;
		}
	}
	else
	{
		Channel = 1;
		sum_AD_value += RandSeed;
		ADC_CSR = 0x03;//For Light
		bitADC1_CR1_ADON = 1;
		if (++sumTimes >= 16)
		{
			sumTimes = 0;
			sum_AD_value >>= 4;
			if(sum_AD_value >= 1000)//NTC may Open circuit
			{
				ResistorValue = RESISTOR_TEMP_LOWLIMIT;
			}
			else
			{
				ResistorValue = (long)sum_AD_value*RES_UPVALUE/(1024-sum_AD_value);
			}
			if (ResistorValue >= RESISTOR_TEMP_LOWLIMIT)//-20`c ,
			{
				ResistorValue = RESISTOR_TEMP_LOWLIMIT;
				CurrentTempValue = -200;
				ErrorCode = 1;
			}
			else if (ResistorValue < RESISTOR_TEMP_UPLIMIT)
			{
				ResistorValue = RESISTOR_TEMP_UPLIMIT;
				CurrentTempValue = 1110;
				ErrorCode = 2;
			}	
			else 
			{
				ErrorCode = 0;
				for (i = 0;ResistorValue <= tempTable[i];i++)if(i > 200)break;
				if(i == 0)
				{
					CurrentTempValue = -200;
				}
				else
				{
					temp0 = (long)10*(tempTable[i-1]-ResistorValue)/(tempTable[i-1]-tempTable[i])+1;
					CurrentTempValue = -200+(i-1)*10+temp0;
					if (CurrentTempValue <= -200)
					{
						CurrentTempValue = -200;
					}
					else
					{
						if(CurrentTempValue > 1110)
						{
							CurrentTempValue = 1110;
						}
					}
				}
			}
	
			CurrentTempBkp = (13*CurrentTempBkp + CurrentTempValue*3)>>4;//filter
			CurrentTemp = CurrentTempBkp;//+ CorrectTemp*10;
			isUpdateDisplay = Yes;
		
			CurrentTemp += CorrectTemp;
			sum_AD_value = 0;
		}
	}
}