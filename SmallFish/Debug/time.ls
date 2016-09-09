   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3845                     ; 3 void _timerBaseInitial(void)
3845                     ; 4 {
3847                     	switch	.text
3848  0000               __timerBaseInitial:
3852                     ; 5 	TIM4_IER = 0x00; // disable interrup
3854  0000 725f5343      	clr	_TIM4_IER
3855                     ; 6 	TIM4_EGR = 0x01; // enable update
3857  0004 35015345      	mov	_TIM4_EGR,#1
3858                     ; 7 	TIM4_PSCR = 2; // timerclock=manclock/64=8MHZ/64=8us
3860  0008 35025347      	mov	_TIM4_PSCR,#2
3861                     ; 8 	TIM4_ARR = 255; // set reload resister
3863  000c 35ff5348      	mov	_TIM4_ARR,#255
3864                     ; 9 	TIM4_CNTR = 255; // set conter initial,cycle time=(ARR+1)*16=2.048ms
3866  0010 35ff5346      	mov	_TIM4_CNTR,#255
3867                     ; 10 	TIM4_CR1 = 0x01; // b0 = 1,enable timer 4,b1 = 0, enable update
3869  0014 35015340      	mov	_TIM4_CR1,#1
3870                     ; 11 }
3873  0018 81            	ret
3903                     ; 13 void _timer1_Initial(void)
3903                     ; 14 {
3904                     	switch	.text
3905  0019               __timer1_Initial:
3909                     ; 16 	_asm("sim");
3912  0019 9b            sim
3914                     ; 17 	TIM1_PSCRH = 0;
3916  001a 725f5260      	clr	_TIM1_PSCRH
3917                     ; 18 	TIM1_PSCRL = 2;    //(fCK_CNT)等于fCK_PSC/( PSCR[15:0]+1)
3919  001e 35025261      	mov	_TIM1_PSCRL,#2
3920                     ; 19 	TIM1_CNTRH = 0xc3;
3922  0022 35c3525e      	mov	_TIM1_CNTRH,#195
3923                     ; 20 	TIM1_CNTRL = 0x50;//计数寄存器的值
3925  0026 3550525f      	mov	_TIM1_CNTRL,#80
3926                     ; 21 	TIM1_IER = 0x01;//允许更新中断
3928  002a 35015254      	mov	_TIM1_IER,#1
3929                     ; 22 	TIM1_RCR = 0;//重复计数寄存器值 
3931  002e 725f5264      	clr	_TIM1_RCR
3932                     ; 23 	TIM1_CR1 = 0x01;//打开自动装载，打开计数器
3934  0032 35015250      	mov	_TIM1_CR1,#1
3935                     ; 24 	_asm("rim");                // 允许CPU全局中断
3938  0036 9a            rim
3940                     ; 25 }
3943  0037 81            	ret
3974                     ; 27 void _timer2_Initial(void)
3974                     ; 28 {
3975                     	switch	.text
3976  0038               __timer2_Initial:
3980                     ; 29 	TIM2_CCMR2 = 0x60;
3982  0038 35605308      	mov	_TIM2_CCMR2,#96
3983                     ; 33 	TIM2_CCER1 = 0x10;
3985  003c 3510530a      	mov	_TIM2_CCER1,#16
3986                     ; 38 	TIM2_PSCR = 0x00;//Fmaster/2^n = 8M/2^0 = 8MHz
3988  0040 725f530e      	clr	_TIM2_PSCR
3989                     ; 45 	TIM2_ARRH = 0x01;
3991  0044 3501530f      	mov	_TIM2_ARRH,#1
3992                     ; 46 	TIM2_ARRL = 0xF4;
3994  0048 35f45310      	mov	_TIM2_ARRL,#244
3995                     ; 48 	TIM2_CCR2H = 0x00;
3997  004c 725f5313      	clr	_TIM2_CCR2H
3998                     ; 49 	TIM2_CCR2L = 0x00;
4000  0050 725f5314      	clr	_TIM2_CCR2L
4001                     ; 54 	TIM2_CR1 |= 0x01;//启动计数器
4003  0054 72105300      	bset	_TIM2_CR1,#0
4004                     ; 55 }
4007  0058 81            	ret
4032                     ; 57 void _timerBase(void)		//2.048ms
4032                     ; 58 {											
4033                     	switch	.text
4034  0059               __timerBase:
4038                     ; 59 	if (bitTIM4_SR1_UIF) // 
4040                     	btst	_bitTIM4_SR1_UIF
4041  005e 2408          	jruge	L5352
4042                     ; 61 		bitTIM4_SR1_UIF = 0; 
4044  0060 72115344      	bres	_bitTIM4_SR1_UIF
4045                     ; 62 		isTimeProcess = Yes;
4047  0064 72100000      	bset	_isTimeProcess
4048  0068               L5352:
4049                     ; 64 }
4052  0068 81            	ret
4092                     ; 66 void updateGrayScale(void)
4092                     ; 67 {
4093                     	switch	.text
4094  0069               _updateGrayScale:
4096  0069 89            	pushw	x
4097       00000002      OFST:	set	2
4100                     ; 69 	if(LightnessMode < 1)return;//Lightness adjust by manual
4102  006a 3d00          	tnz	_LightnessMode
4103  006c 2762          	jreq	L61
4106                     ; 70 	if(!isCanUpdateGrayScale)
4108                     	btst	_isCanUpdateGrayScale
4109  0073 255b          	jrult	L7552
4110                     ; 72 		isCanUpdateGrayScale = 1;
4112  0075 72100000      	bset	_isCanUpdateGrayScale
4113                     ; 73 		lightness = LightValue>>1;//LightValue:10(ON)~1000(OFF);
4115  0079 be00          	ldw	x,_LightValue
4116  007b 54            	srlw	x
4117  007c 1f01          	ldw	(OFST-1,sp),x
4118                     ; 74 		if(lightness > 499)lightness = 499;//0%
4120  007e 1e01          	ldw	x,(OFST-1,sp)
4121  0080 a301f4        	cpw	x,#500
4122  0083 2505          	jrult	L1652
4125  0085 ae01f3        	ldw	x,#499
4126  0088 1f01          	ldw	(OFST-1,sp),x
4127  008a               L1652:
4128                     ; 75 		if(lightness < 30)lightness = 0;//100%
4130  008a 1e01          	ldw	x,(OFST-1,sp)
4131  008c a3001e        	cpw	x,#30
4132  008f 2403          	jruge	L3652
4135  0091 5f            	clrw	x
4136  0092 1f01          	ldw	(OFST-1,sp),x
4137  0094               L3652:
4138                     ; 77 		if(isPIR)//Detected Small Fish
4140                     	btst	_isPIR
4141  0099 2431          	jruge	L5652
4142                     ; 80 			if((LightValue > 800)||(Now.Hour < 7 || Now.Hour >= 21))
4144  009b be00          	ldw	x,_LightValue
4145  009d a30321        	cpw	x,#801
4146  00a0 240c          	jruge	L1752
4148  00a2 b600          	ld	a,_Now
4149  00a4 a107          	cp	a,#7
4150  00a6 2506          	jrult	L1752
4152  00a8 b600          	ld	a,_Now
4153  00aa a115          	cp	a,#21
4154  00ac 2510          	jrult	L7652
4155  00ae               L1752:
4156                     ; 83 				if(GrayScale < 250)GrayScale += 10;//渐亮到一半
4158  00ae be00          	ldw	x,_GrayScale
4159  00b0 a300fa        	cpw	x,#250
4160  00b3 2417          	jruge	L5652
4163  00b5 be00          	ldw	x,_GrayScale
4164  00b7 1c000a        	addw	x,#10
4165  00ba bf00          	ldw	_GrayScale,x
4166  00bc 200e          	jra	L5652
4167  00be               L7652:
4168                     ; 87 				if(GrayScale < 500)GrayScale += 20;//渐亮到一半
4170  00be be00          	ldw	x,_GrayScale
4171  00c0 a301f4        	cpw	x,#500
4172  00c3 2407          	jruge	L5652
4175  00c5 be00          	ldw	x,_GrayScale
4176  00c7 1c0014        	addw	x,#20
4177  00ca bf00          	ldw	_GrayScale,x
4178  00cc               L5652:
4179                     ; 90 		GrayScale = lightness;
4181  00cc 1e01          	ldw	x,(OFST-1,sp)
4182  00ce bf00          	ldw	_GrayScale,x
4183  00d0               L7552:
4184                     ; 92 }
4185  00d0               L61:
4188  00d0 85            	popw	x
4189  00d1 81            	ret
4192                     	bsct
4193  0000               L3062_timeCNT:
4194  0000 00            	dc.b	0
4238                     ; 94 void _timerWheel(void)
4238                     ; 95 {
4239                     	switch	.text
4240  00d2               __timerWheel:
4244                     ; 97 	if(is500ms)
4246                     	btst	_is500ms
4247  00d7 2407          	jruge	L3262
4248                     ; 99 		is500ms = 0;
4250  00d9 72110000      	bres	_is500ms
4251                     ; 100 		_getTime();
4253  00dd cd0000        	call	__getTime
4255  00e0               L3262:
4256                     ; 102 	if(isOneSecond)//500ms
4258                     	btst	_isOneSecond
4259  00e5 2449          	jruge	L5262
4260                     ; 104 		isOneSecond = Clear;
4262  00e7 72110000      	bres	_isOneSecond
4263                     ; 105 		isUpdateDisplay = Yes;
4265  00eb 72100000      	bset	_isUpdateDisplay
4266                     ; 107 		updateGrayScale();
4268  00ef cd0069        	call	_updateGrayScale
4270                     ; 108 		if(LittleFishWakeUp > 0)LittleFishWakeUp--;
4272  00f2 3d00          	tnz	_LittleFishWakeUp
4273  00f4 2704          	jreq	L7262
4276  00f6 3a00          	dec	_LittleFishWakeUp
4278  00f8 2004          	jra	L1362
4279  00fa               L7262:
4280                     ; 111 			isPIR = 0;
4282  00fa 72110000      	bres	_isPIR
4283  00fe               L1362:
4284                     ; 113 		if(++timeCNT < 10)DisplayMode = 0;
4286  00fe 3c00          	inc	L3062_timeCNT
4287  0100 b600          	ld	a,L3062_timeCNT
4288  0102 a10a          	cp	a,#10
4289  0104 2404          	jruge	L3362
4292  0106 3f00          	clr	_DisplayMode
4294  0108 200e          	jra	L5362
4295  010a               L3362:
4296                     ; 114 		else if(timeCNT < 20)DisplayMode = 1;
4298  010a b600          	ld	a,L3062_timeCNT
4299  010c a114          	cp	a,#20
4300  010e 2406          	jruge	L7362
4303  0110 35010000      	mov	_DisplayMode,#1
4305  0114 2002          	jra	L5362
4306  0116               L7362:
4307                     ; 115 		else timeCNT = 0;
4309  0116 3f00          	clr	L3062_timeCNT
4310  0118               L5362:
4311                     ; 117 		if(MachineStatus >= SETTING)
4313  0118 b600          	ld	a,_MachineStatus
4314  011a a102          	cp	a,#2
4315  011c 2512          	jrult	L5262
4316                     ; 119 			if(++inSetTimer > 25)
4318  011e 3c00          	inc	_inSetTimer
4319  0120 b600          	ld	a,_inSetTimer
4320  0122 a11a          	cp	a,#26
4321  0124 250a          	jrult	L5262
4322                     ; 121 				isInSetting = 0;
4324  0126 72110000      	bres	_isInSetting
4325                     ; 122 				inSetTimer = 0;
4327  012a 3f00          	clr	_inSetTimer
4328                     ; 123 				MachineStatus = IDEL;
4330  012c 3f00          	clr	_MachineStatus
4331                     ; 124 				SetStep = 0;
4333  012e 3f00          	clr	_SetStep
4334  0130               L5262:
4335                     ; 129 }
4338  0130 81            	ret
4351                     	xdef	_updateGrayScale
4352                     	xref.b	_LightnessMode
4353                     	xref.b	_LittleFishWakeUp
4354                     	xbit	_isPIR
4355                     	xbit	_isCanUpdateGrayScale
4356                     	xref.b	_GrayScale
4357                     	xref.b	_LightValue
4358                     	xbit	_isInSetting
4359                     	xbit	_isTimeProcess
4360                     	xref.b	_SetStep
4361                     	xref.b	_MachineStatus
4362                     	xref.b	_inSetTimer
4363                     	xbit	_is500ms
4364                     	xbit	_isOneSecond
4365                     	xbit	_isUpdateDisplay
4366                     	xref.b	_DisplayMode
4367                     	xref.b	_Now
4368                     	xref	__getTime
4369                     	xdef	__timerBase
4370                     	xdef	__timerWheel
4371                     	xdef	__timer2_Initial
4372                     	xdef	__timer1_Initial
4373                     	xdef	__timerBaseInitial
4392                     	end
