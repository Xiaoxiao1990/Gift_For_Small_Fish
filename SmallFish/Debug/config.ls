   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3856                     ; 3 void _configSet(void)
3856                     ; 4 {
3858                     	switch	.text
3859  0000               __configSet:
3863                     ; 17 	PA_DDR = 0B00000110;
3865  0000 35065002      	mov	_PA_DDR,#6
3866                     ; 18 	PA_CR1 = 0B00001110;
3868  0004 350e5003      	mov	_PA_CR1,#14
3869                     ; 19 	PA_CR2 = 0B00000000;
3871  0008 725f5004      	clr	_PA_CR2
3872                     ; 20 	PA_ODR = 0B00000000;
3874  000c 725f5000      	clr	_PA_ODR
3875                     ; 22 	PB_DDR = 0B00010000;
3877  0010 35105007      	mov	_PB_DDR,#16
3878                     ; 23 	PB_CR1 = 0B00010000;
3880  0014 35105008      	mov	_PB_CR1,#16
3881                     ; 24 	PB_CR2 = 0B00000000;
3883  0018 725f5009      	clr	_PB_CR2
3884                     ; 25 	PB_ODR = 0B00010000;
3886  001c 35105005      	mov	_PB_ODR,#16
3887                     ; 27 	PC_DDR = 0B10100000;
3889  0020 35a0500c      	mov	_PC_DDR,#160
3890                     ; 28 	PC_CR1 = 0B11100000;
3892  0024 35e0500d      	mov	_PC_CR1,#224
3893                     ; 29 	PC_CR2 = 0B00000000;
3895  0028 725f500e      	clr	_PC_CR2
3896                     ; 30 	PC_ODR = 0B00000000;
3898  002c 725f500a      	clr	_PC_ODR
3899                     ; 32 	PD_DDR = 0B00101000;
3901  0030 35285011      	mov	_PD_DDR,#40
3902                     ; 33 	PD_CR1 = 0B01101010;
3904  0034 356a5012      	mov	_PD_CR1,#106
3905                     ; 34 	PD_CR2 = 0B00000000;
3907  0038 725f5013      	clr	_PD_CR2
3908                     ; 35 	PD_ODR = 0B00000000;
3910  003c 725f500f      	clr	_PD_ODR
3911                     ; 45 	CLK_SWR = 0xE1; 		//internal clock 16M as main clock
3913  0040 35e150c4      	mov	_CLK_SWR,#225
3914                     ; 46 	CLK_CKDIVR = 0x08;  //fcpu = fmaster = fHSI/2 = 8MHz
3916  0044 350850c6      	mov	_CLK_CKDIVR,#8
3917                     ; 48 	CLK_ICKR = CLK_ICKR | 0x08; // 打开芯片内部的低速振荡器LSI
3919  0048 721650c0      	bset	_CLK_ICKR,#3
3920                     ; 50 }
3923  004c 81            	ret
3936                     	xdef	__configSet
3955                     	end
