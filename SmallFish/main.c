/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "includes.h"
#include "stm8s_iwdg.h"

int main(void)
{
	uchar time_CNT_M = 0;
	_configSet();	
	_timerBaseInitial();
	_timer1_Initial();
	_timer2_Initial();
	_RTC_Init();
	_ADC_Initial();
//	_EEPROM_Initial();
//	_IOInitial();
	/*Watch dog*/
//	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
//	IWDG_SetPrescaler(IWDG_Prescaler_64);//128kHz
//	IWDG_SetReload(0xff);//Counter 256
//	IWDG_ReloadCounter();//Watch Dog Reset Time = (1/128k)*61*256 = 128ms
//	IWDG_Enable();
//	IWDG_WriteAccessCmd(IWDG_WriteAccess_Disable);

	while(1)
	{
		_timerBase();
//		IWDG_ReloadCounter();//Clear Watch Dog Counter.
		if(isTimeProcess)
		{
			isTimeProcess = No;
			//isBeeper = 1;
			_output();
			_keyScan();
			_timerWheel();
			_displayDecode();
			_Display();
			_keyScanProcess();
			if(++time_CNT_M > 8)
			{
				time_CNT_M = 0;
				_AD_Conversion();
			}
		}
	}
}