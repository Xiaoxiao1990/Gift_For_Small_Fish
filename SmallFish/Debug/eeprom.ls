   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3872                     ; 9 void chardatacheck(uchar *data,uchar low,uchar high)
3872                     ; 10 {
3874                     	switch	.text
3875  0000               _chardatacheck:
3877  0000 89            	pushw	x
3878       00000000      OFST:	set	0
3881                     ; 11 	if(*data > high)*data = high;
3883  0001 f6            	ld	a,(x)
3884  0002 1106          	cp	a,(OFST+6,sp)
3885  0004 2305          	jrule	L3252
3888  0006 7b06          	ld	a,(OFST+6,sp)
3889  0008 1e01          	ldw	x,(OFST+1,sp)
3890  000a f7            	ld	(x),a
3891  000b               L3252:
3892                     ; 12 	if(*data < low)*data = low;
3894  000b 1e01          	ldw	x,(OFST+1,sp)
3895  000d f6            	ld	a,(x)
3896  000e 1105          	cp	a,(OFST+5,sp)
3897  0010 2405          	jruge	L5252
3900  0012 7b05          	ld	a,(OFST+5,sp)
3901  0014 1e01          	ldw	x,(OFST+1,sp)
3902  0016 f7            	ld	(x),a
3903  0017               L5252:
3904                     ; 13 }
3907  0017 85            	popw	x
3908  0018 81            	ret
3961                     ; 15 void intdatacheck(signed int *data,signed int low,signed int high)
3961                     ; 16 {
3962                     	switch	.text
3963  0019               _intdatacheck:
3965  0019 89            	pushw	x
3966       00000000      OFST:	set	0
3969                     ; 17 	if(*data > high)*data = high;
3971  001a 9c            	rvf
3972  001b 9093          	ldw	y,x
3973  001d 51            	exgw	x,y
3974  001e fe            	ldw	x,(x)
3975  001f 1307          	cpw	x,(OFST+7,sp)
3976  0021 51            	exgw	x,y
3977  0022 2d03          	jrsle	L5552
3980  0024 1607          	ldw	y,(OFST+7,sp)
3981  0026 ff            	ldw	(x),y
3982  0027               L5552:
3983                     ; 18 	if(*data < low)*data = low;
3985  0027 9c            	rvf
3986  0028 1e01          	ldw	x,(OFST+1,sp)
3987  002a 9093          	ldw	y,x
3988  002c 51            	exgw	x,y
3989  002d fe            	ldw	x,(x)
3990  002e 1305          	cpw	x,(OFST+5,sp)
3991  0030 51            	exgw	x,y
3992  0031 2e05          	jrsge	L7552
3995  0033 1e01          	ldw	x,(OFST+1,sp)
3996  0035 1605          	ldw	y,(OFST+5,sp)
3997  0037 ff            	ldw	(x),y
3998  0038               L7552:
3999                     ; 19 }
4002  0038 85            	popw	x
4003  0039 81            	ret
4044                     ; 21 void _EEPROM_Initial(void)
4044                     ; 22 {
4045                     	switch	.text
4046  003a               __EEPROM_Initial:
4048  003a 88            	push	a
4049       00000001      OFST:	set	1
4052                     ; 25 	temp = FLASH_ReadByte(EEPROM_CODE_ADDR);
4054  003b ae4000        	ldw	x,#16384
4055  003e 89            	pushw	x
4056  003f ae0000        	ldw	x,#0
4057  0042 89            	pushw	x
4058  0043 cd0000        	call	_FLASH_ReadByte
4060  0046 5b04          	addw	sp,#4
4061  0048 6b01          	ld	(OFST+0,sp),a
4062                     ; 26 	if (temp == EEPROM_CODE)
4064  004a 7b01          	ld	a,(OFST+0,sp)
4065  004c a1aa          	cp	a,#170
4066  004e 2639          	jrne	L3062
4067                     ; 29 		CorrectTemp = FLASH_ReadByte(DATA_ADDR)<<8;
4069  0050 ae4002        	ldw	x,#16386
4070  0053 89            	pushw	x
4071  0054 ae0000        	ldw	x,#0
4072  0057 89            	pushw	x
4073  0058 cd0000        	call	_FLASH_ReadByte
4075  005b 5b04          	addw	sp,#4
4076  005d 5f            	clrw	x
4077  005e 97            	ld	xl,a
4078  005f 4f            	clr	a
4079  0060 02            	rlwa	x,a
4080  0061 bf00          	ldw	_CorrectTemp,x
4081                     ; 30 		CorrectTemp += FLASH_ReadByte(DATA_ADDR+1);
4083  0063 ae4003        	ldw	x,#16387
4084  0066 89            	pushw	x
4085  0067 ae0000        	ldw	x,#0
4086  006a 89            	pushw	x
4087  006b cd0000        	call	_FLASH_ReadByte
4089  006e 5b04          	addw	sp,#4
4090  0070 bb01          	add	a,_CorrectTemp+1
4091  0072 b701          	ld	_CorrectTemp+1,a
4092  0074 2402          	jrnc	L21
4093  0076 3c00          	inc	_CorrectTemp
4094  0078               L21:
4095                     ; 32 		intdatacheck(&CorrectTemp,300,900);
4097  0078 ae0384        	ldw	x,#900
4098  007b 89            	pushw	x
4099  007c ae012c        	ldw	x,#300
4100  007f 89            	pushw	x
4101  0080 ae0000        	ldw	x,#_CorrectTemp
4102  0083 ad94          	call	_intdatacheck
4104  0085 5b04          	addw	sp,#4
4106  0087               L1062:
4107                     ; 50 }
4110  0087 84            	pop	a
4111  0088 81            	ret
4112  0089               L3062:
4113                     ; 38 			FLASH_Unlock(FLASH_MEMTYPE_DATA);
4115  0089 a6f7          	ld	a,#247
4116  008b cd0000        	call	_FLASH_Unlock
4118                     ; 39 		}while(FLASH_GetFlagStatus(FLASH_FLAG_DUL) == 0);
4120  008e a608          	ld	a,#8
4121  0090 cd0000        	call	_FLASH_GetFlagStatus
4123  0093 4d            	tnz	a
4124  0094 27f3          	jreq	L3062
4125                     ; 41 		FLASH_ProgramByte(EEPROM_CODE_ADDR, EEPROM_CODE);
4127  0096 4baa          	push	#170
4128  0098 ae4000        	ldw	x,#16384
4129  009b 89            	pushw	x
4130  009c ae0000        	ldw	x,#0
4131  009f 89            	pushw	x
4132  00a0 cd0000        	call	_FLASH_ProgramByte
4134  00a3 5b05          	addw	sp,#5
4135                     ; 43 		CorrectTemp = 0;
4137  00a5 5f            	clrw	x
4138  00a6 bf00          	ldw	_CorrectTemp,x
4139                     ; 44 		FLASH_ProgramByte(DATA_ADDR,CorrectTemp>>8);
4141  00a8 3b0000        	push	_CorrectTemp
4142  00ab ae4002        	ldw	x,#16386
4143  00ae 89            	pushw	x
4144  00af ae0000        	ldw	x,#0
4145  00b2 89            	pushw	x
4146  00b3 cd0000        	call	_FLASH_ProgramByte
4148  00b6 5b05          	addw	sp,#5
4149                     ; 45 		FLASH_ProgramByte(DATA_ADDR+1,CorrectTemp&0xff);
4151  00b8 b601          	ld	a,_CorrectTemp+1
4152  00ba a4ff          	and	a,#255
4153  00bc 88            	push	a
4154  00bd ae4003        	ldw	x,#16387
4155  00c0 89            	pushw	x
4156  00c1 ae0000        	ldw	x,#0
4157  00c4 89            	pushw	x
4158  00c5 cd0000        	call	_FLASH_ProgramByte
4160  00c8 5b05          	addw	sp,#5
4162  00ca               L3162:
4163                     ; 46 		while(FLASH_GetFlagStatus(FLASH_FLAG_EOP) == 0);
4165  00ca a604          	ld	a,#4
4166  00cc cd0000        	call	_FLASH_GetFlagStatus
4168  00cf 4d            	tnz	a
4169  00d0 27f8          	jreq	L3162
4170                     ; 48 		FLASH_Lock(FLASH_MEMTYPE_DATA);
4172  00d2 a6f7          	ld	a,#247
4173  00d4 cd0000        	call	_FLASH_Lock
4175  00d7 20ae          	jra	L1062
4215                     ; 52 void _EEPROM_saveSettings(void)
4215                     ; 53 {
4216                     	switch	.text
4217  00d9               __EEPROM_saveSettings:
4219  00d9 88            	push	a
4220       00000001      OFST:	set	1
4223                     ; 54 	uchar temp = 0;
4225  00da 0f01          	clr	(OFST+0,sp)
4226  00dc               L5362:
4227                     ; 57 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
4229  00dc a6f7          	ld	a,#247
4230  00de cd0000        	call	_FLASH_Unlock
4232                     ; 58 	}while(FLASH_GetFlagStatus(FLASH_FLAG_DUL) == 0);
4234  00e1 a608          	ld	a,#8
4235  00e3 cd0000        	call	_FLASH_GetFlagStatus
4237  00e6 4d            	tnz	a
4238  00e7 27f3          	jreq	L5362
4239                     ; 60 	FLASH_ProgramByte(DATA_ADDR,CorrectTemp>>8);
4241  00e9 3b0000        	push	_CorrectTemp
4242  00ec ae4002        	ldw	x,#16386
4243  00ef 89            	pushw	x
4244  00f0 ae0000        	ldw	x,#0
4245  00f3 89            	pushw	x
4246  00f4 cd0000        	call	_FLASH_ProgramByte
4248  00f7 5b05          	addw	sp,#5
4249                     ; 61 	FLASH_ProgramByte(DATA_ADDR+1,CorrectTemp&0xff);
4251  00f9 b601          	ld	a,_CorrectTemp+1
4252  00fb a4ff          	and	a,#255
4253  00fd 88            	push	a
4254  00fe ae4003        	ldw	x,#16387
4255  0101 89            	pushw	x
4256  0102 ae0000        	ldw	x,#0
4257  0105 89            	pushw	x
4258  0106 cd0000        	call	_FLASH_ProgramByte
4260  0109 5b05          	addw	sp,#5
4262  010b               L5462:
4263                     ; 63 	while(FLASH_GetFlagStatus(FLASH_FLAG_EOP) == 0);
4265  010b a604          	ld	a,#4
4266  010d cd0000        	call	_FLASH_GetFlagStatus
4268  0110 4d            	tnz	a
4269  0111 27f8          	jreq	L5462
4270                     ; 65 	FLASH_Lock(FLASH_MEMTYPE_DATA);
4272  0113 a6f7          	ld	a,#247
4273  0115 cd0000        	call	_FLASH_Lock
4275                     ; 66 }
4278  0118 84            	pop	a
4279  0119 81            	ret
4292                     	xdef	_intdatacheck
4293                     	xdef	_chardatacheck
4294                     	xref	_FLASH_GetFlagStatus
4295                     	xref	_FLASH_ReadByte
4296                     	xref	_FLASH_ProgramByte
4297                     	xref	_FLASH_Lock
4298                     	xref	_FLASH_Unlock
4299                     	xref.b	_CorrectTemp
4300                     	xdef	__EEPROM_saveSettings
4301                     	xdef	__EEPROM_Initial
4320                     	end
