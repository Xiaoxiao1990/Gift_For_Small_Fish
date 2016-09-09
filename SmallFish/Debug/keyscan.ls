   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3842                     ; 34 void _IOInitial(void)
3842                     ; 35 {
3844                     	switch	.text
3845  0000               __IOInitial:
3849                     ; 37 }
3852  0000 81            	ret
3855                     	bsct
3856  0000               L5052_keyNewValue:
3857  0000 00            	dc.b	0
3858  0001               L3152_time_CNT:
3859  0001 00            	dc.b	0
3860                     	switch	.ubsct
3861  0000               L7052_keyScanCnt:
3862  0000 0000          	ds.b	2
3863  0002               L1152_steps:
3864  0002 00            	ds.b	1
3942                     ; 39 void _keyScan(void)
3942                     ; 40 {
3943                     	switch	.text
3944  0001               __keyScan:
3946  0001 5203          	subw	sp,#3
3947       00000003      OFST:	set	3
3950                     ; 47 	if(++time_CNT < 10)
3952  0003 3c01          	inc	L3152_time_CNT
3953  0005 b601          	ld	a,L3152_time_CNT
3954  0007 a10a          	cp	a,#10
3955  0009 2403          	jruge	L41
3956  000b cc00b4        	jp	L21
3957  000e               L41:
3958                     ; 49 		return;
3960                     ; 51 	time_CNT = 0;
3962  000e 3f01          	clr	L3152_time_CNT
3963                     ; 53 	keyStatus = PORT_KEY ^ KEYRELEASE_PORTVALUE;
3965  0010 c65001        	ld	a,_PA_IDR
3966  0013 a408          	and	a,#8
3967  0015 44            	srl	a
3968  0016 6b02          	ld	(OFST-1,sp),a
3969  0018 c6500b        	ld	a,_PC_IDR
3970  001b a440          	and	a,#64
3971  001d 4e            	swap	a
3972  001e 44            	srl	a
3973  001f a407          	and	a,#7
3974  0021 6b01          	ld	(OFST-2,sp),a
3975  0023 c65010        	ld	a,_PD_IDR
3976  0026 a440          	and	a,#64
3977  0028 4e            	swap	a
3978  0029 44            	srl	a
3979  002a 44            	srl	a
3980  002b a403          	and	a,#3
3981  002d 1a01          	or	a,(OFST-2,sp)
3982  002f 1a02          	or	a,(OFST-1,sp)
3983  0031 6b03          	ld	(OFST+0,sp),a
3984                     ; 54 	switch(steps)
3986  0033 b602          	ld	a,L1152_steps
3988                     ; 107 		default:;
3989  0035 4d            	tnz	a
3990  0036 2708          	jreq	L5152
3991  0038 4a            	dec	a
3992  0039 271e          	jreq	L7152
3993  003b 4a            	dec	a
3994  003c 273e          	jreq	L1252
3995  003e 2074          	jra	L7652
3996  0040               L5152:
3997                     ; 58 			if(keyStatus != 0)
3999  0040 0d03          	tnz	(OFST+0,sp)
4000  0042 2708          	jreq	L1752
4001                     ; 60 				keyNewValue = keyStatus; 			//store the keys value;
4003  0044 7b03          	ld	a,(OFST+0,sp)
4004  0046 b700          	ld	L5052_keyNewValue,a
4005                     ; 61 				steps++;											//turn to next step
4007  0048 3c02          	inc	L1152_steps
4009  004a 2068          	jra	L7652
4010  004c               L1752:
4011                     ; 65 				keyScanCnt = 0;
4013  004c 5f            	clrw	x
4014  004d bf00          	ldw	L7052_keyScanCnt,x
4015                     ; 66 				isKeyLongPress = 0;
4017  004f 72110002      	bres	_isKeyLongPress
4018                     ; 67 				isCanEffect = 1;
4020  0053 72100000      	bset	_isCanEffect
4021  0057 205b          	jra	L7652
4022  0059               L7152:
4023                     ; 72 			if(keyStatus == keyNewValue)		//if the keys value is not change
4025  0059 7b03          	ld	a,(OFST+0,sp)
4026  005b b100          	cp	a,L5052_keyNewValue
4027  005d 2616          	jrne	L5752
4028                     ; 74 				if(++keyScanCnt > KEY_SHORT_PRESS)					//dealy
4030  005f be00          	ldw	x,L7052_keyScanCnt
4031  0061 1c0001        	addw	x,#1
4032  0064 bf00          	ldw	L7052_keyScanCnt,x
4033  0066 a3001f        	cpw	x,#31
4034  0069 2549          	jrult	L7652
4035                     ; 76 					keyScanCnt = 0;							//clear counter
4037  006b 5f            	clrw	x
4038  006c bf00          	ldw	L7052_keyScanCnt,x
4039                     ; 77 					steps++;										//turn to next step
4041  006e 3c02          	inc	L1152_steps
4042                     ; 78 					keyActiveValue = keyNewValue;
4044  0070 450007        	mov	_keyActiveValue,L5052_keyNewValue
4045  0073 203f          	jra	L7652
4046  0075               L5752:
4047                     ; 83 				keyScanCnt = 0;								//clear time counter
4049  0075 5f            	clrw	x
4050  0076 bf00          	ldw	L7052_keyScanCnt,x
4051                     ; 84 				steps--;       								//back to first step
4053  0078 3a02          	dec	L1152_steps
4054  007a 2038          	jra	L7652
4055  007c               L1252:
4056                     ; 89 			if(keyStatus != keyNewValue)//Key release
4058  007c 7b03          	ld	a,(OFST+0,sp)
4059  007e b100          	cp	a,L5052_keyNewValue
4060  0080 271b          	jreq	L3062
4061                     ; 91 				if(!isKeyLongPress)isKeyProcess = 1;
4063                     	btst	_isKeyLongPress
4064  0087 2504          	jrult	L5062
4067  0089 72100001      	bset	_isKeyProcess
4068  008d               L5062:
4069                     ; 92 				steps = 0;
4071  008d 3f02          	clr	L1152_steps
4072                     ; 93 				keyScanCnt = 0;
4074  008f 5f            	clrw	x
4075  0090 bf00          	ldw	L7052_keyScanCnt,x
4076                     ; 94 				longPressBase = LONG_PRESS_COUNT;
4078  0092 ae1f40        	ldw	x,#8000
4079  0095 bf03          	ldw	_longPressBase,x
4080                     ; 95 				REC = 0;//Release Recoder
4082  0097 72135000      	bres	_PA_ODR_1
4084  009b 2017          	jra	L7652
4085  009d               L3062:
4086                     ; 99 				if(++keyScanCnt > KEY_LONG_PRESS)  //if key long time press
4088  009d be00          	ldw	x,L7052_keyScanCnt
4089  009f 1c0001        	addw	x,#1
4090  00a2 bf00          	ldw	L7052_keyScanCnt,x
4091  00a4 a302bd        	cpw	x,#701
4092  00a7 2509          	jrult	L1162
4093                     ; 101 					keyScanCnt = KEY_SHORT_PRESS;
4095  00a9 ae001e        	ldw	x,#30
4096  00ac bf00          	ldw	L7052_keyScanCnt,x
4097                     ; 102 					isKeyLongPress = 1;						  //set key long time press flag
4099  00ae 72100002      	bset	_isKeyLongPress
4100  00b2               L1162:
4101                     ; 104 				inSetTimer = 0;										//Any key is pressed clear the time counter
4103  00b2 3f00          	clr	_inSetTimer
4104  00b4               L7652:
4105                     ; 109 }
4106  00b4               L21:
4109  00b4 5b03          	addw	sp,#3
4110  00b6 81            	ret
4151                     ; 111 void opreat(uchar opcode)
4151                     ; 112 {
4152                     	switch	.text
4153  00b7               _opreat:
4155  00b7 88            	push	a
4156       00000000      OFST:	set	0
4159                     ; 113 	if(opcode == KEY_ADD)
4161  00b8 a104          	cp	a,#4
4162  00ba 2703          	jreq	L43
4163  00bc cc01c6        	jp	L3572
4164  00bf               L43:
4165                     ; 115 		switch(SetMenu)
4167  00bf b600          	ld	a,_SetMenu
4169                     ; 166 			default:;
4170  00c1 4d            	tnz	a
4171  00c2 2603          	jrne	L63
4172  00c4 cc02be        	jp	L5103
4173  00c7               L63:
4174  00c7 4a            	dec	a
4175  00c8 2722          	jreq	L5162
4176  00ca 4a            	dec	a
4177  00cb 2603          	jrne	L04
4178  00cd cc01a6        	jp	L5362
4179  00d0               L04:
4180  00d0 4a            	dec	a
4181  00d1 2603          	jrne	L24
4182  00d3 cc02be        	jp	L5103
4183  00d6               L24:
4184  00d6 4a            	dec	a
4185  00d7 2603          	jrne	L44
4186  00d9 cc02be        	jp	L5103
4187  00dc               L44:
4188  00dc 4a            	dec	a
4189  00dd 2603          	jrne	L64
4190  00df cc02be        	jp	L5103
4191  00e2               L64:
4192  00e2 4a            	dec	a
4193  00e3 2603          	jrne	L05
4194  00e5 cc02be        	jp	L5103
4195  00e8               L05:
4196  00e8 acbe02be      	jpf	L5103
4197  00ec               L5162:
4198                     ; 120 				switch(SetStep)
4200  00ec b600          	ld	a,_SetStep
4202                     ; 154 					default:;
4203  00ee 4d            	tnz	a
4204  00ef 2716          	jreq	L7162
4205  00f1 4a            	dec	a
4206  00f2 272b          	jreq	L1262
4207  00f4 4a            	dec	a
4208  00f5 2755          	jreq	L3262
4209  00f7 4a            	dec	a
4210  00f8 2765          	jreq	L5262
4211  00fa 4a            	dec	a
4212  00fb 277a          	jreq	L7262
4213  00fd 4a            	dec	a
4214  00fe 2603          	jrne	L25
4215  0100 cc018a        	jp	L1362
4216  0103               L25:
4217  0103 acbe02be      	jpf	L5103
4218  0107               L7162:
4219                     ; 124 						if(Now.Hour < 14)Now.Hour += 10;
4221  0107 b600          	ld	a,_Now
4222  0109 a10e          	cp	a,#14
4223  010b 240a          	jruge	L5672
4226  010d b600          	ld	a,_Now
4227  010f ab0a          	add	a,#10
4228  0111 b700          	ld	_Now,a
4230  0113 acbe02be      	jpf	L5103
4231  0117               L5672:
4232                     ; 125 						else Now.Hour = 20;
4234  0117 35140000      	mov	_Now,#20
4235  011b acbe02be      	jpf	L5103
4236  011f               L1262:
4237                     ; 129 						if(Now.Hour < 20)
4239  011f b600          	ld	a,_Now
4240  0121 a114          	cp	a,#20
4241  0123 2418          	jruge	L1772
4242                     ; 131 							if(Now.Hour%10 < 9)Now.Hour++;
4244  0125 9c            	rvf
4245  0126 b600          	ld	a,_Now
4246  0128 5f            	clrw	x
4247  0129 97            	ld	xl,a
4248  012a a60a          	ld	a,#10
4249  012c cd0000        	call	c_smodx
4251  012f a30009        	cpw	x,#9
4252  0132 2f03          	jrslt	L45
4253  0134 cc02be        	jp	L5103
4254  0137               L45:
4257  0137 3c00          	inc	_Now
4258  0139 acbe02be      	jpf	L5103
4259  013d               L1772:
4260                     ; 135 							if(Now.Hour < 23)Now.Hour++;
4262  013d b600          	ld	a,_Now
4263  013f a117          	cp	a,#23
4264  0141 2503          	jrult	L65
4265  0143 cc02be        	jp	L5103
4266  0146               L65:
4269  0146 3c00          	inc	_Now
4270  0148 acbe02be      	jpf	L5103
4271  014c               L3262:
4272                     ; 140 						if(Now.Minute < 50)Now.Minute += 10;
4274  014c b601          	ld	a,_Now+1
4275  014e a132          	cp	a,#50
4276  0150 2503          	jrult	L06
4277  0152 cc02be        	jp	L5103
4278  0155               L06:
4281  0155 b601          	ld	a,_Now+1
4282  0157 ab0a          	add	a,#10
4283  0159 b701          	ld	_Now+1,a
4284  015b acbe02be      	jpf	L5103
4285  015f               L5262:
4286                     ; 144 						if(Now.Minute%10 < 9)Now.Minute++;
4288  015f 9c            	rvf
4289  0160 b601          	ld	a,_Now+1
4290  0162 5f            	clrw	x
4291  0163 97            	ld	xl,a
4292  0164 a60a          	ld	a,#10
4293  0166 cd0000        	call	c_smodx
4295  0169 a30009        	cpw	x,#9
4296  016c 2f03          	jrslt	L26
4297  016e cc02be        	jp	L5103
4298  0171               L26:
4301  0171 3c01          	inc	_Now+1
4302  0173 acbe02be      	jpf	L5103
4303  0177               L7262:
4304                     ; 148 						if(Now.Second < 50)Now.Second += 10;
4306  0177 b602          	ld	a,_Now+2
4307  0179 a132          	cp	a,#50
4308  017b 2503          	jrult	L46
4309  017d cc02be        	jp	L5103
4310  0180               L46:
4313  0180 b602          	ld	a,_Now+2
4314  0182 ab0a          	add	a,#10
4315  0184 b702          	ld	_Now+2,a
4316  0186 acbe02be      	jpf	L5103
4317  018a               L1362:
4318                     ; 152 						if(Now.Second%10 < 9)Now.Second++;
4320  018a 9c            	rvf
4321  018b b602          	ld	a,_Now+2
4322  018d 5f            	clrw	x
4323  018e 97            	ld	xl,a
4324  018f a60a          	ld	a,#10
4325  0191 cd0000        	call	c_smodx
4327  0194 a30009        	cpw	x,#9
4328  0197 2f03          	jrslt	L66
4329  0199 cc02be        	jp	L5103
4330  019c               L66:
4333  019c 3c02          	inc	_Now+2
4334  019e acbe02be      	jpf	L5103
4335  01a2               L3672:
4336                     ; 156 			}break;
4338  01a2 acbe02be      	jpf	L5103
4339  01a6               L5362:
4340                     ; 159 				if(CorrectTemp < 100)CorrectTemp++;
4342  01a6 9c            	rvf
4343  01a7 be00          	ldw	x,_CorrectTemp
4344  01a9 a30064        	cpw	x,#100
4345  01ac 2e0b          	jrsge	L1103
4348  01ae be00          	ldw	x,_CorrectTemp
4349  01b0 1c0001        	addw	x,#1
4350  01b3 bf00          	ldw	_CorrectTemp,x
4352  01b5 acbe02be      	jpf	L5103
4353  01b9               L1103:
4354                     ; 160 				else CorrectTemp = 100;
4356  01b9 ae0064        	ldw	x,#100
4357  01bc bf00          	ldw	_CorrectTemp,x
4358  01be acbe02be      	jpf	L5103
4359  01c2               L7572:
4360                     ; 166 			default:;
4361  01c2 acbe02be      	jpf	L5103
4362  01c6               L3572:
4363                     ; 169 	else if(opcode == KEY_SUB)
4365  01c6 7b01          	ld	a,(OFST+1,sp)
4366  01c8 a102          	cp	a,#2
4367  01ca 2703          	jreq	L07
4368  01cc cc02a1        	jp	L7103
4369  01cf               L07:
4370                     ; 171 		switch(SetMenu)
4372  01cf b600          	ld	a,_SetMenu
4374                     ; 217 			default:;
4375  01d1 4d            	tnz	a
4376  01d2 2725          	jreq	L1562
4377  01d4 4a            	dec	a
4378  01d5 272e          	jreq	L3562
4379  01d7 4a            	dec	a
4380  01d8 2603          	jrne	L27
4381  01da cc0287        	jp	L3762
4382  01dd               L27:
4383  01dd 4a            	dec	a
4384  01de 2603          	jrne	L47
4385  01e0 cc02be        	jp	L5103
4386  01e3               L47:
4387  01e3 4a            	dec	a
4388  01e4 2603          	jrne	L67
4389  01e6 cc02be        	jp	L5103
4390  01e9               L67:
4391  01e9 4a            	dec	a
4392  01ea 2603          	jrne	L001
4393  01ec cc02be        	jp	L5103
4394  01ef               L001:
4395  01ef 4a            	dec	a
4396  01f0 2603          	jrne	L201
4397  01f2 cc02be        	jp	L5103
4398  01f5               L201:
4399  01f5 acbe02be      	jpf	L5103
4400  01f9               L1562:
4401                     ; 173 			case FUNCTION_0:PLAYE = 0;PLAYE = 1;break;
4403  01f9 72155000      	bres	_PA_ODR_2
4406  01fd 72145000      	bset	_PA_ODR_2
4409  0201 acbe02be      	jpf	L5103
4410  0205               L3562:
4411                     ; 176 				switch(SetStep)
4413  0205 b600          	ld	a,_SetStep
4415                     ; 205 					default:;
4416  0207 4d            	tnz	a
4417  0208 2713          	jreq	L5562
4418  020a 4a            	dec	a
4419  020b 2723          	jreq	L7562
4420  020d 4a            	dec	a
4421  020e 2733          	jreq	L1662
4422  0210 4a            	dec	a
4423  0211 273e          	jreq	L3662
4424  0213 4a            	dec	a
4425  0214 274e          	jreq	L5662
4426  0216 4a            	dec	a
4427  0217 2759          	jreq	L7662
4428  0219 acbe02be      	jpf	L5103
4429  021d               L5562:
4430                     ; 180 						if(Now.Hour > 9)Now.Hour -= 10;
4432  021d b600          	ld	a,_Now
4433  021f a10a          	cp	a,#10
4434  0221 2403          	jruge	L401
4435  0223 cc02be        	jp	L5103
4436  0226               L401:
4439  0226 b600          	ld	a,_Now
4440  0228 a00a          	sub	a,#10
4441  022a b700          	ld	_Now,a
4442  022c acbe02be      	jpf	L5103
4443  0230               L7562:
4444                     ; 184 						if(Now.Hour%10 > 0)
4446  0230 9c            	rvf
4447  0231 b600          	ld	a,_Now
4448  0233 5f            	clrw	x
4449  0234 97            	ld	xl,a
4450  0235 a60a          	ld	a,#10
4451  0237 cd0000        	call	c_smodx
4453  023a a30000        	cpw	x,#0
4454  023d 2d7f          	jrsle	L5103
4455                     ; 186 							Now.Hour--;
4457  023f 3a00          	dec	_Now
4458  0241 207b          	jra	L5103
4459  0243               L1662:
4460                     ; 191 						if(Now.Minute > 9)Now.Minute -= 10;
4462  0243 b601          	ld	a,_Now+1
4463  0245 a10a          	cp	a,#10
4464  0247 2575          	jrult	L5103
4467  0249 b601          	ld	a,_Now+1
4468  024b a00a          	sub	a,#10
4469  024d b701          	ld	_Now+1,a
4470  024f 206d          	jra	L5103
4471  0251               L3662:
4472                     ; 195 						if(Now.Minute%10 > 0)Now.Minute--;
4474  0251 9c            	rvf
4475  0252 b601          	ld	a,_Now+1
4476  0254 5f            	clrw	x
4477  0255 97            	ld	xl,a
4478  0256 a60a          	ld	a,#10
4479  0258 cd0000        	call	c_smodx
4481  025b a30000        	cpw	x,#0
4482  025e 2d5e          	jrsle	L5103
4485  0260 3a01          	dec	_Now+1
4486  0262 205a          	jra	L5103
4487  0264               L5662:
4488                     ; 199 						if(Now.Second > 9)Now.Second -= 10;
4490  0264 b602          	ld	a,_Now+2
4491  0266 a10a          	cp	a,#10
4492  0268 2554          	jrult	L5103
4495  026a b602          	ld	a,_Now+2
4496  026c a00a          	sub	a,#10
4497  026e b702          	ld	_Now+2,a
4498  0270 204c          	jra	L5103
4499  0272               L7662:
4500                     ; 203 						if(Now.Second%10 > 0)Now.Second--;
4502  0272 9c            	rvf
4503  0273 b602          	ld	a,_Now+2
4504  0275 5f            	clrw	x
4505  0276 97            	ld	xl,a
4506  0277 a60a          	ld	a,#10
4507  0279 cd0000        	call	c_smodx
4509  027c a30000        	cpw	x,#0
4510  027f 2d3d          	jrsle	L5103
4513  0281 3a02          	dec	_Now+2
4514  0283 2039          	jra	L5103
4515  0285               L7203:
4516                     ; 207 			}break;
4518  0285 2037          	jra	L5103
4519  0287               L3762:
4520                     ; 210 				if(CorrectTemp > -100)CorrectTemp--;
4522  0287 9c            	rvf
4523  0288 be00          	ldw	x,_CorrectTemp
4524  028a a3ff9d        	cpw	x,#65437
4525  028d 2f09          	jrslt	L5403
4528  028f be00          	ldw	x,_CorrectTemp
4529  0291 1d0001        	subw	x,#1
4530  0294 bf00          	ldw	_CorrectTemp,x
4532  0296 2026          	jra	L5103
4533  0298               L5403:
4534                     ; 211 				else CorrectTemp = -100;
4536  0298 aeff9c        	ldw	x,#65436
4537  029b bf00          	ldw	_CorrectTemp,x
4538  029d 201f          	jra	L5103
4539  029f               L3203:
4540                     ; 217 			default:;
4541  029f 201d          	jra	L5103
4542  02a1               L7103:
4543                     ; 222 		switch(SetMenu)
4545  02a1 b600          	ld	a,_SetMenu
4547                     ; 248 			default:;
4548  02a3 4d            	tnz	a
4549  02a4 2714          	jreq	L7072
4550  02a6 4a            	dec	a
4551  02a7 2717          	jreq	L1172
4552  02a9 4a            	dec	a
4553  02aa 273b          	jreq	L1272
4554  02ac 4a            	dec	a
4555  02ad 270f          	jreq	L5103
4556  02af 4a            	dec	a
4557  02b0 270c          	jreq	L5103
4558  02b2 4a            	dec	a
4559  02b3 2709          	jreq	L5103
4560  02b5 4a            	dec	a
4561  02b6 2706          	jreq	L5103
4562  02b8 2004          	jra	L5103
4563  02ba               L7072:
4564                     ; 224 			case FUNCTION_0:MachineStatus = SELECT;break;
4566  02ba 35010000      	mov	_MachineStatus,#1
4568  02be               L5103:
4569                     ; 251 }
4572  02be 84            	pop	a
4573  02bf 81            	ret
4574  02c0               L1172:
4575                     ; 227 				switch(SetStep)
4577  02c0 b600          	ld	a,_SetStep
4579                     ; 240 					default:;
4580  02c2 4d            	tnz	a
4581  02c3 2711          	jreq	L3172
4582  02c5 4a            	dec	a
4583  02c6 270e          	jreq	L3172
4584  02c8 4a            	dec	a
4585  02c9 270b          	jreq	L3172
4586  02cb 4a            	dec	a
4587  02cc 2708          	jreq	L3172
4588  02ce 4a            	dec	a
4589  02cf 2705          	jreq	L3172
4590  02d1 4a            	dec	a
4591  02d2 2706          	jreq	L5172
4592  02d4 20e8          	jra	L5103
4593  02d6               L3172:
4594                     ; 229 					case SET_TIME_HH:
4594                     ; 230 					case SET_TIME_HL:
4594                     ; 231 					case SET_TIME_MH:
4594                     ; 232 					case SET_TIME_ML:
4594                     ; 233 					case SET_TIME_SH:SetStep++;break;
4596  02d6 3c00          	inc	_SetStep
4599  02d8 20e4          	jra	L5103
4600  02da               L5172:
4601                     ; 236 						SetStep = 0;
4603  02da 3f00          	clr	_SetStep
4604                     ; 237 						MachineStatus = SELECT;
4606  02dc 35010000      	mov	_MachineStatus,#1
4607                     ; 238 						_setTime();
4609  02e0 cd0000        	call	__setTime
4611                     ; 239 					}break;
4613  02e3 20d9          	jra	L5103
4614  02e5               L1603:
4615                     ; 242 			}break;
4617  02e5 20d7          	jra	L5103
4618  02e7               L1272:
4619                     ; 243 			case FUNCTION_2:MachineStatus = SELECT;break;
4621  02e7 35010000      	mov	_MachineStatus,#1
4624  02eb 20d1          	jra	L5103
4625  02ed               L5503:
4626  02ed 20cf          	jra	L5103
4652                     ; 253 void keyaddprocess(void)
4652                     ; 254 {
4653                     	switch	.text
4654  02ef               _keyaddprocess:
4658                     ; 255 	switch(MachineStatus)
4660  02ef b600          	ld	a,_MachineStatus
4662                     ; 266 		default:;
4663  02f1 4d            	tnz	a
4664  02f2 2719          	jreq	L5013
4665  02f4 4a            	dec	a
4666  02f5 2705          	jreq	L5603
4667  02f7 4a            	dec	a
4668  02f8 270e          	jreq	L7603
4669  02fa 2011          	jra	L5013
4670  02fc               L5603:
4671                     ; 260 			if(++SetMenu > FUNCTION_6)SetMenu = FUNCTION_0;
4673  02fc 3c00          	inc	_SetMenu
4674  02fe b600          	ld	a,_SetMenu
4675  0300 a107          	cp	a,#7
4676  0302 2509          	jrult	L5013
4679  0304 3f00          	clr	_SetMenu
4680  0306 2005          	jra	L5013
4681  0308               L7603:
4682                     ; 264 			opreat(KEY_ADD);
4684  0308 a604          	ld	a,#4
4685  030a cd00b7        	call	_opreat
4687                     ; 265 		}break;
4689  030d               L5013:
4690                     ; 268 }
4693  030d 81            	ret
4719                     ; 270 void keysubprocess(void)
4719                     ; 271 {
4720                     	switch	.text
4721  030e               _keysubprocess:
4725                     ; 272 	switch(MachineStatus)
4727  030e b600          	ld	a,_MachineStatus
4729                     ; 284 		default:;
4730  0310 4d            	tnz	a
4731  0311 271b          	jreq	L3313
4732  0313 4a            	dec	a
4733  0314 2705          	jreq	L3113
4734  0316 4a            	dec	a
4735  0317 2710          	jreq	L5113
4736  0319 2013          	jra	L3313
4737  031b               L3113:
4738                     ; 277 			if(SetMenu > FUNCTION_0)SetMenu--;
4740  031b 3d00          	tnz	_SetMenu
4741  031d 2704          	jreq	L5313
4744  031f 3a00          	dec	_SetMenu
4746  0321 200b          	jra	L3313
4747  0323               L5313:
4748                     ; 278 			else SetMenu = FUNCTION_6;
4750  0323 35060000      	mov	_SetMenu,#6
4751  0327 2005          	jra	L3313
4752  0329               L5113:
4753                     ; 282 			opreat(KEY_SUB);
4755  0329 a602          	ld	a,#2
4756  032b cd00b7        	call	_opreat
4758                     ; 283 		}break;
4760  032e               L3313:
4761                     ; 286 }
4764  032e 81            	ret
4791                     ; 288 void keysetprocess(void)
4791                     ; 289 {
4792                     	switch	.text
4793  032f               _keysetprocess:
4797                     ; 290 	switch(MachineStatus)
4799  032f b600          	ld	a,_MachineStatus
4801                     ; 306 		default:;
4802  0331 4d            	tnz	a
4803  0332 2708          	jreq	L1413
4804  0334 4a            	dec	a
4805  0335 270b          	jreq	L3413
4806  0337 4a            	dec	a
4807  0338 270e          	jreq	L5413
4808  033a 2011          	jra	L3613
4809  033c               L1413:
4810                     ; 294 			MachineStatus++;
4812  033c 3c00          	inc	_MachineStatus
4813                     ; 295 			SetMenu = 0;
4815  033e 3f00          	clr	_SetMenu
4816                     ; 296 		}break;
4818  0340 200b          	jra	L3613
4819  0342               L3413:
4820                     ; 299 			MachineStatus++;
4822  0342 3c00          	inc	_MachineStatus
4823                     ; 300 			SetStep = 0;
4825  0344 3f00          	clr	_SetStep
4826                     ; 301 		}break;
4828  0346 2005          	jra	L3613
4829  0348               L5413:
4830                     ; 304 			opreat(KEY_SET);
4832  0348 a601          	ld	a,#1
4833  034a cd00b7        	call	_opreat
4835                     ; 305 		}break;
4837  034d               L3613:
4838                     ; 308 }
4841  034d 81            	ret
4878                     ; 310 void _keyScanProcess(void)
4878                     ; 311 {
4879                     	switch	.text
4880  034e               __keyScanProcess:
4884                     ; 312 	if (isKeyLongPress)
4886                     	btst	_isKeyLongPress
4887  0353 244f          	jruge	L5023
4888                     ; 314 		longPressCnt += LONG_PRESS_ADD_UINT;
4890  0355 be05          	ldw	x,_longPressCnt
4891  0357 1c0004        	addw	x,#4
4892  035a bf05          	ldw	_longPressCnt,x
4893                     ; 315 		if(++longPressCnt > longPressBase)
4895  035c be05          	ldw	x,_longPressCnt
4896  035e 1c0001        	addw	x,#1
4897  0361 bf05          	ldw	_longPressCnt,x
4898  0363 b303          	cpw	x,_longPressBase
4899  0365 233d          	jrule	L5023
4900                     ; 317 			longPressCnt = 0;
4902  0367 5f            	clrw	x
4903  0368 bf05          	ldw	_longPressCnt,x
4904                     ; 318 			if(longPressBase > LONG_PRESS_LIMIT)
4906  036a be03          	ldw	x,_longPressBase
4907  036c a30bb9        	cpw	x,#3001
4908  036f 2507          	jrult	L1123
4909                     ; 320 				longPressBase -= LONG_PRESS_SUB_UNIT;
4911  0371 be03          	ldw	x,_longPressBase
4912  0373 1d00b4        	subw	x,#180
4913  0376 bf03          	ldw	_longPressBase,x
4914  0378               L1123:
4915                     ; 323 			if(keyActiveValue == KEY_ADD)
4917  0378 b607          	ld	a,_keyActiveValue
4918  037a a104          	cp	a,#4
4919  037c 2618          	jrne	L3123
4920                     ; 325 				if(MachineStatus == SETTING)
4922  037e b600          	ld	a,_MachineStatus
4923  0380 a102          	cp	a,#2
4924  0382 2620          	jrne	L5023
4925                     ; 327 					inSetTimer = 0;
4927  0384 3f00          	clr	_inSetTimer
4928                     ; 328 					if(SetMenu == FUNCTION_0)//recoder
4930  0386 3d00          	tnz	_SetMenu
4931  0388 2606          	jrne	L7123
4932                     ; 330 						REC = 1;
4934  038a 72125000      	bset	_PA_ODR_1
4936  038e 2014          	jra	L5023
4937  0390               L7123:
4938                     ; 332 					else isKeyProcess = 1;
4940  0390 72100001      	bset	_isKeyProcess
4941  0394 200e          	jra	L5023
4942  0396               L3123:
4943                     ; 335 			else if(keyActiveValue == KEY_SET)
4945  0396 b607          	ld	a,_keyActiveValue
4946  0398 a101          	cp	a,#1
4947  039a 2608          	jrne	L5023
4948                     ; 337 				MachineStatus = SELECT;
4950  039c 35010000      	mov	_MachineStatus,#1
4951                     ; 338 				SetMenu = FUNCTION_0;
4953  03a0 3f00          	clr	_SetMenu
4954                     ; 339 				inSetTimer = 0;
4956  03a2 3f00          	clr	_inSetTimer
4957  03a4               L5023:
4958                     ; 343 	if(isKeyProcess)
4960                     	btst	_isKeyProcess
4961  03a9 2429          	jruge	L7223
4962                     ; 345 		isKeyProcess = 0;
4964  03ab 72110001      	bres	_isKeyProcess
4965                     ; 346 		isBeeper = 1;
4967  03af 72100000      	bset	_isBeeper
4968                     ; 347 		isUpdateDisplay = Yes;
4970  03b3 72100000      	bset	_isUpdateDisplay
4971                     ; 348 		inSetTimer = 0;
4973  03b7 3f00          	clr	_inSetTimer
4974                     ; 349 		switch(keyActiveValue)
4976  03b9 b607          	ld	a,_keyActiveValue
4978                     ; 364 			default:;
4979  03bb 4a            	dec	a
4980  03bc 2709          	jreq	L5613
4981  03be 4a            	dec	a
4982  03bf 2710          	jreq	L1713
4983  03c1 a002          	sub	a,#2
4984  03c3 2707          	jreq	L7613
4985  03c5 200d          	jra	L7223
4986  03c7               L5613:
4987                     ; 353 				keysetprocess();
4989  03c7 cd032f        	call	_keysetprocess
4991                     ; 355 			break;
4993  03ca 2008          	jra	L7223
4994  03cc               L7613:
4995                     ; 358 				keyaddprocess();
4997  03cc cd02ef        	call	_keyaddprocess
4999                     ; 359 			}break;
5001  03cf 2003          	jra	L7223
5002  03d1               L1713:
5003                     ; 362 				keysubprocess();
5005  03d1 cd030e        	call	_keysubprocess
5007                     ; 363 			}break;
5009  03d4               L3323:
5010  03d4               L7223:
5011                     ; 367 }
5014  03d4 81            	ret
5086                     	xdef	_keysetprocess
5087                     	xdef	_keysubprocess
5088                     	xdef	_keyaddprocess
5089                     	xdef	_opreat
5090                     .bit:	section	.data,bit
5091  0000               _isCanEffect:
5092  0000 00            	ds.b	1
5093                     	xdef	_isCanEffect
5094  0001               _isKeyProcess:
5095  0001 00            	ds.b	1
5096                     	xdef	_isKeyProcess
5097  0002               _isKeyLongPress:
5098  0002 00            	ds.b	1
5099                     	xdef	_isKeyLongPress
5100                     	switch	.ubsct
5101  0003               _longPressBase:
5102  0003 0000          	ds.b	2
5103                     	xdef	_longPressBase
5104  0005               _longPressCnt:
5105  0005 0000          	ds.b	2
5106                     	xdef	_longPressCnt
5107  0007               _keyActiveValue:
5108  0007 00            	ds.b	1
5109                     	xdef	_keyActiveValue
5110                     	xbit	_isBeeper
5111                     	xref.b	_CorrectTemp
5112                     	xref.b	_SetStep
5113                     	xref.b	_SetMenu
5114                     	xref.b	_MachineStatus
5115                     	xref.b	_inSetTimer
5116                     	xbit	_isUpdateDisplay
5117                     	xref.b	_Now
5118                     	xdef	__keyScanProcess
5119                     	xdef	__keyScan
5120                     	xdef	__IOInitial
5121                     	xref	__setTime
5122                     	xref.b	c_x
5142                     	xref	c_smodx
5143                     	end
