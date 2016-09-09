   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3868                     ; 8 int main(void)
3868                     ; 9 {
3870                     	switch	.text
3871  0000               _main:
3873  0000 88            	push	a
3874       00000001      OFST:	set	1
3877                     ; 10 	uchar time_CNT_M = 0;
3879  0001 0f01          	clr	(OFST+0,sp)
3880                     ; 11 	_configSet();	
3882  0003 cd0000        	call	__configSet
3884                     ; 12 	_timerBaseInitial();
3886  0006 cd0000        	call	__timerBaseInitial
3888                     ; 13 	_timer1_Initial();
3890  0009 cd0000        	call	__timer1_Initial
3892                     ; 14 	_timer2_Initial();
3894  000c cd0000        	call	__timer2_Initial
3896                     ; 15 	_RTC_Init();
3898  000f cd0000        	call	__RTC_Init
3900                     ; 16 	_ADC_Initial();
3902  0012 cd0000        	call	__ADC_Initial
3904  0015               L3152:
3905                     ; 29 		_timerBase();
3907  0015 cd0000        	call	__timerBase
3909                     ; 31 		if(isTimeProcess)
3911                     	btst	_isTimeProcess
3912  001d 24f6          	jruge	L3152
3913                     ; 33 			isTimeProcess = No;
3915  001f 72110000      	bres	_isTimeProcess
3916                     ; 35 			_output();
3918  0023 cd0000        	call	__output
3920                     ; 36 			_keyScan();
3922  0026 cd0000        	call	__keyScan
3924                     ; 37 			_timerWheel();
3926  0029 cd0000        	call	__timerWheel
3928                     ; 38 			_displayDecode();
3930  002c cd0000        	call	__displayDecode
3932                     ; 39 			_Display();
3934  002f cd0000        	call	__Display
3936                     ; 40 			_keyScanProcess();
3938  0032 cd0000        	call	__keyScanProcess
3940                     ; 41 			if(++time_CNT_M > 8)
3942  0035 0c01          	inc	(OFST+0,sp)
3943  0037 7b01          	ld	a,(OFST+0,sp)
3944  0039 a109          	cp	a,#9
3945  003b 25d8          	jrult	L3152
3946                     ; 43 				time_CNT_M = 0;
3948  003d 0f01          	clr	(OFST+0,sp)
3949                     ; 44 				_AD_Conversion();
3951  003f cd0000        	call	__AD_Conversion
3953  0042 20d1          	jra	L3152
3966                     	xdef	_main
3967                     	xbit	_isTimeProcess
3968                     	xref	__output
3969                     	xref	__AD_Conversion
3970                     	xref	__ADC_Initial
3971                     	xref	__keyScanProcess
3972                     	xref	__displayDecode
3973                     	xref	__keyScan
3974                     	xref	__RTC_Init
3975                     	xref	__timerBase
3976                     	xref	__timerWheel
3977                     	xref	__timer2_Initial
3978                     	xref	__timer1_Initial
3979                     	xref	__timerBaseInitial
3980                     	xref	__Display
3981                     	xref	__configSet
4000                     	end
