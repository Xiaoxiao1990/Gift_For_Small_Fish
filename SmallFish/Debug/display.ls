   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3788                     .const:	section	.text
3789  0000               _LEDCode:
3790  0000 3f            	dc.b	63
3791  0001 06            	dc.b	6
3792  0002 5b            	dc.b	91
3793  0003 4f            	dc.b	79
3794  0004 66            	dc.b	102
3795  0005 6d            	dc.b	109
3796  0006 7d            	dc.b	125
3797  0007 07            	dc.b	7
3798  0008 7f            	dc.b	127
3799  0009 6f            	dc.b	111
3800  000a 40            	dc.b	64
3801  000b 71            	dc.b	113
3802  000c 61            	dc.b	97
3803  000d 76            	dc.b	118
3804  000e 73            	dc.b	115
3805  000f 00            	dc.b	0
3806  0010 37            	dc.b	55
3807  0011 46            	dc.b	70
3808  0012 1c            	dc.b	28
3809  0013 54            	dc.b	84
3810  0014 77            	dc.b	119
3811  0015 79            	dc.b	121
3812  0016 39            	dc.b	57
3813  0017               _BIT_CODE:
3814  0017 fe            	dc.b	254
3815  0018 fd            	dc.b	253
3816  0019 fb            	dc.b	251
3817  001a f7            	dc.b	247
3818  001b ef            	dc.b	239
3819  001c df            	dc.b	223
3820  001d 7f            	dc.b	127
3821  001e bf            	dc.b	191
3822  001f ff            	dc.b	255
3892                     ; 42 void tempdecode(signed int temp)
3892                     ; 43 {
3894                     	switch	.text
3895  0000               _tempdecode:
3897  0000 89            	pushw	x
3898       00000000      OFST:	set	0
3901                     ; 44 	if(temp < 0)
3903  0001 9c            	rvf
3904  0002 a30000        	cpw	x,#0
3905  0005 2e56          	jrsge	L3152
3906                     ; 46 		if(temp > -100)
3908  0007 9c            	rvf
3909  0008 a3ff9d        	cpw	x,#65437
3910  000b 2f27          	jrslt	L5152
3911                     ; 48 			LED_Buf[0] = LEDCode[0x0A];//-
3913  000d 35400000      	mov	_LED_Buf,#64
3914                     ; 49 			LED_Buf[1] = LEDCode[-temp%100/10]|0x80;//with dot
3916  0011 50            	negw	x
3917  0012 a664          	ld	a,#100
3918  0014 cd0000        	call	c_smodx
3920  0017 a60a          	ld	a,#10
3921  0019 cd0000        	call	c_sdivx
3923  001c d60000        	ld	a,(_LEDCode,x)
3924  001f aa80          	or	a,#128
3925  0021 b701          	ld	_LED_Buf+1,a
3926                     ; 50 			LED_Buf[2] = LEDCode[-temp%10];
3928  0023 1e01          	ldw	x,(OFST+1,sp)
3929  0025 50            	negw	x
3930  0026 a60a          	ld	a,#10
3931  0028 cd0000        	call	c_smodx
3933  002b d60000        	ld	a,(_LEDCode,x)
3934  002e b702          	ld	_LED_Buf+2,a
3936  0030 aceb00eb      	jpf	L1252
3937  0034               L5152:
3938                     ; 54 			LED_Buf[0] = LEDCode[0x11];//-1
3940  0034 35460000      	mov	_LED_Buf,#70
3941                     ; 55 			LED_Buf[1] = LEDCode[-temp%100/10]|0x80;//without dot
3943  0038 1e01          	ldw	x,(OFST+1,sp)
3944  003a 50            	negw	x
3945  003b a664          	ld	a,#100
3946  003d cd0000        	call	c_smodx
3948  0040 a60a          	ld	a,#10
3949  0042 cd0000        	call	c_sdivx
3951  0045 d60000        	ld	a,(_LEDCode,x)
3952  0048 aa80          	or	a,#128
3953  004a b701          	ld	_LED_Buf+1,a
3954                     ; 56 			LED_Buf[2] = LEDCode[-temp%10];
3956  004c 1e01          	ldw	x,(OFST+1,sp)
3957  004e 50            	negw	x
3958  004f a60a          	ld	a,#10
3959  0051 cd0000        	call	c_smodx
3961  0054 d60000        	ld	a,(_LEDCode,x)
3962  0057 b702          	ld	_LED_Buf+2,a
3963  0059 aceb00eb      	jpf	L1252
3964  005d               L3152:
3965                     ; 61 		if(temp > 999)
3967  005d 9c            	rvf
3968  005e 1e01          	ldw	x,(OFST+1,sp)
3969  0060 a303e8        	cpw	x,#1000
3970  0063 2f30          	jrslt	L3252
3971                     ; 63 			LED_Buf[0] = LEDCode[temp/1000];
3973  0065 1e01          	ldw	x,(OFST+1,sp)
3974  0067 90ae03e8      	ldw	y,#1000
3975  006b cd0000        	call	c_idiv
3977  006e d60000        	ld	a,(_LEDCode,x)
3978  0071 b700          	ld	_LED_Buf,a
3979                     ; 64 			LED_Buf[1] = LEDCode[temp%1000/100];
3981  0073 1e01          	ldw	x,(OFST+1,sp)
3982  0075 90ae03e8      	ldw	y,#1000
3983  0079 cd0000        	call	c_idiv
3985  007c 51            	exgw	x,y
3986  007d a664          	ld	a,#100
3987  007f cd0000        	call	c_sdivx
3989  0082 d60000        	ld	a,(_LEDCode,x)
3990  0085 b701          	ld	_LED_Buf+1,a
3991                     ; 65 			LED_Buf[2] = LEDCode[temp/10];
3993  0087 1e01          	ldw	x,(OFST+1,sp)
3994  0089 a60a          	ld	a,#10
3995  008b cd0000        	call	c_sdivx
3997  008e d60000        	ld	a,(_LEDCode,x)
3998  0091 b702          	ld	_LED_Buf+2,a
4000  0093 2056          	jra	L1252
4001  0095               L3252:
4002                     ; 67 		else if(temp < 100)
4004  0095 9c            	rvf
4005  0096 1e01          	ldw	x,(OFST+1,sp)
4006  0098 a30064        	cpw	x,#100
4007  009b 2e23          	jrsge	L7252
4008                     ; 69 			LED_Buf[0] = LEDCode[0x0F];//Null
4010  009d 3f00          	clr	_LED_Buf
4011                     ; 70 			LED_Buf[1] = LEDCode[temp%100/10]|0x80;
4013  009f 1e01          	ldw	x,(OFST+1,sp)
4014  00a1 a664          	ld	a,#100
4015  00a3 cd0000        	call	c_smodx
4017  00a6 a60a          	ld	a,#10
4018  00a8 cd0000        	call	c_sdivx
4020  00ab d60000        	ld	a,(_LEDCode,x)
4021  00ae aa80          	or	a,#128
4022  00b0 b701          	ld	_LED_Buf+1,a
4023                     ; 71 			LED_Buf[2] = LEDCode[temp%10];
4025  00b2 1e01          	ldw	x,(OFST+1,sp)
4026  00b4 a60a          	ld	a,#10
4027  00b6 cd0000        	call	c_smodx
4029  00b9 d60000        	ld	a,(_LEDCode,x)
4030  00bc b702          	ld	_LED_Buf+2,a
4032  00be 202b          	jra	L1252
4033  00c0               L7252:
4034                     ; 75 			LED_Buf[0] = LEDCode[temp/100];
4036  00c0 1e01          	ldw	x,(OFST+1,sp)
4037  00c2 a664          	ld	a,#100
4038  00c4 cd0000        	call	c_sdivx
4040  00c7 d60000        	ld	a,(_LEDCode,x)
4041  00ca b700          	ld	_LED_Buf,a
4042                     ; 76 			LED_Buf[1] = LEDCode[temp%100/10]|0x80;
4044  00cc 1e01          	ldw	x,(OFST+1,sp)
4045  00ce a664          	ld	a,#100
4046  00d0 cd0000        	call	c_smodx
4048  00d3 a60a          	ld	a,#10
4049  00d5 cd0000        	call	c_sdivx
4051  00d8 d60000        	ld	a,(_LEDCode,x)
4052  00db aa80          	or	a,#128
4053  00dd b701          	ld	_LED_Buf+1,a
4054                     ; 77 			LED_Buf[2] = LEDCode[temp%10];
4056  00df 1e01          	ldw	x,(OFST+1,sp)
4057  00e1 a60a          	ld	a,#10
4058  00e3 cd0000        	call	c_smodx
4060  00e6 d60000        	ld	a,(_LEDCode,x)
4061  00e9 b702          	ld	_LED_Buf+2,a
4062  00eb               L1252:
4063                     ; 80 	LED_Buf[3] = LEDCode[0x0C];//c
4065  00eb 35610003      	mov	_LED_Buf+3,#97
4066                     ; 81 	LED_Buf[4] = LED_Buf[5] = LEDCode[0x0F];//Null;
4068  00ef 3f05          	clr	_LED_Buf+5
4069  00f1 3f04          	clr	_LED_Buf+4
4070                     ; 82 	LED_Buf[6] = BIT_CODE[6];//Temp Dot  ON:6,OFF:8 
4072  00f3 357f0006      	mov	_LED_Buf+6,#127
4073                     ; 83 	LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
4075  00f7 35ff0007      	mov	_LED_Buf+7,#255
4076                     ; 84 }
4079  00fb 85            	popw	x
4080  00fc 81            	ret
4149                     ; 85 void timedecode(Time_TypeDef *Time)
4149                     ; 86 {
4150                     	switch	.text
4151  00fd               _timedecode:
4153  00fd 89            	pushw	x
4154       00000000      OFST:	set	0
4157                     ; 88 	LED_Buf[0] = LEDCode[Time->Hour/10];//Null
4159  00fe f6            	ld	a,(x)
4160  00ff 5f            	clrw	x
4161  0100 97            	ld	xl,a
4162  0101 a60a          	ld	a,#10
4163  0103 cd0000        	call	c_sdivx
4165  0106 d60000        	ld	a,(_LEDCode,x)
4166  0109 b700          	ld	_LED_Buf,a
4167                     ; 89 	LED_Buf[1] = LEDCode[Time->Hour%10];//Null
4169  010b 1e01          	ldw	x,(OFST+1,sp)
4170  010d f6            	ld	a,(x)
4171  010e 5f            	clrw	x
4172  010f 97            	ld	xl,a
4173  0110 a60a          	ld	a,#10
4174  0112 cd0000        	call	c_smodx
4176  0115 d60000        	ld	a,(_LEDCode,x)
4177  0118 b701          	ld	_LED_Buf+1,a
4178                     ; 90 	LED_Buf[2] = LEDCode[Time->Minute/10];//Null
4180  011a 1e01          	ldw	x,(OFST+1,sp)
4181  011c e601          	ld	a,(1,x)
4182  011e 5f            	clrw	x
4183  011f 97            	ld	xl,a
4184  0120 a60a          	ld	a,#10
4185  0122 cd0000        	call	c_sdivx
4187  0125 d60000        	ld	a,(_LEDCode,x)
4188  0128 b702          	ld	_LED_Buf+2,a
4189                     ; 91 	LED_Buf[3] = LEDCode[Time->Minute%10];//Null
4191  012a 1e01          	ldw	x,(OFST+1,sp)
4192  012c e601          	ld	a,(1,x)
4193  012e 5f            	clrw	x
4194  012f 97            	ld	xl,a
4195  0130 a60a          	ld	a,#10
4196  0132 cd0000        	call	c_smodx
4198  0135 d60000        	ld	a,(_LEDCode,x)
4199  0138 b703          	ld	_LED_Buf+3,a
4200                     ; 92 	LED_Buf[4] = LEDCode[Time->Second/10];//Null
4202  013a 1e01          	ldw	x,(OFST+1,sp)
4203  013c e602          	ld	a,(2,x)
4204  013e 5f            	clrw	x
4205  013f 97            	ld	xl,a
4206  0140 a60a          	ld	a,#10
4207  0142 cd0000        	call	c_sdivx
4209  0145 d60000        	ld	a,(_LEDCode,x)
4210  0148 b704          	ld	_LED_Buf+4,a
4211                     ; 93 	LED_Buf[5] = LEDCode[Time->Second%10];//Null
4213  014a 1e01          	ldw	x,(OFST+1,sp)
4214  014c e602          	ld	a,(2,x)
4215  014e 5f            	clrw	x
4216  014f 97            	ld	xl,a
4217  0150 a60a          	ld	a,#10
4218  0152 cd0000        	call	c_smodx
4220  0155 d60000        	ld	a,(_LEDCode,x)
4221  0158 b705          	ld	_LED_Buf+5,a
4222                     ; 95 	LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
4224  015a 35ff0006      	mov	_LED_Buf+6,#255
4225                     ; 96 	LED_Buf[7] = (isFlash1Hz)?BIT_CODE[7]:BIT_CODE[8];//Time Dot  ON:7,OFF:8
4227                     	btst	_isFlash1Hz
4228  0163 2404          	jruge	L01
4229  0165 a6bf          	ld	a,#191
4230  0167 2002          	jra	L21
4231  0169               L01:
4232  0169 a6ff          	ld	a,#255
4233  016b               L21:
4234  016b b707          	ld	_LED_Buf+7,a
4235                     ; 97 }
4238  016d 85            	popw	x
4239  016e 81            	ret
4274                     ; 99 uchar rand(uchar cnt)
4274                     ; 100 {
4275                     	switch	.text
4276  016f               _rand:
4280                     ; 101 	return (uchar)RandSeed%cnt;
4282  016f 5f            	clrw	x
4283  0170 97            	ld	xl,a
4284  0171 b601          	ld	a,_RandSeed+1
4285  0173 51            	exgw	x,y
4286  0174 5f            	clrw	x
4287  0175 97            	ld	xl,a
4288  0176 65            	divw	x,y
4289  0177 909f          	ld	a,yl
4292  0179 81            	ret
4295                     	bsct
4296  0000               L3062_dismode:
4297  0000 0000          	dc.w	0
4298  0002               L7062_timeCNT1:
4299  0002 00            	dc.b	0
4300  0003               L1162_step:
4301  0003 00            	dc.b	0
4302  0004               L3162_CNT:
4303  0004 00            	dc.b	0
4304  0005               L5162_direct:
4305  0005 00            	dc.b	0
4306  0006               L7162_rollCNT:
4307  0006 00            	dc.b	0
4308                     .bit:	section	.data,bit
4309  0000               L1262_isChangeContent:
4310  0000 00            	dc.b	0
4311                     	bsct
4312  0007               L3262_timeCNT:
4313  0007 0000          	dc.w	0
4314                     	switch	.const
4315  0020               L5262_masktbl:
4316  0020 01            	dc.b	1
4317  0021 22            	dc.b	34
4318  0022 40            	dc.b	64
4319  0023 14            	dc.b	20
4320  0024 08            	dc.b	8
4321  0025 80            	dc.b	128
4322                     	switch	.ubsct
4323  0000               L5062_buf:
4324  0000 000000000000  	ds.b	7
4468                     ; 111 void displayStyle(void)
4468                     ; 112 {
4469                     	switch	.text
4470  017a               _displayStyle:
4472  017a 520c          	subw	sp,#12
4473       0000000c      OFST:	set	12
4476                     ; 121 	uchar masktbl[] = {
4476                     ; 122 		0B00000001,//a
4476                     ; 123 		0B00100010,//b,f
4476                     ; 124 		0B01000000,//g
4476                     ; 125 		0B00010100,//d,e
4476                     ; 126 		0B00001000,//c
4476                     ; 127 		0B10000000 //dp
4476                     ; 128 	};
4478  017c 96            	ldw	x,sp
4479  017d 1c0004        	addw	x,#OFST-8
4480  0180 90ae0020      	ldw	y,#L5262_masktbl
4481  0184 a606          	ld	a,#6
4482  0186 cd0000        	call	c_xymvx
4484                     ; 129 	switch(dismode)
4486  0189 be00          	ldw	x,L3062_dismode
4488                     ; 493 		default:;
4489  018b 5d            	tnzw	x
4490  018c 2716          	jreq	L7262
4491  018e 5a            	decw	x
4492  018f 2603          	jrne	L06
4493  0191 cc0306        	jp	L1462
4494  0194               L06:
4495  0194 5a            	decw	x
4496  0195 2603          	jrne	L26
4497  0197 cc0454        	jp	L3562
4498  019a               L26:
4499  019a 5a            	decw	x
4500  019b 2603          	jrne	L46
4501  019d cc0610        	jp	L5662
4502  01a0               L46:
4503  01a0 ac3c073c      	jpf	L5772
4504  01a4               L7262:
4505                     ; 133 			switch(step)
4507  01a4 b603          	ld	a,L1162_step
4509                     ; 211 				default:step = 0;
4510  01a6 4d            	tnz	a
4511  01a7 270f          	jreq	L1362
4512  01a9 4a            	dec	a
4513  01aa 2758          	jreq	L3362
4514  01ac 4a            	dec	a
4515  01ad 2603          	jrne	L66
4516  01af cc0298        	jp	L5362
4517  01b2               L66:
4518  01b2               L7362:
4521  01b2 3f03          	clr	L1162_step
4522  01b4 ac3c073c      	jpf	L5772
4523  01b8               L1362:
4524                     ; 137 					if(!isChangeContent)timedecode(&Now);
4526                     	btst	L1262_isChangeContent
4527  01bd 2508          	jrult	L3003
4530  01bf ae0000        	ldw	x,#_Now
4531  01c2 cd00fd        	call	_timedecode
4534  01c5 2005          	jra	L5003
4535  01c7               L3003:
4536                     ; 138 					else tempdecode(CurrentTemp);
4538  01c7 be00          	ldw	x,_CurrentTemp
4539  01c9 cd0000        	call	_tempdecode
4541  01cc               L5003:
4542                     ; 140 					for(i = 0;i < 8;i++)
4544  01cc 0f0c          	clr	(OFST+0,sp)
4545  01ce               L7003:
4546                     ; 142 						buf[i] = LED_Buf[i];
4548  01ce 7b0c          	ld	a,(OFST+0,sp)
4549  01d0 5f            	clrw	x
4550  01d1 97            	ld	xl,a
4551  01d2 e600          	ld	a,(_LED_Buf,x)
4552  01d4 e700          	ld	(L5062_buf,x),a
4553                     ; 143 						LED_Buf[i] = LEDCode[0x0f];//Null clear
4555  01d6 7b0c          	ld	a,(OFST+0,sp)
4556  01d8 5f            	clrw	x
4557  01d9 97            	ld	xl,a
4558  01da 6f00          	clr	(_LED_Buf,x)
4559                     ; 140 					for(i = 0;i < 8;i++)
4561  01dc 0c0c          	inc	(OFST+0,sp)
4564  01de 7b0c          	ld	a,(OFST+0,sp)
4565  01e0 a108          	cp	a,#8
4566  01e2 25ea          	jrult	L7003
4567                     ; 145 					LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
4569  01e4 35ff0006      	mov	_LED_Buf+6,#255
4570                     ; 146 					LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
4572  01e8 35ff0007      	mov	_LED_Buf+7,#255
4573                     ; 147 					step++;
4575  01ec 3c03          	inc	L1162_step
4576                     ; 149 					if(LightValue&0x01)direct = 0x01;
4578  01ee b601          	ld	a,_LightValue+1
4579  01f0 a501          	bcp	a,#1
4580  01f2 2706          	jreq	L5103
4583  01f4 35010005      	mov	L5162_direct,#1
4585  01f8 2004          	jra	L7103
4586  01fa               L5103:
4587                     ; 150 					else direct = 0x80;
4589  01fa 35800005      	mov	L5162_direct,#128
4590  01fe               L7103:
4591                     ; 151 					CNT = 0;//Clear
4593  01fe 3f04          	clr	L3162_CNT
4594                     ; 152 				}break;
4596  0200 ac3c073c      	jpf	L5772
4597  0204               L3362:
4598                     ; 155 					if(is50ms)
4600                     	btst	_is50ms
4601  0209 2503          	jrult	L07
4602  020b cc073c        	jp	L5772
4603  020e               L07:
4604                     ; 157 						is50ms = 0;
4606  020e 72110000      	bres	_is50ms
4607                     ; 158 						if(++timeCNT > ANIMOTION_TIME)
4609  0212 be07          	ldw	x,L3262_timeCNT
4610  0214 1c0001        	addw	x,#1
4611  0217 bf07          	ldw	L3262_timeCNT,x
4612  0219 a30003        	cpw	x,#3
4613  021c 2569          	jrult	L3203
4614                     ; 160 							timeCNT = 0;
4616  021e 5f            	clrw	x
4617  021f bf07          	ldw	L3262_timeCNT,x
4618                     ; 161 							for(i = 0;i < 8;i++)
4620  0221 0f0c          	clr	(OFST+0,sp)
4621  0223               L5203:
4622                     ; 163 								if(direct == 0x01)LED_Buf[i] |= (buf[i]&(direct<<CNT));			//R
4624  0223 b605          	ld	a,L5162_direct
4625  0225 a101          	cp	a,#1
4626  0227 2628          	jrne	L3303
4629  0229 7b0c          	ld	a,(OFST+0,sp)
4630  022b 5f            	clrw	x
4631  022c 97            	ld	xl,a
4632  022d 7b0c          	ld	a,(OFST+0,sp)
4633  022f 905f          	clrw	y
4634  0231 9097          	ld	yl,a
4635  0233 9089          	pushw	y
4636  0235 b604          	ld	a,L3162_CNT
4637  0237 905f          	clrw	y
4638  0239 9097          	ld	yl,a
4639  023b b605          	ld	a,L5162_direct
4640  023d 905d          	tnzw	y
4641  023f 2705          	jreq	L02
4642  0241               L22:
4643  0241 48            	sll	a
4644  0242 905a          	decw	y
4645  0244 26fb          	jrne	L22
4646  0246               L02:
4647  0246 9085          	popw	y
4648  0248 90e400        	and	a,(L5062_buf,y)
4649  024b ea00          	or	a,(_LED_Buf,x)
4650  024d e700          	ld	(_LED_Buf,x),a
4652  024f 202c          	jra	L5303
4653  0251               L3303:
4654                     ; 164 								else if(direct == 0x80)LED_Buf[i] |= (buf[i]&(direct>>CNT));//L
4656  0251 b605          	ld	a,L5162_direct
4657  0253 a180          	cp	a,#128
4658  0255 2626          	jrne	L5303
4661  0257 7b0c          	ld	a,(OFST+0,sp)
4662  0259 5f            	clrw	x
4663  025a 97            	ld	xl,a
4664  025b 7b0c          	ld	a,(OFST+0,sp)
4665  025d 905f          	clrw	y
4666  025f 9097          	ld	yl,a
4667  0261 9089          	pushw	y
4668  0263 b604          	ld	a,L3162_CNT
4669  0265 905f          	clrw	y
4670  0267 9097          	ld	yl,a
4671  0269 b605          	ld	a,L5162_direct
4672  026b 905d          	tnzw	y
4673  026d 2705          	jreq	L42
4674  026f               L62:
4675  026f 44            	srl	a
4676  0270 905a          	decw	y
4677  0272 26fb          	jrne	L62
4678  0274               L42:
4679  0274 9085          	popw	y
4680  0276 90e400        	and	a,(L5062_buf,y)
4681  0279 ea00          	or	a,(_LED_Buf,x)
4682  027b e700          	ld	(_LED_Buf,x),a
4683  027d               L5303:
4684                     ; 161 							for(i = 0;i < 8;i++)
4686  027d 0c0c          	inc	(OFST+0,sp)
4689  027f 7b0c          	ld	a,(OFST+0,sp)
4690  0281 a108          	cp	a,#8
4691  0283 259e          	jrult	L5203
4692                     ; 166 							CNT++;
4694  0285 3c04          	inc	L3162_CNT
4695  0287               L3203:
4696                     ; 168 						if(CNT >= 8)
4698  0287 b604          	ld	a,L3162_CNT
4699  0289 a108          	cp	a,#8
4700  028b 2403          	jruge	L27
4701  028d cc073c        	jp	L5772
4702  0290               L27:
4703                     ; 170 							CNT = 0;
4705  0290 3f04          	clr	L3162_CNT
4706                     ; 171 							step++;
4708  0292 3c03          	inc	L1162_step
4709  0294 ac3c073c      	jpf	L5772
4710  0298               L5362:
4711                     ; 177 					if(!isChangeContent)
4713                     	btst	L1262_isChangeContent
4714  029d 250d          	jrult	L3403
4715                     ; 179 						timedecode(&Now);
4717  029f ae0000        	ldw	x,#_Now
4718  02a2 cd00fd        	call	_timedecode
4720                     ; 180 						standby_time = STANDBY_TIME_TIME;
4722  02a5 ae00c8        	ldw	x,#200
4723  02a8 1f0a          	ldw	(OFST-2,sp),x
4725  02aa 200a          	jra	L5403
4726  02ac               L3403:
4727                     ; 184 						tempdecode(CurrentTemp);
4729  02ac be00          	ldw	x,_CurrentTemp
4730  02ae cd0000        	call	_tempdecode
4732                     ; 185 						standby_time = STANDBY_TIME_TEMP;
4734  02b1 ae0064        	ldw	x,#100
4735  02b4 1f0a          	ldw	(OFST-2,sp),x
4736  02b6               L5403:
4737                     ; 188 					if(is50ms)
4739                     	btst	_is50ms
4740  02bb 2503          	jrult	L47
4741  02bd cc073c        	jp	L5772
4742  02c0               L47:
4743                     ; 190 						is50ms = 0;
4745  02c0 72110000      	bres	_is50ms
4746                     ; 191 						if(++timeCNT > standby_time)
4748  02c4 be07          	ldw	x,L3262_timeCNT
4749  02c6 1c0001        	addw	x,#1
4750  02c9 bf07          	ldw	L3262_timeCNT,x
4751  02cb 130a          	cpw	x,(OFST-2,sp)
4752  02cd 2203          	jrugt	L67
4753  02cf cc073c        	jp	L5772
4754  02d2               L67:
4755                     ; 193 							timeCNT = 0;
4757  02d2 5f            	clrw	x
4758  02d3 bf07          	ldw	L3262_timeCNT,x
4759                     ; 194 							if(++CNT > 1)
4761  02d5 3c04          	inc	L3162_CNT
4762  02d7 b604          	ld	a,L3162_CNT
4763  02d9 a102          	cp	a,#2
4764  02db 2403          	jruge	L001
4765  02dd cc073c        	jp	L5772
4766  02e0               L001:
4767                     ; 196 								CNT = 0;
4769  02e0 3f04          	clr	L3162_CNT
4770                     ; 197 								step = 0;
4772  02e2 3f03          	clr	L1162_step
4773                     ; 198 								if(!isChangeContent)
4775                     	btst	L1262_isChangeContent
4776  02e9 2506          	jrult	L5503
4777                     ; 200 									isChangeContent = 1;
4779  02eb 72100000      	bset	L1262_isChangeContent
4781  02ef 2004          	jra	L7503
4782  02f1               L5503:
4783                     ; 204 									isChangeContent = 0;
4785  02f1 72110000      	bres	L1262_isChangeContent
4786  02f5               L7503:
4787                     ; 206 								dismode = rand(MAX_MODE);
4789  02f5 a604          	ld	a,#4
4790  02f7 cd016f        	call	_rand
4792  02fa 5f            	clrw	x
4793  02fb 97            	ld	xl,a
4794  02fc bf00          	ldw	L3062_dismode,x
4795  02fe ac3c073c      	jpf	L5772
4796  0302               L1003:
4797                     ; 213 		}break;
4799  0302 ac3c073c      	jpf	L5772
4800  0306               L1462:
4801                     ; 216 			switch(step)
4803  0306 b603          	ld	a,L1162_step
4805                     ; 291 				default:step = 0;
4806  0308 4d            	tnz	a
4807  0309 270f          	jreq	L3462
4808  030b 4a            	dec	a
4809  030c 274e          	jreq	L5462
4810  030e 4a            	dec	a
4811  030f 2603          	jrne	L201
4812  0311 cc03e6        	jp	L7462
4813  0314               L201:
4814  0314               L1562:
4817  0314 3f03          	clr	L1162_step
4818  0316 ac3c073c      	jpf	L5772
4819  031a               L3462:
4820                     ; 220 					if(!isChangeContent)timedecode(&Now);
4822                     	btst	L1262_isChangeContent
4823  031f 2508          	jrult	L5603
4826  0321 ae0000        	ldw	x,#_Now
4827  0324 cd00fd        	call	_timedecode
4830  0327 2005          	jra	L7603
4831  0329               L5603:
4832                     ; 221 					else tempdecode(CurrentTemp);
4834  0329 be00          	ldw	x,_CurrentTemp
4835  032b cd0000        	call	_tempdecode
4837  032e               L7603:
4838                     ; 223 					for(i = 0;i < 8;i++)
4840  032e 0f0c          	clr	(OFST+0,sp)
4841  0330               L1703:
4842                     ; 225 						buf[i] = LED_Buf[i];
4844  0330 7b0c          	ld	a,(OFST+0,sp)
4845  0332 5f            	clrw	x
4846  0333 97            	ld	xl,a
4847  0334 e600          	ld	a,(_LED_Buf,x)
4848  0336 e700          	ld	(L5062_buf,x),a
4849                     ; 226 						LED_Buf[i] = LEDCode[0x0f];//Null clear
4851  0338 7b0c          	ld	a,(OFST+0,sp)
4852  033a 5f            	clrw	x
4853  033b 97            	ld	xl,a
4854  033c 6f00          	clr	(_LED_Buf,x)
4855                     ; 223 					for(i = 0;i < 8;i++)
4857  033e 0c0c          	inc	(OFST+0,sp)
4860  0340 7b0c          	ld	a,(OFST+0,sp)
4861  0342 a108          	cp	a,#8
4862  0344 25ea          	jrult	L1703
4863                     ; 228 					LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
4865  0346 35ff0006      	mov	_LED_Buf+6,#255
4866                     ; 229 					LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
4868  034a 35ff0007      	mov	_LED_Buf+7,#255
4869                     ; 230 					step++;
4871  034e 3c03          	inc	L1162_step
4872                     ; 231 					direct = LightValue&0x01;//0:Up->Down,1:Down->Up
4874  0350 b601          	ld	a,_LightValue+1
4875  0352 a401          	and	a,#1
4876  0354 b705          	ld	L5162_direct,a
4877                     ; 232 					CNT = 0;//Clear
4879  0356 3f04          	clr	L3162_CNT
4880                     ; 233 				}break;
4882  0358 ac3c073c      	jpf	L5772
4883  035c               L5462:
4884                     ; 236 					if(is50ms)
4886                     	btst	_is50ms
4887  0361 2503          	jrult	L401
4888  0363 cc073c        	jp	L5772
4889  0366               L401:
4890                     ; 238 						is50ms = 0;
4892  0366 72110000      	bres	_is50ms
4893                     ; 239 						if(++timeCNT > ANIMOTION_TIME+1)
4895  036a be07          	ldw	x,L3262_timeCNT
4896  036c 1c0001        	addw	x,#1
4897  036f bf07          	ldw	L3262_timeCNT,x
4898  0371 a30004        	cpw	x,#4
4899  0374 255f          	jrult	L1013
4900                     ; 241 							timeCNT = 0;
4902  0376 5f            	clrw	x
4903  0377 bf07          	ldw	L3262_timeCNT,x
4904                     ; 242 							for(i = 0;i < 8;i++)
4906  0379 0f0c          	clr	(OFST+0,sp)
4907  037b               L3013:
4908                     ; 244 								if(direct)LED_Buf[i] |= (buf[i]&(masktbl[5-CNT]));//Down->Up
4910  037b 3d05          	tnz	L5162_direct
4911  037d 272b          	jreq	L1113
4914  037f 7b0c          	ld	a,(OFST+0,sp)
4915  0381 5f            	clrw	x
4916  0382 97            	ld	xl,a
4917  0383 89            	pushw	x
4918  0384 7b0e          	ld	a,(OFST+2,sp)
4919  0386 5f            	clrw	x
4920  0387 97            	ld	xl,a
4921  0388 e600          	ld	a,(L5062_buf,x)
4922  038a 6b05          	ld	(OFST-7,sp),a
4923  038c 96            	ldw	x,sp
4924  038d 1c0006        	addw	x,#OFST-6
4925  0390 1f03          	ldw	(OFST-9,sp),x
4926  0392 a600          	ld	a,#0
4927  0394 97            	ld	xl,a
4928  0395 a605          	ld	a,#5
4929  0397 b004          	sub	a,L3162_CNT
4930  0399 2401          	jrnc	L23
4931  039b 5a            	decw	x
4932  039c               L23:
4933  039c 02            	rlwa	x,a
4934  039d 72fb03        	addw	x,(OFST-9,sp)
4935  03a0 f6            	ld	a,(x)
4936  03a1 1405          	and	a,(OFST-7,sp)
4937  03a3 85            	popw	x
4938  03a4 ea00          	or	a,(_LED_Buf,x)
4939  03a6 e700          	ld	(_LED_Buf,x),a
4941  03a8 2021          	jra	L3113
4942  03aa               L1113:
4943                     ; 245 								else LED_Buf[i] |= (buf[i]&(masktbl[CNT]));		  	//Up->Down
4945  03aa 7b0c          	ld	a,(OFST+0,sp)
4946  03ac 5f            	clrw	x
4947  03ad 97            	ld	xl,a
4948  03ae 89            	pushw	x
4949  03af 7b0e          	ld	a,(OFST+2,sp)
4950  03b1 5f            	clrw	x
4951  03b2 97            	ld	xl,a
4952  03b3 e600          	ld	a,(L5062_buf,x)
4953  03b5 6b05          	ld	(OFST-7,sp),a
4954  03b7 96            	ldw	x,sp
4955  03b8 1c0006        	addw	x,#OFST-6
4956  03bb 9f            	ld	a,xl
4957  03bc 5e            	swapw	x
4958  03bd bb04          	add	a,L3162_CNT
4959  03bf 2401          	jrnc	L43
4960  03c1 5c            	incw	x
4961  03c2               L43:
4962  03c2 02            	rlwa	x,a
4963  03c3 f6            	ld	a,(x)
4964  03c4 1405          	and	a,(OFST-7,sp)
4965  03c6 85            	popw	x
4966  03c7 ea00          	or	a,(_LED_Buf,x)
4967  03c9 e700          	ld	(_LED_Buf,x),a
4968  03cb               L3113:
4969                     ; 242 							for(i = 0;i < 8;i++)
4971  03cb 0c0c          	inc	(OFST+0,sp)
4974  03cd 7b0c          	ld	a,(OFST+0,sp)
4975  03cf a108          	cp	a,#8
4976  03d1 25a8          	jrult	L3013
4977                     ; 247 							CNT++;
4979  03d3 3c04          	inc	L3162_CNT
4980  03d5               L1013:
4981                     ; 249 						if(CNT >= 6)
4983  03d5 b604          	ld	a,L3162_CNT
4984  03d7 a106          	cp	a,#6
4985  03d9 2403          	jruge	L601
4986  03db cc073c        	jp	L5772
4987  03de               L601:
4988                     ; 251 							CNT = 0;
4990  03de 3f04          	clr	L3162_CNT
4991                     ; 252 							step++;
4993  03e0 3c03          	inc	L1162_step
4994  03e2 ac3c073c      	jpf	L5772
4995  03e6               L7462:
4996                     ; 258 					if(!isChangeContent)
4998                     	btst	L1262_isChangeContent
4999  03eb 250d          	jrult	L7113
5000                     ; 260 						timedecode(&Now);
5002  03ed ae0000        	ldw	x,#_Now
5003  03f0 cd00fd        	call	_timedecode
5005                     ; 261 						standby_time = STANDBY_TIME_TIME;
5007  03f3 ae00c8        	ldw	x,#200
5008  03f6 1f0a          	ldw	(OFST-2,sp),x
5010  03f8 200a          	jra	L1213
5011  03fa               L7113:
5012                     ; 265 						tempdecode(CurrentTemp);
5014  03fa be00          	ldw	x,_CurrentTemp
5015  03fc cd0000        	call	_tempdecode
5017                     ; 266 						standby_time = STANDBY_TIME_TEMP;
5019  03ff ae0064        	ldw	x,#100
5020  0402 1f0a          	ldw	(OFST-2,sp),x
5021  0404               L1213:
5022                     ; 268 					if(is50ms)
5024                     	btst	_is50ms
5025  0409 2503          	jrult	L011
5026  040b cc073c        	jp	L5772
5027  040e               L011:
5028                     ; 270 						is50ms = 0;
5030  040e 72110000      	bres	_is50ms
5031                     ; 271 						if(++timeCNT > standby_time)//20S
5033  0412 be07          	ldw	x,L3262_timeCNT
5034  0414 1c0001        	addw	x,#1
5035  0417 bf07          	ldw	L3262_timeCNT,x
5036  0419 130a          	cpw	x,(OFST-2,sp)
5037  041b 2203          	jrugt	L211
5038  041d cc073c        	jp	L5772
5039  0420               L211:
5040                     ; 273 							timeCNT = 0;
5042  0420 5f            	clrw	x
5043  0421 bf07          	ldw	L3262_timeCNT,x
5044                     ; 274 							if(++CNT > 1)
5046  0423 3c04          	inc	L3162_CNT
5047  0425 b604          	ld	a,L3162_CNT
5048  0427 a102          	cp	a,#2
5049  0429 2403          	jruge	L411
5050  042b cc073c        	jp	L5772
5051  042e               L411:
5052                     ; 276 								CNT = 0;
5054  042e 3f04          	clr	L3162_CNT
5055                     ; 277 								step = 0;
5057  0430 3f03          	clr	L1162_step
5058                     ; 278 								if(!isChangeContent)
5060                     	btst	L1262_isChangeContent
5061  0437 2506          	jrult	L1313
5062                     ; 280 									isChangeContent = 1;
5064  0439 72100000      	bset	L1262_isChangeContent
5066  043d 2004          	jra	L3313
5067  043f               L1313:
5068                     ; 284 									isChangeContent = 0;
5070  043f 72110000      	bres	L1262_isChangeContent
5071  0443               L3313:
5072                     ; 286 								dismode = rand(MAX_MODE);
5074  0443 a604          	ld	a,#4
5075  0445 cd016f        	call	_rand
5077  0448 5f            	clrw	x
5078  0449 97            	ld	xl,a
5079  044a bf00          	ldw	L3062_dismode,x
5080  044c ac3c073c      	jpf	L5772
5081  0450               L3603:
5082                     ; 293 		}break;
5084  0450 ac3c073c      	jpf	L5772
5085  0454               L3562:
5086                     ; 296 			switch(step)
5088  0454 b603          	ld	a,L1162_step
5090                     ; 389 				default:step = 0;
5091  0456 4d            	tnz	a
5092  0457 270f          	jreq	L5562
5093  0459 4a            	dec	a
5094  045a 2761          	jreq	L7562
5095  045c 4a            	dec	a
5096  045d 2603          	jrne	L611
5097  045f cc05a4        	jp	L1662
5098  0462               L611:
5099  0462               L3662:
5102  0462 3f03          	clr	L1162_step
5103  0464 ac3c073c      	jpf	L5772
5104  0468               L5562:
5105                     ; 300 					if(!isChangeContent)timedecode(&Now);
5107                     	btst	L1262_isChangeContent
5108  046d 2508          	jrult	L1413
5111  046f ae0000        	ldw	x,#_Now
5112  0472 cd00fd        	call	_timedecode
5115  0475 2005          	jra	L3413
5116  0477               L1413:
5117                     ; 301 					else tempdecode(CurrentTemp);
5119  0477 be00          	ldw	x,_CurrentTemp
5120  0479 cd0000        	call	_tempdecode
5122  047c               L3413:
5123                     ; 303 					for(i = 0;i < 8;i++)
5125  047c 0f0c          	clr	(OFST+0,sp)
5126  047e               L5413:
5127                     ; 305 						buf[i] = LED_Buf[i];
5129  047e 7b0c          	ld	a,(OFST+0,sp)
5130  0480 5f            	clrw	x
5131  0481 97            	ld	xl,a
5132  0482 e600          	ld	a,(_LED_Buf,x)
5133  0484 e700          	ld	(L5062_buf,x),a
5134                     ; 306 						LED_Buf[i] = LEDCode[0x0f];//Null clear
5136  0486 7b0c          	ld	a,(OFST+0,sp)
5137  0488 5f            	clrw	x
5138  0489 97            	ld	xl,a
5139  048a 6f00          	clr	(_LED_Buf,x)
5140                     ; 303 					for(i = 0;i < 8;i++)
5142  048c 0c0c          	inc	(OFST+0,sp)
5145  048e 7b0c          	ld	a,(OFST+0,sp)
5146  0490 a108          	cp	a,#8
5147  0492 25ea          	jrult	L5413
5148                     ; 308 					LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
5150  0494 35ff0006      	mov	_LED_Buf+6,#255
5151                     ; 309 					LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
5153  0498 35ff0007      	mov	_LED_Buf+7,#255
5154                     ; 310 					step++;
5156  049c 3c03          	inc	L1162_step
5157                     ; 311 					direct = LightValue&0x01;//0:Up->Down,1:Down->Up
5159  049e b601          	ld	a,_LightValue+1
5160  04a0 a401          	and	a,#1
5161  04a2 b705          	ld	L5162_direct,a
5162                     ; 312 					if((!direct)&&(isChangeContent))rollCNT = 2;
5164  04a4 3d05          	tnz	L5162_direct
5165  04a6 260d          	jrne	L3513
5167                     	btst	L1262_isChangeContent
5168  04ad 2406          	jruge	L3513
5171  04af 35020006      	mov	L7162_rollCNT,#2
5173  04b3 2002          	jra	L5513
5174  04b5               L3513:
5175                     ; 313 					else rollCNT = 0;
5177  04b5 3f06          	clr	L7162_rollCNT
5178  04b7               L5513:
5179                     ; 314 					CNT = 0;//Set
5181  04b7 3f04          	clr	L3162_CNT
5182                     ; 315 				}break;
5184  04b9 ac3c073c      	jpf	L5772
5185  04bd               L7562:
5186                     ; 318 					if(is50ms)
5188                     	btst	_is50ms
5189  04c2 2503          	jrult	L021
5190  04c4 cc073c        	jp	L5772
5191  04c7               L021:
5192                     ; 320 						is50ms = 0;
5194  04c7 72110000      	bres	_is50ms
5195                     ; 321 						if(++timeCNT > ANIMOTION_TIME-1)
5197  04cb be07          	ldw	x,L3262_timeCNT
5198  04cd 1c0001        	addw	x,#1
5199  04d0 bf07          	ldw	L3262_timeCNT,x
5200  04d2 a30002        	cpw	x,#2
5201  04d5 2403          	jruge	L221
5202  04d7 cc073c        	jp	L5772
5203  04da               L221:
5204                     ; 323 							timeCNT = 0;
5206  04da 5f            	clrw	x
5207  04db bf07          	ldw	L3262_timeCNT,x
5208                     ; 324 							if(direct)
5210  04dd 3d05          	tnz	L5162_direct
5211  04df 275b          	jreq	L3613
5212                     ; 326 								for(i = rollCNT; i < 6;i++)LED_Buf[i] = 0;//Clear
5214  04e1 b606          	ld	a,L7162_rollCNT
5215  04e3 6b0c          	ld	(OFST+0,sp),a
5217  04e5 2008          	jra	L1713
5218  04e7               L5613:
5221  04e7 7b0c          	ld	a,(OFST+0,sp)
5222  04e9 5f            	clrw	x
5223  04ea 97            	ld	xl,a
5224  04eb 6f00          	clr	(_LED_Buf,x)
5227  04ed 0c0c          	inc	(OFST+0,sp)
5228  04ef               L1713:
5231  04ef 7b0c          	ld	a,(OFST+0,sp)
5232  04f1 a106          	cp	a,#6
5233  04f3 25f2          	jrult	L5613
5234                     ; 327 								LED_Buf[5 - CNT] = buf[rollCNT];
5236  04f5 a600          	ld	a,#0
5237  04f7 97            	ld	xl,a
5238  04f8 a605          	ld	a,#5
5239  04fa b004          	sub	a,L3162_CNT
5240  04fc 2401          	jrnc	L04
5241  04fe 5a            	decw	x
5242  04ff               L04:
5243  04ff 02            	rlwa	x,a
5244  0500 b606          	ld	a,L7162_rollCNT
5245  0502 905f          	clrw	y
5246  0504 9097          	ld	yl,a
5247  0506 90e600        	ld	a,(L5062_buf,y)
5248  0509 e700          	ld	(_LED_Buf,x),a
5249                     ; 328 								if(++CNT >= (6 - rollCNT))
5251  050b 9c            	rvf
5252  050c a600          	ld	a,#0
5253  050e 97            	ld	xl,a
5254  050f a606          	ld	a,#6
5255  0511 b006          	sub	a,L7162_rollCNT
5256  0513 2401          	jrnc	L24
5257  0515 5a            	decw	x
5258  0516               L24:
5259  0516 02            	rlwa	x,a
5260  0517 1f02          	ldw	(OFST-10,sp),x
5261  0519 01            	rrwa	x,a
5262  051a 3c04          	inc	L3162_CNT
5263  051c b604          	ld	a,L3162_CNT
5264  051e 5f            	clrw	x
5265  051f 97            	ld	xl,a
5266  0520 1302          	cpw	x,(OFST-10,sp)
5267  0522 2e03          	jrsge	L421
5268  0524 cc073c        	jp	L5772
5269  0527               L421:
5270                     ; 330 									CNT = 0;
5272  0527 3f04          	clr	L3162_CNT
5273                     ; 331 									if(++rollCNT >= 6)
5275  0529 3c06          	inc	L7162_rollCNT
5276  052b b606          	ld	a,L7162_rollCNT
5277  052d a106          	cp	a,#6
5278  052f 2403          	jruge	L621
5279  0531 cc073c        	jp	L5772
5280  0534               L621:
5281                     ; 333 										rollCNT = 0;
5283  0534 3f06          	clr	L7162_rollCNT
5284                     ; 334 										step++;
5286  0536 3c03          	inc	L1162_step
5287  0538 ac3c073c      	jpf	L5772
5288  053c               L3613:
5289                     ; 340 								for(i = 0; i < (5 - rollCNT);i++)LED_Buf[i] = 0;//Clear
5291  053c 0f0c          	clr	(OFST+0,sp)
5293  053e 2008          	jra	L7023
5294  0540               L3023:
5297  0540 7b0c          	ld	a,(OFST+0,sp)
5298  0542 5f            	clrw	x
5299  0543 97            	ld	xl,a
5300  0544 6f00          	clr	(_LED_Buf,x)
5303  0546 0c0c          	inc	(OFST+0,sp)
5304  0548               L7023:
5307  0548 9c            	rvf
5308  0549 7b0c          	ld	a,(OFST+0,sp)
5309  054b 5f            	clrw	x
5310  054c 97            	ld	xl,a
5311  054d 1f02          	ldw	(OFST-10,sp),x
5312  054f a600          	ld	a,#0
5313  0551 97            	ld	xl,a
5314  0552 a605          	ld	a,#5
5315  0554 b006          	sub	a,L7162_rollCNT
5316  0556 2401          	jrnc	L44
5317  0558 5a            	decw	x
5318  0559               L44:
5319  0559 02            	rlwa	x,a
5320  055a 1302          	cpw	x,(OFST-10,sp)
5321  055c 2ce2          	jrsgt	L3023
5322                     ; 341 								LED_Buf[CNT] = buf[5 - rollCNT];
5324  055e b604          	ld	a,L3162_CNT
5325  0560 5f            	clrw	x
5326  0561 97            	ld	xl,a
5327  0562 89            	pushw	x
5328  0563 a600          	ld	a,#0
5329  0565 97            	ld	xl,a
5330  0566 a605          	ld	a,#5
5331  0568 b006          	sub	a,L7162_rollCNT
5332  056a 2401          	jrnc	L64
5333  056c 5a            	decw	x
5334  056d               L64:
5335  056d 02            	rlwa	x,a
5336  056e e600          	ld	a,(L5062_buf,x)
5337  0570 85            	popw	x
5338  0571 e700          	ld	(_LED_Buf,x),a
5339                     ; 342 								if(++CNT >= (6 - rollCNT))
5341  0573 9c            	rvf
5342  0574 a600          	ld	a,#0
5343  0576 97            	ld	xl,a
5344  0577 a606          	ld	a,#6
5345  0579 b006          	sub	a,L7162_rollCNT
5346  057b 2401          	jrnc	L05
5347  057d 5a            	decw	x
5348  057e               L05:
5349  057e 02            	rlwa	x,a
5350  057f 1f02          	ldw	(OFST-10,sp),x
5351  0581 01            	rrwa	x,a
5352  0582 3c04          	inc	L3162_CNT
5353  0584 b604          	ld	a,L3162_CNT
5354  0586 5f            	clrw	x
5355  0587 97            	ld	xl,a
5356  0588 1302          	cpw	x,(OFST-10,sp)
5357  058a 2e03          	jrsge	L031
5358  058c cc073c        	jp	L5772
5359  058f               L031:
5360                     ; 344 									CNT = 0;
5362  058f 3f04          	clr	L3162_CNT
5363                     ; 345 									if(++rollCNT >= 6)
5365  0591 3c06          	inc	L7162_rollCNT
5366  0593 b606          	ld	a,L7162_rollCNT
5367  0595 a106          	cp	a,#6
5368  0597 2403          	jruge	L231
5369  0599 cc073c        	jp	L5772
5370  059c               L231:
5371                     ; 347 										rollCNT = 0;
5373  059c 3f06          	clr	L7162_rollCNT
5374                     ; 348 										step++;
5376  059e 3c03          	inc	L1162_step
5377  05a0 ac3c073c      	jpf	L5772
5378  05a4               L1662:
5379                     ; 357 					if(!isChangeContent)
5381                     	btst	L1262_isChangeContent
5382  05a9 250d          	jrult	L7123
5383                     ; 359 						timedecode(&Now);
5385  05ab ae0000        	ldw	x,#_Now
5386  05ae cd00fd        	call	_timedecode
5388                     ; 360 						standby_time = STANDBY_TIME_TIME;
5390  05b1 ae00c8        	ldw	x,#200
5391  05b4 1f0a          	ldw	(OFST-2,sp),x
5393  05b6 200a          	jra	L1223
5394  05b8               L7123:
5395                     ; 364 						tempdecode(CurrentTemp);
5397  05b8 be00          	ldw	x,_CurrentTemp
5398  05ba cd0000        	call	_tempdecode
5400                     ; 365 						standby_time = STANDBY_TIME_TEMP;
5402  05bd ae0064        	ldw	x,#100
5403  05c0 1f0a          	ldw	(OFST-2,sp),x
5404  05c2               L1223:
5405                     ; 367 					if(is50ms)
5407                     	btst	_is50ms
5408  05c7 2503          	jrult	L431
5409  05c9 cc073c        	jp	L5772
5410  05cc               L431:
5411                     ; 369 						is50ms = 0;
5413  05cc 72110000      	bres	_is50ms
5414                     ; 370 						if(++timeCNT > standby_time)//20S
5416  05d0 be07          	ldw	x,L3262_timeCNT
5417  05d2 1c0001        	addw	x,#1
5418  05d5 bf07          	ldw	L3262_timeCNT,x
5419  05d7 130a          	cpw	x,(OFST-2,sp)
5420  05d9 2203          	jrugt	L631
5421  05db cc073c        	jp	L5772
5422  05de               L631:
5423                     ; 372 							timeCNT = 0;
5425  05de 5f            	clrw	x
5426  05df bf07          	ldw	L3262_timeCNT,x
5427                     ; 373 							if(++CNT > 1)
5429  05e1 3c04          	inc	L3162_CNT
5430  05e3 b604          	ld	a,L3162_CNT
5431  05e5 a102          	cp	a,#2
5432  05e7 2403          	jruge	L041
5433  05e9 cc073c        	jp	L5772
5434  05ec               L041:
5435                     ; 375 								step = 0;
5437  05ec 3f03          	clr	L1162_step
5438                     ; 376 								if(!isChangeContent)
5440                     	btst	L1262_isChangeContent
5441  05f3 2506          	jrult	L1323
5442                     ; 378 									isChangeContent = 1;
5444  05f5 72100000      	bset	L1262_isChangeContent
5446  05f9 2004          	jra	L3323
5447  05fb               L1323:
5448                     ; 382 									isChangeContent = 0;
5450  05fb 72110000      	bres	L1262_isChangeContent
5451  05ff               L3323:
5452                     ; 384 								dismode = rand(MAX_MODE);
5454  05ff a604          	ld	a,#4
5455  0601 cd016f        	call	_rand
5457  0604 5f            	clrw	x
5458  0605 97            	ld	xl,a
5459  0606 bf00          	ldw	L3062_dismode,x
5460  0608 ac3c073c      	jpf	L5772
5461  060c               L7313:
5462                     ; 391 		}break;
5464  060c ac3c073c      	jpf	L5772
5465  0610               L5662:
5466                     ; 394 			switch(step)
5468  0610 b603          	ld	a,L1162_step
5470                     ; 490 				default:step = 0;
5471  0612 4d            	tnz	a
5472  0613 270f          	jreq	L7662
5473  0615 4a            	dec	a
5474  0616 272a          	jreq	L1762
5475  0618 4a            	dec	a
5476  0619 2603          	jrne	L241
5477  061b cc06e1        	jp	L3762
5478  061e               L241:
5479  061e               L5762:
5482  061e 3f03          	clr	L1162_step
5483  0620 ac3c073c      	jpf	L5772
5484  0624               L7662:
5485                     ; 398 					for(i = 0;i < 8;i++)
5487  0624 0f0c          	clr	(OFST+0,sp)
5488  0626               L1423:
5489                     ; 400 						LED_Buf[i] = LEDCode[0x0f];//Null clear
5491  0626 7b0c          	ld	a,(OFST+0,sp)
5492  0628 5f            	clrw	x
5493  0629 97            	ld	xl,a
5494  062a 6f00          	clr	(_LED_Buf,x)
5495                     ; 398 					for(i = 0;i < 8;i++)
5497  062c 0c0c          	inc	(OFST+0,sp)
5500  062e 7b0c          	ld	a,(OFST+0,sp)
5501  0630 a108          	cp	a,#8
5502  0632 25f2          	jrult	L1423
5503                     ; 402 					LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
5505  0634 35ff0006      	mov	_LED_Buf+6,#255
5506                     ; 403 					LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
5508  0638 35ff0007      	mov	_LED_Buf+7,#255
5509                     ; 404 					step++;
5511  063c 3c03          	inc	L1162_step
5512                     ; 405 				}break;
5514  063e ac3c073c      	jpf	L5772
5515  0642               L1762:
5516                     ; 408 					if(is50ms)
5518                     	btst	_is50ms
5519  0647 246e          	jruge	L7423
5520                     ; 410 						is50ms = 0;
5522  0649 72110000      	bres	_is50ms
5523                     ; 411 						if(++timeCNT > ANIMOTION_TIME-1)
5525  064d be07          	ldw	x,L3262_timeCNT
5526  064f 1c0001        	addw	x,#1
5527  0652 bf07          	ldw	L3262_timeCNT,x
5528  0654 a30002        	cpw	x,#2
5529  0657 2403          	jruge	L441
5530  0659 cc073c        	jp	L5772
5531  065c               L441:
5532                     ; 413 							timeCNT = 0;
5534  065c 5f            	clrw	x
5535  065d bf07          	ldw	L3262_timeCNT,x
5536                     ; 414 							if(isChangeContent)
5538                     	btst	L1262_isChangeContent
5539  0664 2428          	jruge	L3523
5540                     ; 416 								for(i = 0;i < 3;i++)
5542  0666 0f0c          	clr	(OFST+0,sp)
5543  0668               L5523:
5544                     ; 418 									LED_Buf[i] = buf[i];
5546  0668 7b0c          	ld	a,(OFST+0,sp)
5547  066a 5f            	clrw	x
5548  066b 97            	ld	xl,a
5549  066c e600          	ld	a,(L5062_buf,x)
5550  066e e700          	ld	(_LED_Buf,x),a
5551                     ; 416 								for(i = 0;i < 3;i++)
5553  0670 0c0c          	inc	(OFST+0,sp)
5556  0672 7b0c          	ld	a,(OFST+0,sp)
5557  0674 a103          	cp	a,#3
5558  0676 25f0          	jrult	L5523
5559                     ; 420 								LED_Buf[1] |= 0x80;//Dot
5561  0678 721e0001      	bset	_LED_Buf+1,#7
5562                     ; 421 								LED_Buf[3] = LEDCode[0x0C];//c
5564  067c 35610003      	mov	_LED_Buf+3,#97
5565                     ; 422 								LED_Buf[4] = LED_Buf[5] = LEDCode[0x0F];//Null;
5567  0680 3f05          	clr	_LED_Buf+5
5568  0682 3f04          	clr	_LED_Buf+4
5569                     ; 423 								LED_Buf[6] = BIT_CODE[6];//Temp Dot  ON:6,OFF:8 
5571  0684 357f0006      	mov	_LED_Buf+6,#127
5572                     ; 424 								LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
5574  0688 35ff0007      	mov	_LED_Buf+7,#255
5576  068c 201a          	jra	L3623
5577  068e               L3523:
5578                     ; 428 								for(i = 0;i < 6;i++)
5580  068e 0f0c          	clr	(OFST+0,sp)
5581  0690               L5623:
5582                     ; 430 									LED_Buf[i] = buf[i];
5584  0690 7b0c          	ld	a,(OFST+0,sp)
5585  0692 5f            	clrw	x
5586  0693 97            	ld	xl,a
5587  0694 e600          	ld	a,(L5062_buf,x)
5588  0696 e700          	ld	(_LED_Buf,x),a
5589                     ; 428 								for(i = 0;i < 6;i++)
5591  0698 0c0c          	inc	(OFST+0,sp)
5594  069a 7b0c          	ld	a,(OFST+0,sp)
5595  069c a106          	cp	a,#6
5596  069e 25f0          	jrult	L5623
5597                     ; 432 								LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
5599  06a0 35ff0006      	mov	_LED_Buf+6,#255
5600                     ; 433 								LED_Buf[7] = BIT_CODE[7];//Time Dot  ON:7,OFF:8
5602  06a4 35bf0007      	mov	_LED_Buf+7,#191
5603  06a8               L3623:
5604                     ; 435 							if(++CNT > 40)
5606  06a8 3c04          	inc	L3162_CNT
5607  06aa b604          	ld	a,L3162_CNT
5608  06ac a129          	cp	a,#41
5609  06ae 25a9          	jrult	L5772
5610                     ; 437 								CNT = 0;
5612  06b0 3f04          	clr	L3162_CNT
5613                     ; 438 								step++;
5615  06b2 3c03          	inc	L1162_step
5616  06b4 cc073c        	jra	L5772
5617  06b7               L7423:
5618                     ; 444 						if(++timeCNT1 > 16)//32ms per number
5620  06b7 3c02          	inc	L7062_timeCNT1
5621  06b9 b602          	ld	a,L7062_timeCNT1
5622  06bb a111          	cp	a,#17
5623  06bd 257d          	jrult	L5772
5624                     ; 446 							timeCNT1 = 0;
5626  06bf 3f02          	clr	L7062_timeCNT1
5627                     ; 447 							if(rollCNT < 6)
5629  06c1 b606          	ld	a,L7162_rollCNT
5630  06c3 a106          	cp	a,#6
5631  06c5 2416          	jruge	L1033
5632                     ; 449 								buf[rollCNT] = LEDCode[rand(10)];//get random seed
5634  06c7 b606          	ld	a,L7162_rollCNT
5635  06c9 5f            	clrw	x
5636  06ca 97            	ld	xl,a
5637  06cb 89            	pushw	x
5638  06cc a60a          	ld	a,#10
5639  06ce cd016f        	call	_rand
5641  06d1 5f            	clrw	x
5642  06d2 97            	ld	xl,a
5643  06d3 d60000        	ld	a,(_LEDCode,x)
5644  06d6 85            	popw	x
5645  06d7 e700          	ld	(L5062_buf,x),a
5646                     ; 450 								rollCNT++;
5648  06d9 3c06          	inc	L7162_rollCNT
5650  06db 205f          	jra	L5772
5651  06dd               L1033:
5652                     ; 452 							else rollCNT = 0;
5654  06dd 3f06          	clr	L7162_rollCNT
5655  06df 205b          	jra	L5772
5656  06e1               L3762:
5657                     ; 458 					if(!isChangeContent)
5659                     	btst	L1262_isChangeContent
5660  06e6 250d          	jrult	L5033
5661                     ; 460 						timedecode(&Now);
5663  06e8 ae0000        	ldw	x,#_Now
5664  06eb cd00fd        	call	_timedecode
5666                     ; 461 						standby_time = STANDBY_TIME_TIME;
5668  06ee ae00c8        	ldw	x,#200
5669  06f1 1f0a          	ldw	(OFST-2,sp),x
5671  06f3 200a          	jra	L7033
5672  06f5               L5033:
5673                     ; 465 						tempdecode(CurrentTemp);
5675  06f5 be00          	ldw	x,_CurrentTemp
5676  06f7 cd0000        	call	_tempdecode
5678                     ; 466 						standby_time = STANDBY_TIME_TEMP;
5680  06fa ae0064        	ldw	x,#100
5681  06fd 1f0a          	ldw	(OFST-2,sp),x
5682  06ff               L7033:
5683                     ; 468 					if(is50ms)
5685                     	btst	_is50ms
5686  0704 2436          	jruge	L5772
5687                     ; 470 						is50ms = 0;
5689  0706 72110000      	bres	_is50ms
5690                     ; 471 						if(++timeCNT > standby_time)//20S
5692  070a be07          	ldw	x,L3262_timeCNT
5693  070c 1c0001        	addw	x,#1
5694  070f bf07          	ldw	L3262_timeCNT,x
5695  0711 130a          	cpw	x,(OFST-2,sp)
5696  0713 2327          	jrule	L5772
5697                     ; 473 							timeCNT = 0;
5699  0715 5f            	clrw	x
5700  0716 bf07          	ldw	L3262_timeCNT,x
5701                     ; 474 							if(++CNT > 1)
5703  0718 3c04          	inc	L3162_CNT
5704  071a b604          	ld	a,L3162_CNT
5705  071c a102          	cp	a,#2
5706  071e 251c          	jrult	L5772
5707                     ; 476 								step = 0;
5709  0720 3f03          	clr	L1162_step
5710                     ; 477 								if(!isChangeContent)
5712                     	btst	L1262_isChangeContent
5713  0727 2506          	jrult	L7133
5714                     ; 479 									isChangeContent = 1;
5716  0729 72100000      	bset	L1262_isChangeContent
5718  072d 2004          	jra	L1233
5719  072f               L7133:
5720                     ; 483 									isChangeContent = 0;
5722  072f 72110000      	bres	L1262_isChangeContent
5723  0733               L1233:
5724                     ; 485 								dismode = rand(MAX_MODE);
5726  0733 a604          	ld	a,#4
5727  0735 cd016f        	call	_rand
5729  0738 5f            	clrw	x
5730  0739 97            	ld	xl,a
5731  073a bf00          	ldw	L3062_dismode,x
5732  073c               L7323:
5733                     ; 492 		}break;
5735  073c               L5772:
5736                     ; 495 }
5739  073c 5b0c          	addw	sp,#12
5740  073e 81            	ret
5743                     	bsct
5744  0009               L3233_type:
5745  0009 00            	dc.b	0
5789                     ; 497 void _displayDecode(void)
5789                     ; 498 {
5790                     	switch	.text
5791  073f               __displayDecode:
5795                     ; 501 	switch(MachineStatus)
5797  073f b600          	ld	a,_MachineStatus
5799                     ; 555 		default:;
5800  0741 4d            	tnz	a
5801  0742 2708          	jreq	L5233
5802  0744 4a            	dec	a
5803  0745 270a          	jreq	L7233
5804  0747 4a            	dec	a
5805  0748 272a          	jreq	L1333
5806  074a 2077          	jra	L5733
5807  074c               L5233:
5808                     ; 505 			displayStyle();
5810  074c cd017a        	call	_displayStyle
5812                     ; 513 		}break;
5814  074f 2072          	jra	L5733
5815  0751               L7233:
5816                     ; 516 			LED_Buf[0] = LEDCode[0x0b];//F
5818  0751 35710000      	mov	_LED_Buf,#113
5819                     ; 517 			LED_Buf[1] = LEDCode[0x12];//u
5821  0755 351c0001      	mov	_LED_Buf+1,#28
5822                     ; 518 			LED_Buf[2] = LEDCode[0x13];//n
5824  0759 35540002      	mov	_LED_Buf+2,#84
5825                     ; 519 			LED_Buf[3] = LEDCode[SetMenu];//Null
5827  075d b600          	ld	a,_SetMenu
5828  075f 5f            	clrw	x
5829  0760 97            	ld	xl,a
5830  0761 d60000        	ld	a,(_LEDCode,x)
5831  0764 b703          	ld	_LED_Buf+3,a
5832                     ; 520 			LED_Buf[4] = LEDCode[0x0f];//Null
5834  0766 3f04          	clr	_LED_Buf+4
5835                     ; 521 			LED_Buf[5] = LEDCode[0x0f];//Null
5837  0768 3f05          	clr	_LED_Buf+5
5838                     ; 523 			LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
5840  076a 35ff0006      	mov	_LED_Buf+6,#255
5841                     ; 524 			LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
5843  076e 35ff0007      	mov	_LED_Buf+7,#255
5844                     ; 525 		}break;
5846  0772 204f          	jra	L5733
5847  0774               L1333:
5848                     ; 528 			switch(SetMenu)
5850  0774 b600          	ld	a,_SetMenu
5852                     ; 552 				default:;
5853  0776 4d            	tnz	a
5854  0777 2714          	jreq	L3333
5855  0779 4a            	dec	a
5856  077a 272d          	jreq	L5333
5857  077c 4a            	dec	a
5858  077d 273f          	jreq	L7333
5859  077f 4a            	dec	a
5860  0780 2741          	jreq	L5733
5861  0782 4a            	dec	a
5862  0783 273e          	jreq	L5733
5863  0785 4a            	dec	a
5864  0786 273b          	jreq	L5733
5865  0788 4a            	dec	a
5866  0789 2738          	jreq	L5733
5867  078b 2036          	jra	L5733
5868  078d               L3333:
5869                     ; 532 					LED_Buf[0] = LEDCode[0x14];//R
5871  078d 35770000      	mov	_LED_Buf,#119
5872                     ; 533 					LED_Buf[1] = LEDCode[0x15];//E
5874  0791 35790001      	mov	_LED_Buf+1,#121
5875                     ; 534 					LED_Buf[2] = LEDCode[0x16];//C
5877  0795 35390002      	mov	_LED_Buf+2,#57
5878                     ; 535 					LED_Buf[3] = LEDCode[0x0f];//Null
5880  0799 3f03          	clr	_LED_Buf+3
5881                     ; 536 					LED_Buf[4] = LEDCode[0x0f];//Null
5883  079b 3f04          	clr	_LED_Buf+4
5884                     ; 537 					LED_Buf[5] = LEDCode[0x0f];//Null
5886  079d 3f05          	clr	_LED_Buf+5
5887                     ; 539 					LED_Buf[6] = BIT_CODE[8];//Temp Dot  ON:6,OFF:8 
5889  079f 35ff0006      	mov	_LED_Buf+6,#255
5890                     ; 540 					LED_Buf[7] = BIT_CODE[8];//Time Dot  ON:7,OFF:8
5892  07a3 35ff0007      	mov	_LED_Buf+7,#255
5893                     ; 541 				}break;
5895  07a7 201a          	jra	L5733
5896  07a9               L5333:
5897                     ; 544 					timedecode(&Now);
5899  07a9 ae0000        	ldw	x,#_Now
5900  07ac cd00fd        	call	_timedecode
5902                     ; 545 					if(isFlash1Hz)LED_Buf[SetStep] = LEDCode[0x0f];//Null
5904                     	btst	_isFlash1Hz
5905  07b4 240d          	jruge	L5733
5908  07b6 b600          	ld	a,_SetStep
5909  07b8 5f            	clrw	x
5910  07b9 97            	ld	xl,a
5911  07ba 6f00          	clr	(_LED_Buf,x)
5912  07bc 2005          	jra	L5733
5913  07be               L7333:
5914                     ; 547 				case FUNCTION_2:tempdecode(CorrectTemp);break;
5916  07be be00          	ldw	x,_CorrectTemp
5917  07c0 cd0000        	call	_tempdecode
5921  07c3               L1043:
5922                     ; 554 		}break;
5924  07c3               L5733:
5925                     ; 571 }
5928  07c3 81            	ret
5986                     ; 574 void hc_595_driver(uchar bit,uchar data)
5986                     ; 575 {
5987                     	switch	.text
5988  07c4               _hc_595_driver:
5990  07c4 89            	pushw	x
5991  07c5 88            	push	a
5992       00000001      OFST:	set	1
5995                     ; 580 	for(i = 0;i < 8 ;i++)//deliver bit select data
5997  07c6 0f01          	clr	(OFST+0,sp)
5998  07c8               L3343:
5999                     ; 582 		SCLK = 0;//Is very important to add on this syntax
6001  07c8 721f500a      	bres	_PC_ODR_7
6002                     ; 583 		SDAT = bit & 0x80;
6004  07cc 7b02          	ld	a,(OFST+1,sp)
6005  07ce a580          	bcp	a,#128
6006  07d0 2602          	jrne	L661
6007  07d2 2006          	jp	L651
6008  07d4               L661:
6009  07d4 721a500f      	bset	_PD_ODR_5
6010  07d8 2004          	jra	L061
6011  07da               L651:
6012  07da 721b500f      	bres	_PD_ODR_5
6013  07de               L061:
6014                     ; 584 		bit <<= 1;
6016  07de 0802          	sll	(OFST+1,sp)
6017                     ; 585 		_asm("nop");//waitting for stable data
6020  07e0 9d            nop
6022                     ; 586 		SCLK = 1;//posedge srclk
6024  07e1 721e500a      	bset	_PC_ODR_7
6025                     ; 580 	for(i = 0;i < 8 ;i++)//deliver bit select data
6027  07e5 0c01          	inc	(OFST+0,sp)
6030  07e7 7b01          	ld	a,(OFST+0,sp)
6031  07e9 a108          	cp	a,#8
6032  07eb 25db          	jrult	L3343
6033                     ; 591 	for(i = 0;i < 8 ;i++)//deliver bit select data
6035  07ed 0f01          	clr	(OFST+0,sp)
6036  07ef               L1443:
6037                     ; 593 		SCLK = 0;//Is very important to add on this syntax
6039  07ef 721f500a      	bres	_PC_ODR_7
6040                     ; 594 		SDAT = data & 0x80;
6042  07f3 7b03          	ld	a,(OFST+2,sp)
6043  07f5 a580          	bcp	a,#128
6044  07f7 2602          	jrne	L071
6045  07f9 2006          	jp	L261
6046  07fb               L071:
6047  07fb 721a500f      	bset	_PD_ODR_5
6048  07ff 2004          	jra	L461
6049  0801               L261:
6050  0801 721b500f      	bres	_PD_ODR_5
6051  0805               L461:
6052                     ; 595 		data <<= 1;
6054  0805 0803          	sll	(OFST+2,sp)
6055                     ; 596 		_asm("nop");//waitting for stable data
6058  0807 9d            nop
6060                     ; 597 		SCLK = 1;//posedge srclk
6062  0808 721e500a      	bset	_PC_ODR_7
6063                     ; 591 	for(i = 0;i < 8 ;i++)//deliver bit select data
6065  080c 0c01          	inc	(OFST+0,sp)
6068  080e 7b01          	ld	a,(OFST+0,sp)
6069  0810 a108          	cp	a,#8
6070  0812 25db          	jrult	L1443
6071                     ; 602 	RCLK = 1;//posedge rclk.
6073  0814 721a500a      	bset	_PC_ODR_5
6074                     ; 603 	_asm("nop");
6077  0818 9d            nop
6079                     ; 604 	RCLK = 0;
6081  0819 721b500a      	bres	_PC_ODR_5
6082                     ; 605 }
6085  081d 5b03          	addw	sp,#3
6086  081f 81            	ret
6089                     	bsct
6090  000a               L7443_digitalNum:
6091  000a 00            	dc.b	0
6135                     ; 607 void _Display(void)
6135                     ; 608 {
6136                     	switch	.text
6137  0820               __Display:
6139  0820 88            	push	a
6140       00000001      OFST:	set	1
6143                     ; 610 	uchar i = 0;
6145  0821 0f01          	clr	(OFST+0,sp)
6146                     ; 612 	if(digitalNum < 6)
6148  0823 b60a          	ld	a,L7443_digitalNum
6149  0825 a106          	cp	a,#6
6150  0827 2416          	jruge	L3743
6151                     ; 614 		hc_595_driver(BIT_CODE[digitalNum],LED_Buf[digitalNum]);
6153  0829 b60a          	ld	a,L7443_digitalNum
6154  082b 5f            	clrw	x
6155  082c 97            	ld	xl,a
6156  082d e600          	ld	a,(_LED_Buf,x)
6157  082f 97            	ld	xl,a
6158  0830 b60a          	ld	a,L7443_digitalNum
6159  0832 905f          	clrw	y
6160  0834 9097          	ld	yl,a
6161  0836 90d60017      	ld	a,(_BIT_CODE,y)
6162  083a 95            	ld	xh,a
6163  083b ad87          	call	_hc_595_driver
6166  083d 201c          	jra	L5743
6167  083f               L3743:
6168                     ; 616 	else if(digitalNum == 6)hc_595_driver(LED_Buf[6],0);
6170  083f b60a          	ld	a,L7443_digitalNum
6171  0841 a106          	cp	a,#6
6172  0843 2609          	jrne	L7743
6175  0845 5f            	clrw	x
6176  0846 b606          	ld	a,_LED_Buf+6
6177  0848 95            	ld	xh,a
6178  0849 cd07c4        	call	_hc_595_driver
6181  084c 200d          	jra	L5743
6182  084e               L7743:
6183                     ; 617 	else if(digitalNum == 7)hc_595_driver(LED_Buf[7],0);
6185  084e b60a          	ld	a,L7443_digitalNum
6186  0850 a107          	cp	a,#7
6187  0852 2607          	jrne	L5743
6190  0854 5f            	clrw	x
6191  0855 b607          	ld	a,_LED_Buf+7
6192  0857 95            	ld	xh,a
6193  0858 cd07c4        	call	_hc_595_driver
6195  085b               L5743:
6196                     ; 619 	if(++digitalNum > 7)digitalNum = 0;
6198  085b 3c0a          	inc	L7443_digitalNum
6199  085d b60a          	ld	a,L7443_digitalNum
6200  085f a108          	cp	a,#8
6201  0861 2502          	jrult	L5053
6204  0863 3f0a          	clr	L7443_digitalNum
6205  0865               L5053:
6206                     ; 621 }
6209  0865 84            	pop	a
6210  0866 81            	ret
6245                     	xdef	_hc_595_driver
6246                     	xdef	_displayStyle
6247                     	xdef	_rand
6248                     	xdef	_timedecode
6249                     	xdef	_tempdecode
6250                     	xdef	_BIT_CODE
6251                     	xdef	_LEDCode
6252                     	xref.b	_RandSeed
6253                     	xref.b	_LightValue
6254                     	xref.b	_CurrentTemp
6255                     	xref.b	_CorrectTemp
6256                     	xref.b	_SetStep
6257                     	xref.b	_SetMenu
6258                     	xref.b	_MachineStatus
6259                     	xbit	_isFlash1Hz
6260                     	xbit	_is50ms
6261                     	xref.b	_LED_Buf
6262                     	xref.b	_Now
6263                     	xdef	__displayDecode
6264                     	xdef	__Display
6265                     	xref.b	c_x
6284                     	xref	c_xymvx
6285                     	xref	c_idiv
6286                     	xref	c_sdivx
6287                     	xref	c_smodx
6288                     	end
