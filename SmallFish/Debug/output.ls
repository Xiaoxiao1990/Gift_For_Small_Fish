   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3788                     	bsct
3789  0000               L7642_time_CNT:
3790  0000 00            	dc.b	0
3858                     ; 8 void beeper(void)
3858                     ; 9 {
3860                     	switch	.text
3861  0000               _beeper:
3865                     ; 14 	if(isBeeper)
3867                     	btst	_isBeeper
3868  0005 2416          	jruge	L5152
3869                     ; 16 		if(time_CNT == 0)BEEP_CSR = 0x2a;//2K
3871  0007 3d00          	tnz	L7642_time_CNT
3872  0009 2604          	jrne	L7152
3875  000b 352a50f3      	mov	_BEEP_CSR,#42
3876  000f               L7152:
3877                     ; 17 		if(++time_CNT > 120)
3879  000f 3c00          	inc	L7642_time_CNT
3880  0011 b600          	ld	a,L7642_time_CNT
3881  0013 a179          	cp	a,#121
3882  0015 250c          	jrult	L3252
3883                     ; 19 			isBeeper = 0;
3885  0017 72110000      	bres	_isBeeper
3886  001b 2006          	jra	L3252
3887  001d               L5152:
3888                     ; 24 		BEEP_CSR = 0x1a; // ¹Ø±Õ·äÃùÆ÷
3890  001d 351a50f3      	mov	_BEEP_CSR,#26
3891                     ; 25 		time_CNT = 0;
3893  0021 3f00          	clr	L7642_time_CNT
3894  0023               L3252:
3895                     ; 27 }
3898  0023 81            	ret
3901                     	bsct
3902  0001               L5252_time_CNT:
3903  0001 00            	dc.b	0
3904  0002               L7252_time_CNT1:
3905  0002 00            	dc.b	0
3906  0003               L1352_grayscale:
3907  0003 0000          	dc.w	0
3964                     ; 29 void LightnessAdjust(void)
3964                     ; 30 {
3965                     	switch	.text
3966  0024               _LightnessAdjust:
3970                     ; 34 	if(!PIR)
3972                     	btst	_PD_IDR_1
3973  0029 2519          	jrult	L1652
3974                     ; 36 		if(++time_CNT1 > 200)
3976  002b 3c02          	inc	L7252_time_CNT1
3977  002d b602          	ld	a,L7252_time_CNT1
3978  002f a1c9          	cp	a,#201
3979  0031 2516          	jrult	L5652
3980                     ; 38 			time_CNT1 = 0;
3982  0033 3f02          	clr	L7252_time_CNT1
3983                     ; 39 			LittleFishWakeUp = 2;//Delay 20S
3985  0035 35020000      	mov	_LittleFishWakeUp,#2
3986                     ; 40 			isPIR = 1;
3988  0039 72100000      	bset	_isPIR
3989                     ; 41 			GrayScale = 500;
3991  003d ae01f4        	ldw	x,#500
3992  0040 bf00          	ldw	_GrayScale,x
3993  0042 2005          	jra	L5652
3994  0044               L1652:
3995                     ; 46 		GrayScale = 0;
3997  0044 5f            	clrw	x
3998  0045 bf00          	ldw	_GrayScale,x
3999                     ; 47 		time_CNT1 = 0;
4001  0047 3f02          	clr	L7252_time_CNT1
4002  0049               L5652:
4003                     ; 51 	if(isCanUpdateGrayScale)
4005                     	btst	_isCanUpdateGrayScale
4006  004e 2446          	jruge	L7652
4007                     ; 53 		if(++time_CNT > 20)//60ms
4009  0050 3c01          	inc	L5252_time_CNT
4010  0052 b601          	ld	a,L5252_time_CNT
4011  0054 a115          	cp	a,#21
4012  0056 253e          	jrult	L7652
4013                     ; 55 			time_CNT = 0;
4015  0058 3f01          	clr	L5252_time_CNT
4016                     ; 56 			if(GrayScale > 500)GrayScale = 500;//check value
4018  005a be00          	ldw	x,_GrayScale
4019  005c a301f5        	cpw	x,#501
4020  005f 2505          	jrult	L3752
4023  0061 ae01f4        	ldw	x,#500
4024  0064 bf00          	ldw	_GrayScale,x
4025  0066               L3752:
4026                     ; 57 			if(grayscale == GrayScale)isCanUpdateGrayScale = 0;
4028  0066 be03          	ldw	x,L1352_grayscale
4029  0068 b300          	cpw	x,_GrayScale
4030  006a 2604          	jrne	L5752
4033  006c 72110000      	bres	_isCanUpdateGrayScale
4034  0070               L5752:
4035                     ; 58 			if(grayscale > GrayScale)grayscale--;
4037  0070 be03          	ldw	x,L1352_grayscale
4038  0072 b300          	cpw	x,_GrayScale
4039  0074 2307          	jrule	L7752
4042  0076 be03          	ldw	x,L1352_grayscale
4043  0078 1d0001        	subw	x,#1
4044  007b bf03          	ldw	L1352_grayscale,x
4045  007d               L7752:
4046                     ; 59 			if(grayscale < GrayScale)grayscale++;
4048  007d be03          	ldw	x,L1352_grayscale
4049  007f b300          	cpw	x,_GrayScale
4050  0081 2407          	jruge	L1062
4053  0083 be03          	ldw	x,L1352_grayscale
4054  0085 1c0001        	addw	x,#1
4055  0088 bf03          	ldw	L1352_grayscale,x
4056  008a               L1062:
4057                     ; 62 			TIM2_CCR2H = grayscale>>8;
4059  008a 5500035313    	mov	_TIM2_CCR2H,L1352_grayscale
4060                     ; 63 			TIM2_CCR2L = grayscale&0xFF;
4062  008f b604          	ld	a,L1352_grayscale+1
4063  0091 a4ff          	and	a,#255
4064  0093 c75314        	ld	_TIM2_CCR2L,a
4065  0096               L7652:
4066                     ; 66 }
4069  0096 81            	ret
4092                     ; 68 void recoder(void)
4092                     ; 69 {
4093                     	switch	.text
4094  0097               _recoder:
4098                     ; 71 }
4101  0097 81            	ret
4126                     ; 73 void _output(void)
4126                     ; 74 {
4127                     	switch	.text
4128  0098               __output:
4132                     ; 75 	beeper();
4134  0098 cd0000        	call	_beeper
4136                     ; 76 	LightnessAdjust();
4138  009b ad87          	call	_LightnessAdjust
4140                     ; 78 }
4143  009d 81            	ret
4156                     	xdef	_recoder
4157                     	xdef	_LightnessAdjust
4158                     	xdef	_beeper
4159                     	xref.b	_LittleFishWakeUp
4160                     	xbit	_isPIR
4161                     	xbit	_isBeeper
4162                     	xbit	_isCanUpdateGrayScale
4163                     	xref.b	_GrayScale
4164                     	xdef	__output
4183                     	end
