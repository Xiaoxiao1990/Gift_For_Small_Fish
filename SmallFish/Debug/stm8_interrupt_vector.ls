   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3844                     ; 13 @far @interrupt void NonHandledInterrupt (void)
3844                     ; 14 {
3845                     	switch	.text
3846  0000               f_NonHandledInterrupt:
3850                     ; 18 	return;
3853  0000 80            	iret
3855                     	bsct
3856  0000               L5052_basicTimeCNT:
3857  0000 00            	dc.b	0
3858  0001               L7052_timeCNT:
3859  0001 00            	dc.b	0
3907                     ; 23 @far @interrupt void TIM1_UPD_IRQHandler (void)
3907                     ; 24 {
3908                     	switch	.text
3909  0001               f_TIM1_UPD_IRQHandler:
3911  0001 be00          	ldw	x,c_x
3912  0003 89            	pushw	x
3915                     ; 29 	TIM1_SR1 = 0x00;          			// 清除更新标志
3917  0004 725f5255      	clr	_TIM1_SR1
3918                     ; 30 	if(++basicTimeCNT > 19)					//20*50ms = 1s
3920  0008 3c00          	inc	L5052_basicTimeCNT
3921  000a b600          	ld	a,L5052_basicTimeCNT
3922  000c a114          	cp	a,#20
3923  000e 250a          	jrult	L3352
3924                     ; 32 		basicTimeCNT = 0;
3926  0010 3f00          	clr	L5052_basicTimeCNT
3927                     ; 33 		isOneSecond = Yes;
3929  0012 72100000      	bset	_isOneSecond
3930                     ; 34 		isFlash1Hz ^= 1;
3932  0016 90100000      	bcpl	_isFlash1Hz
3933  001a               L3352:
3934                     ; 36 	if(basicTimeCNT%10 == 0)
3936  001a b600          	ld	a,L5052_basicTimeCNT
3937  001c 5f            	clrw	x
3938  001d 97            	ld	xl,a
3939  001e a60a          	ld	a,#10
3940  0020 cd0000        	call	c_smodx
3942  0023 a30000        	cpw	x,#0
3943  0026 2608          	jrne	L5352
3944                     ; 38 		is500ms = 1;
3946  0028 72100000      	bset	_is500ms
3947                     ; 39 		isFlash2Hz ^= 1;
3949  002c 90100000      	bcpl	_isFlash2Hz
3950  0030               L5352:
3951                     ; 41 	is50ms = 1;
3953  0030 72100000      	bset	_is50ms
3954                     ; 42 }
3957  0034 85            	popw	x
3958  0035 bf00          	ldw	c_x,x
3959  0037 80            	iret
3961                     .const:	section	.text
3962  0000               __vectab:
3963  0000 82            	dc.b	130
3965  0001 00            	dc.b	page(__stext)
3966  0002 0000          	dc.w	__stext
3967  0004 82            	dc.b	130
3969  0005 00            	dc.b	page(f_NonHandledInterrupt)
3970  0006 0000          	dc.w	f_NonHandledInterrupt
3971  0008 82            	dc.b	130
3973  0009 00            	dc.b	page(f_NonHandledInterrupt)
3974  000a 0000          	dc.w	f_NonHandledInterrupt
3975  000c 82            	dc.b	130
3977  000d 00            	dc.b	page(f_NonHandledInterrupt)
3978  000e 0000          	dc.w	f_NonHandledInterrupt
3979  0010 82            	dc.b	130
3981  0011 00            	dc.b	page(f_NonHandledInterrupt)
3982  0012 0000          	dc.w	f_NonHandledInterrupt
3983  0014 82            	dc.b	130
3985  0015 00            	dc.b	page(f_NonHandledInterrupt)
3986  0016 0000          	dc.w	f_NonHandledInterrupt
3987  0018 82            	dc.b	130
3989  0019 00            	dc.b	page(f_NonHandledInterrupt)
3990  001a 0000          	dc.w	f_NonHandledInterrupt
3991  001c 82            	dc.b	130
3993  001d 00            	dc.b	page(f_NonHandledInterrupt)
3994  001e 0000          	dc.w	f_NonHandledInterrupt
3995  0020 82            	dc.b	130
3997  0021 00            	dc.b	page(f_NonHandledInterrupt)
3998  0022 0000          	dc.w	f_NonHandledInterrupt
3999  0024 82            	dc.b	130
4001  0025 00            	dc.b	page(f_NonHandledInterrupt)
4002  0026 0000          	dc.w	f_NonHandledInterrupt
4003  0028 82            	dc.b	130
4005  0029 00            	dc.b	page(f_NonHandledInterrupt)
4006  002a 0000          	dc.w	f_NonHandledInterrupt
4007  002c 82            	dc.b	130
4009  002d 00            	dc.b	page(f_NonHandledInterrupt)
4010  002e 0000          	dc.w	f_NonHandledInterrupt
4011  0030 82            	dc.b	130
4013  0031 00            	dc.b	page(f_NonHandledInterrupt)
4014  0032 0000          	dc.w	f_NonHandledInterrupt
4015  0034 82            	dc.b	130
4017  0035 01            	dc.b	page(f_TIM1_UPD_IRQHandler)
4018  0036 0001          	dc.w	f_TIM1_UPD_IRQHandler
4019  0038 82            	dc.b	130
4021  0039 00            	dc.b	page(f_NonHandledInterrupt)
4022  003a 0000          	dc.w	f_NonHandledInterrupt
4023  003c 82            	dc.b	130
4025  003d 00            	dc.b	page(f_NonHandledInterrupt)
4026  003e 0000          	dc.w	f_NonHandledInterrupt
4027  0040 82            	dc.b	130
4029  0041 00            	dc.b	page(f_NonHandledInterrupt)
4030  0042 0000          	dc.w	f_NonHandledInterrupt
4031  0044 82            	dc.b	130
4033  0045 00            	dc.b	page(f_NonHandledInterrupt)
4034  0046 0000          	dc.w	f_NonHandledInterrupt
4035  0048 82            	dc.b	130
4037  0049 00            	dc.b	page(f_NonHandledInterrupt)
4038  004a 0000          	dc.w	f_NonHandledInterrupt
4039  004c 82            	dc.b	130
4041  004d 00            	dc.b	page(f_NonHandledInterrupt)
4042  004e 0000          	dc.w	f_NonHandledInterrupt
4043  0050 82            	dc.b	130
4045  0051 00            	dc.b	page(f_NonHandledInterrupt)
4046  0052 0000          	dc.w	f_NonHandledInterrupt
4047  0054 82            	dc.b	130
4049  0055 00            	dc.b	page(f_NonHandledInterrupt)
4050  0056 0000          	dc.w	f_NonHandledInterrupt
4051  0058 82            	dc.b	130
4053  0059 00            	dc.b	page(f_NonHandledInterrupt)
4054  005a 0000          	dc.w	f_NonHandledInterrupt
4055  005c 82            	dc.b	130
4057  005d 00            	dc.b	page(f_NonHandledInterrupt)
4058  005e 0000          	dc.w	f_NonHandledInterrupt
4059  0060 82            	dc.b	130
4061  0061 00            	dc.b	page(f_NonHandledInterrupt)
4062  0062 0000          	dc.w	f_NonHandledInterrupt
4063  0064 82            	dc.b	130
4065  0065 00            	dc.b	page(f_NonHandledInterrupt)
4066  0066 0000          	dc.w	f_NonHandledInterrupt
4067  0068 82            	dc.b	130
4069  0069 00            	dc.b	page(f_NonHandledInterrupt)
4070  006a 0000          	dc.w	f_NonHandledInterrupt
4071  006c 82            	dc.b	130
4073  006d 00            	dc.b	page(f_NonHandledInterrupt)
4074  006e 0000          	dc.w	f_NonHandledInterrupt
4075  0070 82            	dc.b	130
4077  0071 00            	dc.b	page(f_NonHandledInterrupt)
4078  0072 0000          	dc.w	f_NonHandledInterrupt
4079  0074 82            	dc.b	130
4081  0075 00            	dc.b	page(f_NonHandledInterrupt)
4082  0076 0000          	dc.w	f_NonHandledInterrupt
4083  0078 82            	dc.b	130
4085  0079 00            	dc.b	page(f_NonHandledInterrupt)
4086  007a 0000          	dc.w	f_NonHandledInterrupt
4087  007c 82            	dc.b	130
4089  007d 00            	dc.b	page(f_NonHandledInterrupt)
4090  007e 0000          	dc.w	f_NonHandledInterrupt
4141                     	xdef	__vectab
4142                     	xdef	f_TIM1_UPD_IRQHandler
4143                     	xref	__stext
4144                     	xdef	f_NonHandledInterrupt
4145                     	xbit	_isFlash2Hz
4146                     	xbit	_isFlash1Hz
4147                     	xbit	_is50ms
4148                     	xbit	_is500ms
4149                     	xbit	_isOneSecond
4150                     	xref.b	c_x
4169                     	xref	c_smodx
4170                     	end
