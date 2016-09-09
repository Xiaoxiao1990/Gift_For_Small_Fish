   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3873                     ; 8 int main(void)
3873                     ; 9 {
3875                     	switch	.text
3876  0000               _main:
3878  0000 88            	push	a
3879       00000001      OFST:	set	1
3882                     ; 10 	uchar time_CNT_M = 0;
3884  0001 0f01          	clr	(OFST+0,sp)
3885                     ; 11 	_configSet();	
3887  0003 cd0000        	call	__configSet
3889                     ; 12 	_timerBaseInitial();
3891  0006 cd0000        	call	__timerBaseInitial
3893                     ; 13 	_timer1_Initial();
3895  0009 cd0000        	call	__timer1_Initial
3897                     ; 14 	_timer2_Initial();
3899  000c cd0000        	call	__timer2_Initial
3901                     ; 15 	_RTC_Init();
3903  000f cd0000        	call	__RTC_Init
3905                     ; 16 	_ADC_Initial();
3907  0012 cd0000        	call	__ADC_Initial
3909                     ; 20 	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
3911  0015 a655          	ld	a,#85
3912  0017 cd0000        	call	_IWDG_WriteAccessCmd
3914                     ; 21 	IWDG_SetPrescaler(IWDG_Prescaler_128);//128kHz
3916  001a a605          	ld	a,#5
3917  001c cd0000        	call	_IWDG_SetPrescaler
3919                     ; 22 	IWDG_SetReload(0xff);//Counter 256
3921  001f a6ff          	ld	a,#255
3922  0021 cd0000        	call	_IWDG_SetReload
3924                     ; 23 	IWDG_ReloadCounter();//Watch Dog Reset Time = (1/128k)*61*256 = 128ms
3926  0024 cd0000        	call	_IWDG_ReloadCounter
3928                     ; 24 	IWDG_Enable();
3930  0027 cd0000        	call	_IWDG_Enable
3932                     ; 25 	IWDG_WriteAccessCmd(IWDG_WriteAccess_Disable);
3934  002a 4f            	clr	a
3935  002b cd0000        	call	_IWDG_WriteAccessCmd
3937  002e               L3152:
3938                     ; 29 		_timerBase();
3940  002e cd0000        	call	__timerBase
3942                     ; 30 		IWDG_ReloadCounter();//Clear Watch Dog Counter.
3944  0031 cd0000        	call	_IWDG_ReloadCounter
3946                     ; 31 		if(isTimeProcess)
3948                     	btst	_isTimeProcess
3949  0039 24f3          	jruge	L3152
3950                     ; 33 			isTimeProcess = No;
3952  003b 72110000      	bres	_isTimeProcess
3953                     ; 34 			_output();
3955  003f cd0000        	call	__output
3957                     ; 35 			_keyScan();
3959  0042 cd0000        	call	__keyScan
3961                     ; 36 			_timerWheel();
3963  0045 cd0000        	call	__timerWheel
3965                     ; 37 			_displayDecode();
3967  0048 cd0000        	call	__displayDecode
3969                     ; 38 			_Display();
3971  004b cd0000        	call	__Display
3973                     ; 39 			_keyScanProcess();
3975  004e cd0000        	call	__keyScanProcess
3977                     ; 40 			if(++time_CNT_M > 2)
3979  0051 0c01          	inc	(OFST+0,sp)
3980  0053 7b01          	ld	a,(OFST+0,sp)
3981  0055 a103          	cp	a,#3
3982  0057 25d5          	jrult	L3152
3983                     ; 42 				time_CNT_M = 0;
3985  0059 0f01          	clr	(OFST+0,sp)
3986                     ; 43 				_AD_Conversion();
3988  005b cd0000        	call	__AD_Conversion
3990  005e 20ce          	jra	L3152
4003                     	xdef	_main
4004                     	xref	_IWDG_Enable
4005                     	xref	_IWDG_ReloadCounter
4006                     	xref	_IWDG_SetReload
4007                     	xref	_IWDG_SetPrescaler
4008                     	xref	_IWDG_WriteAccessCmd
4009                     	xbit	_isTimeProcess
4010                     	xref	__output
4011                     	xref	__AD_Conversion
4012                     	xref	__ADC_Initial
4013                     	xref	__keyScanProcess
4014                     	xref	__displayDecode
4015                     	xref	__keyScan
4016                     	xref	__RTC_Init
4017                     	xref	__timerBase
4018                     	xref	__timerWheel
4019                     	xref	__timer2_Initial
4020                     	xref	__timer1_Initial
4021                     	xref	__timerBaseInitial
4022                     	xref	__Display
4023                     	xref	__configSet
4042                     	end
