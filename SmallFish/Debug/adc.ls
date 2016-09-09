   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3788                     .const:	section	.text
3789  0000               _tempTable:
3790  0000 26b6          	dc.w	9910
3791  0002 2481          	dc.w	9345
3792  0004 2270          	dc.w	8816
3793  0006 2080          	dc.w	8320
3794  0008 1eae          	dc.w	7854
3795  000a 1cfa          	dc.w	7418
3796  000c 1b61          	dc.w	7009
3797  000e 19e1          	dc.w	6625
3798  0010 1878          	dc.w	6264
3799  0012 1726          	dc.w	5926
3800  0014 15e7          	dc.w	5607
3801  0016 14bc          	dc.w	5308
3802  0018 13a2          	dc.w	5026
3803  001a 1299          	dc.w	4761
3804  001c 11a0          	dc.w	4512
3805  001e 10b5          	dc.w	4277
3806  0020 0fd8          	dc.w	4056
3807  0022 0f08          	dc.w	3848
3808  0024 0e44          	dc.w	3652
3809  0026 0d8b          	dc.w	3467
3810  0028 0cdc          	dc.w	3292
3811  002a 0c37          	dc.w	3127
3812  002c 0b9c          	dc.w	2972
3813  002e 0b09          	dc.w	2825
3814  0030 0a7e          	dc.w	2686
3815  0032 09fb          	dc.w	2555
3816  0034 097f          	dc.w	2431
3817  0036 090a          	dc.w	2314
3818  0038 089b          	dc.w	2203
3819  003a 0832          	dc.w	2098
3820  003c 07cf          	dc.w	1999
3821  003e 0770          	dc.w	1904
3822  0040 0717          	dc.w	1815
3823  0042 06c3          	dc.w	1731
3824  0044 0673          	dc.w	1651
3825  0046 0627          	dc.w	1575
3826  0048 05df          	dc.w	1503
3827  004a 059b          	dc.w	1435
3828  004c 055b          	dc.w	1371
3829  004e 051d          	dc.w	1309
3830  0050 04e3          	dc.w	1251
3831  0052 04ab          	dc.w	1195
3832  0054 0477          	dc.w	1143
3833  0056 0445          	dc.w	1093
3834  0058 0415          	dc.w	1045
3835  005a 03e8          	dc.w	1000
3836  005c 03bd          	dc.w	957
3837  005e 0394          	dc.w	916
3838  0060 036d          	dc.w	877
3839  0062 0348          	dc.w	840
3840  0064 0325          	dc.w	805
3841  0066 0303          	dc.w	771
3842  0068 02e3          	dc.w	739
3843  006a 02c5          	dc.w	709
3844  006c 02a8          	dc.w	680
3845  006e 028c          	dc.w	652
3846  0070 0271          	dc.w	625
3847  0072 0258          	dc.w	600
3848  0074 0240          	dc.w	576
3849  0076 0229          	dc.w	553
3850  0078 0213          	dc.w	531
3851  007a 01fe          	dc.w	510
3852  007c 01ea          	dc.w	490
3853  007e 01d7          	dc.w	471
3854  0080 01c5          	dc.w	453
3855  0082 01b3          	dc.w	435
3856  0084 01a3          	dc.w	419
3857  0086 0193          	dc.w	403
3858  0088 0183          	dc.w	387
3859  008a 0175          	dc.w	373
3860  008c 0167          	dc.w	359
3861  008e 0159          	dc.w	345
3862  0090 014d          	dc.w	333
3863  0092 0140          	dc.w	320
3864  0094 0135          	dc.w	309
3865  0096 0129          	dc.w	297
3866  0098 011f          	dc.w	287
3867  009a 0114          	dc.w	276
3868  009c 010a          	dc.w	266
3869  009e 0101          	dc.w	257
3870  00a0 00f8          	dc.w	248
3871  00a2 00ef          	dc.w	239
3872  00a4 00e6          	dc.w	230
3873  00a6 00de          	dc.w	222
3874  00a8 00d7          	dc.w	215
3875  00aa 00cf          	dc.w	207
3876  00ac 00c8          	dc.w	200
3877  00ae 00c1          	dc.w	193
3878  00b0 00bb          	dc.w	187
3879  00b2 00b4          	dc.w	180
3880  00b4 00ae          	dc.w	174
3881  00b6 00a8          	dc.w	168
3882  00b8 00a3          	dc.w	163
3883  00ba 009d          	dc.w	157
3884  00bc 0098          	dc.w	152
3885  00be 0093          	dc.w	147
3886  00c0 008e          	dc.w	142
3887  00c2 008a          	dc.w	138
3888  00c4 0085          	dc.w	133
3889  00c6 0081          	dc.w	129
3890  00c8 007d          	dc.w	125
3891  00ca 0079          	dc.w	121
3892  00cc 0075          	dc.w	117
3893  00ce 0071          	dc.w	113
3894  00d0 006e          	dc.w	110
3895  00d2 006a          	dc.w	106
3896  00d4 0067          	dc.w	103
3897  00d6 0064          	dc.w	100
3898  00d8 0061          	dc.w	97
3899  00da 005e          	dc.w	94
3900  00dc 005b          	dc.w	91
3901  00de 0058          	dc.w	88
3902  00e0 0056          	dc.w	86
3903  00e2 0053          	dc.w	83
3904  00e4 0051          	dc.w	81
3905  00e6 004e          	dc.w	78
3906  00e8 004c          	dc.w	76
3907  00ea 004a          	dc.w	74
3908  00ec 0047          	dc.w	71
3909  00ee 0045          	dc.w	69
3910  00f0 0043          	dc.w	67
3911  00f2 0041          	dc.w	65
3912  00f4 0040          	dc.w	64
3913  00f6 003e          	dc.w	62
3914  00f8 003c          	dc.w	60
3915  00fa 003a          	dc.w	58
3916  00fc 0039          	dc.w	57
3917  00fe 0037          	dc.w	55
3918  0100 0035          	dc.w	53
3919  0102 0034          	dc.w	52
3920  0104 0033          	dc.w	51
3921  0106 0031          	dc.w	49
3922  0108 0030          	dc.w	48
3923  010a 002f          	dc.w	47
3924  010c 002d          	dc.w	45
3925  010e 002c          	dc.w	44
3926  0110 002b          	dc.w	43
3927  0112 002a          	dc.w	42
3928  0114 0029          	dc.w	41
3929  0116 0028          	dc.w	40
3930  0118 0026          	dc.w	38
3931  011a 0025          	dc.w	37
3932  011c 0024          	dc.w	36
3933  011e 0024          	dc.w	36
3934  0120 0023          	dc.w	35
3935  0122 0022          	dc.w	34
4005                     ; 40 void _ADC_Initial(void)
4005                     ; 41 {
4007                     	switch	.text
4008  0000               __ADC_Initial:
4010  0000 88            	push	a
4011       00000001      OFST:	set	1
4014                     ; 44 	ADC_CR2 = ADC1_ALIGN_RIGHT; // A/D data rigth align
4016  0001 35085402      	mov	_ADC_CR2,#8
4017                     ; 45 	ADC_CR1 = 0x00; // ADC clock=main clock/2=4MHZm,sigle converterm,disable convert
4019  0005 725f5401      	clr	_ADC_CR1
4020                     ; 46 	ADC_CSR = 0x02; // choose channel 2
4022  0009 35025400      	mov	_ADC_CSR,#2
4023                     ; 48 	bitADC1_CR1_ADON = 1;	//ADC_CR1 = 0x01; // enable AD start
4025  000d 72105401      	bset	_bitADC1_CR1_ADON
4026                     ; 50 	for(i=0;i<100;i++); // wait at least 7us
4028  0011 0f01          	clr	(OFST+0,sp)
4029  0013               L3152:
4033  0013 0c01          	inc	(OFST+0,sp)
4036  0015 7b01          	ld	a,(OFST+0,sp)
4037  0017 a164          	cp	a,#100
4038  0019 25f8          	jrult	L3152
4039                     ; 51 	for(i=0;i<100;i++); // wait at least 7us
4041  001b 0f01          	clr	(OFST+0,sp)
4042  001d               L1252:
4046  001d 0c01          	inc	(OFST+0,sp)
4049  001f 7b01          	ld	a,(OFST+0,sp)
4050  0021 a164          	cp	a,#100
4051  0023 25f8          	jrult	L1252
4052                     ; 52 	bitADC1_CR1_ADON = 1;
4054  0025 72105401      	bset	_bitADC1_CR1_ADON
4055                     ; 53 	bitADC1_CSR_EOC = 0;
4057  0029 721f5400      	bres	_bitADC1_CSR_EOC
4058                     ; 54 }
4061  002d 84            	pop	a
4062  002e 81            	ret
4065                     	bsct
4066  0000               L7252_sumTimes:
4067  0000 00            	dc.b	0
4068  0001               L1352_sumTimes1:
4069  0001 00            	dc.b	0
4070  0002               L3352_sum_AD_value:
4071  0002 0000          	dc.w	0
4072  0004               L5352_sum_AD_value1:
4073  0004 0000          	dc.w	0
4074  0006               L7352_CurrentTempBkp:
4075  0006 0000          	dc.w	0
4076  0008               L1452_CurrentTempValue:
4077  0008 0000          	dc.w	0
4078  000a               L3452_lightValue:
4079  000a 0000          	dc.w	0
4080                     .bit:	section	.data,bit
4081  0000               L5452_Channel:
4082  0000 00            	dc.b	0
4216                     	switch	.const
4217  0124               L41:
4218  0124 0000e7cb      	dc.l	59339
4219                     ; 56 void _AD_Conversion(void)
4219                     ; 57 {
4220                     	switch	.text
4221  002f               __AD_Conversion:
4223  002f 5207          	subw	sp,#7
4224       00000007      OFST:	set	7
4227                     ; 67 	if (ADC1_GetFlagStatus(ADC1_FLAG_EOC)== 0) return;// SET or RESET
4229  0031 a680          	ld	a,#128
4230  0033 cd0000        	call	_ADC1_GetFlagStatus
4232  0036 4d            	tnz	a
4233  0037 2603          	jrne	L02
4234  0039 cc01fb        	jp	L61
4235  003c               L02:
4238                     ; 68 	RandSeed = ADC1_GetConversionValue();//For random
4240  003c cd0000        	call	_ADC1_GetConversionValue
4242  003f bf00          	ldw	_RandSeed,x
4243                     ; 69 	if(Channel)
4245                     	btst	L5452_Channel
4246  0046 2452          	jruge	L7362
4247                     ; 71 		Channel = 0;
4249  0048 72110000      	bres	L5452_Channel
4250                     ; 72 		sum_AD_value1 += RandSeed;
4252  004c be04          	ldw	x,L5352_sum_AD_value1
4253  004e 72bb0000      	addw	x,_RandSeed
4254  0052 bf04          	ldw	L5352_sum_AD_value1,x
4255                     ; 73 		ADC_CSR = 0x02;//For Temp
4257  0054 35025400      	mov	_ADC_CSR,#2
4258                     ; 74 		bitADC1_CR1_ADON = 1;//
4260  0058 72105401      	bset	_bitADC1_CR1_ADON
4261                     ; 75 		if(++sumTimes1 >= 16)
4263  005c 3c01          	inc	L1352_sumTimes1
4264  005e b601          	ld	a,L1352_sumTimes1
4265  0060 a110          	cp	a,#16
4266  0062 2403          	jruge	L22
4267  0064 cc01fb        	jp	L3462
4268  0067               L22:
4269                     ; 77 			sumTimes1 = 0;
4271  0067 3f01          	clr	L1352_sumTimes1
4272                     ; 78 			sum_AD_value1 >>= 4;
4274  0069 a604          	ld	a,#4
4275  006b               L01:
4276  006b 3404          	srl	L5352_sum_AD_value1
4277  006d 3605          	rrc	L5352_sum_AD_value1+1
4278  006f 4a            	dec	a
4279  0070 26f9          	jrne	L01
4280                     ; 79 			lightValue = (13*lightValue + sum_AD_value1*3)>>4;//filter
4282  0072 be04          	ldw	x,L5352_sum_AD_value1
4283  0074 90ae0003      	ldw	y,#3
4284  0078 cd0000        	call	c_imul
4286  007b 1f03          	ldw	(OFST-4,sp),x
4287  007d be0a          	ldw	x,L3452_lightValue
4288  007f 90ae000d      	ldw	y,#13
4289  0083 cd0000        	call	c_imul
4291  0086 72fb03        	addw	x,(OFST-4,sp)
4292  0089 54            	srlw	x
4293  008a 54            	srlw	x
4294  008b 54            	srlw	x
4295  008c 54            	srlw	x
4296  008d bf0a          	ldw	L3452_lightValue,x
4297                     ; 80 			LightValue = lightValue;
4299  008f be0a          	ldw	x,L3452_lightValue
4300  0091 bf00          	ldw	_LightValue,x
4301                     ; 81 			sum_AD_value1 = 0;
4303  0093 5f            	clrw	x
4304  0094 bf04          	ldw	L5352_sum_AD_value1,x
4305  0096 acfb01fb      	jpf	L3462
4306  009a               L7362:
4307                     ; 86 		Channel = 1;
4309  009a 72100000      	bset	L5452_Channel
4310                     ; 87 		sum_AD_value += RandSeed;
4312  009e be02          	ldw	x,L3352_sum_AD_value
4313  00a0 72bb0000      	addw	x,_RandSeed
4314  00a4 bf02          	ldw	L3352_sum_AD_value,x
4315                     ; 88 		ADC_CSR = 0x03;//For Light
4317  00a6 35035400      	mov	_ADC_CSR,#3
4318                     ; 89 		bitADC1_CR1_ADON = 1;
4320  00aa 72105401      	bset	_bitADC1_CR1_ADON
4321                     ; 90 		if (++sumTimes >= 16)
4323  00ae 3c00          	inc	L7252_sumTimes
4324  00b0 b600          	ld	a,L7252_sumTimes
4325  00b2 a110          	cp	a,#16
4326  00b4 2403          	jruge	L42
4327  00b6 cc01fb        	jp	L3462
4328  00b9               L42:
4329                     ; 92 			sumTimes = 0;
4331  00b9 3f00          	clr	L7252_sumTimes
4332                     ; 93 			sum_AD_value >>= 4;
4334  00bb a604          	ld	a,#4
4335  00bd               L21:
4336  00bd 3402          	srl	L3352_sum_AD_value
4337  00bf 3603          	rrc	L3352_sum_AD_value+1
4338  00c1 4a            	dec	a
4339  00c2 26f9          	jrne	L21
4340                     ; 94 			if(sum_AD_value >= 1000)//NTC may Open circuit
4342  00c4 be02          	ldw	x,L3352_sum_AD_value
4343  00c6 a303e8        	cpw	x,#1000
4344  00c9 2507          	jrult	L7462
4345                     ; 96 				ResistorValue = RESISTOR_TEMP_LOWLIMIT;
4347  00cb aee7cb        	ldw	x,#59339
4348  00ce 1f05          	ldw	(OFST-2,sp),x
4350  00d0 2025          	jra	L1562
4351  00d2               L7462:
4352                     ; 100 				ResistorValue = (long)sum_AD_value*RES_UPVALUE/(1024-sum_AD_value);
4354  00d2 ae0400        	ldw	x,#1024
4355  00d5 72b00002      	subw	x,L3352_sum_AD_value
4356  00d9 cd0000        	call	c_uitolx
4358  00dc 96            	ldw	x,sp
4359  00dd 1c0001        	addw	x,#OFST-6
4360  00e0 cd0000        	call	c_rtol
4362  00e3 be02          	ldw	x,L3352_sum_AD_value
4363  00e5 90ae03e8      	ldw	y,#1000
4364  00e9 cd0000        	call	c_umul
4366  00ec 96            	ldw	x,sp
4367  00ed 1c0001        	addw	x,#OFST-6
4368  00f0 cd0000        	call	c_ldiv
4370  00f3 be02          	ldw	x,c_lreg+2
4371  00f5 1f05          	ldw	(OFST-2,sp),x
4372  00f7               L1562:
4373                     ; 102 			if (ResistorValue >= RESISTOR_TEMP_LOWLIMIT)//-20`c ,
4375  00f7 9c            	rvf
4376  00f8 1e05          	ldw	x,(OFST-2,sp)
4377  00fa cd0000        	call	c_uitolx
4379  00fd ae0124        	ldw	x,#L41
4380  0100 cd0000        	call	c_lcmp
4382  0103 2f0b          	jrslt	L3562
4383                     ; 104 				ResistorValue = RESISTOR_TEMP_LOWLIMIT;
4385                     ; 105 				CurrentTempValue = -200;
4387  0105 aeff38        	ldw	x,#65336
4388  0108 bf08          	ldw	L1452_CurrentTempValue,x
4389                     ; 106 				ErrorCode = 1;
4391  010a 35010000      	mov	_ErrorCode,#1
4393  010e 2010          	jra	L5562
4394  0110               L3562:
4395                     ; 108 			else if (ResistorValue < RESISTOR_TEMP_UPLIMIT)
4397  0110 1e05          	ldw	x,(OFST-2,sp)
4398  0112 a3002a        	cpw	x,#42
4399  0115 243d          	jruge	L7562
4400                     ; 110 				ResistorValue = RESISTOR_TEMP_UPLIMIT;
4402                     ; 111 				CurrentTempValue = 1110;
4404  0117 ae0456        	ldw	x,#1110
4405  011a bf08          	ldw	L1452_CurrentTempValue,x
4406                     ; 112 				ErrorCode = 2;
4408  011c 35020000      	mov	_ErrorCode,#2
4410  0120               L5562:
4411                     ; 140 			CurrentTempBkp = (13*CurrentTempBkp + CurrentTempValue*3)>>4;//filter
4413  0120 be08          	ldw	x,L1452_CurrentTempValue
4414  0122 90ae0003      	ldw	y,#3
4415  0126 cd0000        	call	c_imul
4417  0129 1f03          	ldw	(OFST-4,sp),x
4418  012b be06          	ldw	x,L7352_CurrentTempBkp
4419  012d 90ae000d      	ldw	y,#13
4420  0131 cd0000        	call	c_imul
4422  0134 72fb03        	addw	x,(OFST-4,sp)
4423  0137 57            	sraw	x
4424  0138 57            	sraw	x
4425  0139 57            	sraw	x
4426  013a 57            	sraw	x
4427  013b bf06          	ldw	L7352_CurrentTempBkp,x
4428                     ; 141 			CurrentTemp = CurrentTempBkp;//+ CorrectTemp*10;
4430  013d be06          	ldw	x,L7352_CurrentTempBkp
4431  013f bf00          	ldw	_CurrentTemp,x
4432                     ; 142 			isUpdateDisplay = Yes;
4434  0141 72100000      	bset	_isUpdateDisplay
4435                     ; 144 			CurrentTemp += CorrectTemp;
4437  0145 be00          	ldw	x,_CurrentTemp
4438  0147 72bb0000      	addw	x,_CorrectTemp
4439  014b bf00          	ldw	_CurrentTemp,x
4440                     ; 145 			sum_AD_value = 0;
4442  014d 5f            	clrw	x
4443  014e bf02          	ldw	L3352_sum_AD_value,x
4444  0150 acfb01fb      	jpf	L3462
4445  0154               L7562:
4446                     ; 116 				ErrorCode = 0;
4448  0154 3f00          	clr	_ErrorCode
4449                     ; 117 				for (i = 0;ResistorValue <= tempTable[i];i++)if(i > 200)break;
4451  0156 0f07          	clr	(OFST+0,sp)
4453  0158 2013          	jra	L7662
4454  015a               L3662:
4457  015a 7b07          	ld	a,(OFST+0,sp)
4458  015c a1c9          	cp	a,#201
4459  015e 250b          	jrult	L3762
4461  0160               L1762:
4462                     ; 118 				if(i == 0)
4464  0160 0d07          	tnz	(OFST+0,sp)
4465  0162 261b          	jrne	L5762
4466                     ; 120 					CurrentTempValue = -200;
4468  0164 aeff38        	ldw	x,#65336
4469  0167 bf08          	ldw	L1452_CurrentTempValue,x
4471  0169 20b5          	jra	L5562
4472  016b               L3762:
4473                     ; 117 				for (i = 0;ResistorValue <= tempTable[i];i++)if(i > 200)break;
4475  016b 0c07          	inc	(OFST+0,sp)
4476  016d               L7662:
4479  016d 7b07          	ld	a,(OFST+0,sp)
4480  016f 5f            	clrw	x
4481  0170 97            	ld	xl,a
4482  0171 58            	sllw	x
4483  0172 9093          	ldw	y,x
4484  0174 51            	exgw	x,y
4485  0175 de0000        	ldw	x,(_tempTable,x)
4486  0178 1305          	cpw	x,(OFST-2,sp)
4487  017a 51            	exgw	x,y
4488  017b 24dd          	jruge	L3662
4489  017d 20e1          	jra	L1762
4490  017f               L5762:
4491                     ; 124 					temp0 = (long)10*(tempTable[i-1]-ResistorValue)/(tempTable[i-1]-tempTable[i])+1;
4493  017f 7b07          	ld	a,(OFST+0,sp)
4494  0181 5f            	clrw	x
4495  0182 97            	ld	xl,a
4496  0183 58            	sllw	x
4497  0184 5a            	decw	x
4498  0185 5a            	decw	x
4499  0186 de0000        	ldw	x,(_tempTable,x)
4500  0189 7b07          	ld	a,(OFST+0,sp)
4501  018b 905f          	clrw	y
4502  018d 9097          	ld	yl,a
4503  018f 9058          	sllw	y
4504  0191 90de0000      	ldw	y,(_tempTable,y)
4505  0195 90bf00        	ldw	c_x,y
4506  0198 72b00000      	subw	x,c_x
4507  019c cd0000        	call	c_uitolx
4509  019f 96            	ldw	x,sp
4510  01a0 1c0001        	addw	x,#OFST-6
4511  01a3 cd0000        	call	c_rtol
4513  01a6 7b07          	ld	a,(OFST+0,sp)
4514  01a8 5f            	clrw	x
4515  01a9 97            	ld	xl,a
4516  01aa 58            	sllw	x
4517  01ab 5a            	decw	x
4518  01ac 5a            	decw	x
4519  01ad de0000        	ldw	x,(_tempTable,x)
4520  01b0 72f005        	subw	x,(OFST-2,sp)
4521  01b3 a60a          	ld	a,#10
4522  01b5 cd0000        	call	c_cmulx
4524  01b8 96            	ldw	x,sp
4525  01b9 1c0001        	addw	x,#OFST-6
4526  01bc cd0000        	call	c_ldiv
4528  01bf a601          	ld	a,#1
4529  01c1 cd0000        	call	c_ladc
4531  01c4 be02          	ldw	x,c_lreg+2
4532  01c6 1f05          	ldw	(OFST-2,sp),x
4533                     ; 125 					CurrentTempValue = -200+(i-1)*10+temp0;
4535  01c8 7b07          	ld	a,(OFST+0,sp)
4536  01ca 97            	ld	xl,a
4537  01cb a60a          	ld	a,#10
4538  01cd 42            	mul	x,a
4539  01ce 1d00d2        	subw	x,#210
4540  01d1 72fb05        	addw	x,(OFST-2,sp)
4541  01d4 bf08          	ldw	L1452_CurrentTempValue,x
4542                     ; 126 					if (CurrentTempValue <= -200)
4544  01d6 9c            	rvf
4545  01d7 be08          	ldw	x,L1452_CurrentTempValue
4546  01d9 a3ff39        	cpw	x,#65337
4547  01dc 2e09          	jrsge	L1072
4548                     ; 128 						CurrentTempValue = -200;
4550  01de aeff38        	ldw	x,#65336
4551  01e1 bf08          	ldw	L1452_CurrentTempValue,x
4553  01e3 ac200120      	jpf	L5562
4554  01e7               L1072:
4555                     ; 132 						if(CurrentTempValue > 1110)
4557  01e7 9c            	rvf
4558  01e8 be08          	ldw	x,L1452_CurrentTempValue
4559  01ea a30457        	cpw	x,#1111
4560  01ed 2e03          	jrsge	L62
4561  01ef cc0120        	jp	L5562
4562  01f2               L62:
4563                     ; 134 							CurrentTempValue = 1110;
4565  01f2 ae0456        	ldw	x,#1110
4566  01f5 bf08          	ldw	L1452_CurrentTempValue,x
4567  01f7 ac200120      	jpf	L5562
4568  01fb               L3462:
4569                     ; 148 }
4570  01fb               L61:
4573  01fb 5b07          	addw	sp,#7
4574  01fd 81            	ret
4599                     	xdef	_tempTable
4600                     	xref	_ADC1_GetFlagStatus
4601                     	xref	_ADC1_GetConversionValue
4602                     	xref.b	_RandSeed
4603                     	xref.b	_ErrorCode
4604                     	xref.b	_LightValue
4605                     	xref.b	_CurrentTemp
4606                     	xref.b	_CorrectTemp
4607                     	xbit	_isUpdateDisplay
4608                     	xdef	__AD_Conversion
4609                     	xdef	__ADC_Initial
4610                     	xref.b	c_lreg
4611                     	xref.b	c_x
4612                     	xref.b	c_y
4631                     	xref	c_ladc
4632                     	xref	c_cmulx
4633                     	xref	c_lcmp
4634                     	xref	c_ldiv
4635                     	xref	c_rtol
4636                     	xref	c_uitolx
4637                     	xref	c_umul
4638                     	xref	c_imul
4639                     	end
