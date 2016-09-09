   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3853                     ; 27 uchar BCD2DEC(uchar BCD)
3853                     ; 28 {
3855                     	switch	.text
3856  0000               _BCD2DEC:
3858  0000 88            	push	a
3859  0001 88            	push	a
3860       00000001      OFST:	set	1
3863                     ; 29 	return (10*((BCD&0xf0)>>4) + (BCD&0x0f));
3865  0002 a40f          	and	a,#15
3866  0004 6b01          	ld	(OFST+0,sp),a
3867  0006 7b02          	ld	a,(OFST+1,sp)
3868  0008 a4f0          	and	a,#240
3869  000a 4e            	swap	a
3870  000b a40f          	and	a,#15
3871  000d 97            	ld	xl,a
3872  000e a60a          	ld	a,#10
3873  0010 42            	mul	x,a
3874  0011 9f            	ld	a,xl
3875  0012 1b01          	add	a,(OFST+0,sp)
3878  0014 85            	popw	x
3879  0015 81            	ret
3913                     ; 32 uchar DEC2BCD(uchar DEC)
3913                     ; 33 {
3914                     	switch	.text
3915  0016               _DEC2BCD:
3917  0016 88            	push	a
3918  0017 89            	pushw	x
3919       00000002      OFST:	set	2
3922                     ; 34 	return (((DEC/10)<<4)|(DEC%10));
3924  0018 5f            	clrw	x
3925  0019 97            	ld	xl,a
3926  001a a60a          	ld	a,#10
3927  001c cd0000        	call	c_smodx
3929  001f 1f01          	ldw	(OFST-1,sp),x
3930  0021 7b03          	ld	a,(OFST+1,sp)
3931  0023 5f            	clrw	x
3932  0024 97            	ld	xl,a
3933  0025 a60a          	ld	a,#10
3934  0027 cd0000        	call	c_sdivx
3936  002a 58            	sllw	x
3937  002b 58            	sllw	x
3938  002c 58            	sllw	x
3939  002d 58            	sllw	x
3940  002e 01            	rrwa	x,a
3941  002f 1a02          	or	a,(OFST+0,sp)
3942  0031 41            	exg	a,xl
3943  0032 1a01          	or	a,(OFST-1,sp)
3944  0034 41            	exg	a,xl
3947  0035 5b03          	addw	sp,#3
3948  0037 81            	ret
3984                     ; 37 void SET_SDA(uchar s)
3984                     ; 38 {
3985                     	switch	.text
3986  0038               _SET_SDA:
3990                     ; 39 	if(s == IN)
3992  0038 a101          	cp	a,#1
3993  003a 260a          	jrne	L7452
3994                     ; 41 		PB_DDR &= 0B11011111;
3996  003c 721b5007      	bres	_PB_DDR,#5
3997                     ; 42 		PB_CR1 &= 0B11011111;//SDA
3999  0040 721b5008      	bres	_PB_CR1,#5
4001  0044 2008          	jra	L1552
4002  0046               L7452:
4003                     ; 46 		PB_DDR |= 0B00100000;
4005  0046 721a5007      	bset	_PB_DDR,#5
4006                     ; 47 		PB_CR1 |= 0B00100000;//SDA
4008  004a 721a5008      	bset	_PB_CR1,#5
4009  004e               L1552:
4010                     ; 49 }
4013  004e 81            	ret
4056                     ; 51 void delay(uchar t)
4056                     ; 52 {
4057                     	switch	.text
4058  004f               _delay:
4060  004f 88            	push	a
4061  0050 88            	push	a
4062       00000001      OFST:	set	1
4065                     ; 54 	for(i = -10;i < t;i++); 
4067  0051 a6f6          	ld	a,#246
4068  0053 6b01          	ld	(OFST+0,sp),a
4070  0055 2002          	jra	L1062
4071  0057               L5752:
4075  0057 0c01          	inc	(OFST+0,sp)
4076  0059               L1062:
4079  0059 7b01          	ld	a,(OFST+0,sp)
4080  005b 1102          	cp	a,(OFST+1,sp)
4081  005d 25f8          	jrult	L5752
4082                     ; 55 }
4085  005f 85            	popw	x
4086  0060 81            	ret
4112                     ; 57 void IIC_Init(void)
4112                     ; 58 {
4113                     	switch	.text
4114  0061               _IIC_Init:
4118                     ; 59 	SET_SDA(OUT);
4120  0061 4f            	clr	a
4121  0062 add4          	call	_SET_SDA
4123                     ; 60 	SCL = 1;
4125  0064 72185005      	bset	_PB_ODR_4
4126                     ; 61 	SDA_O = 1;
4128  0068 721a5005      	bset	_PB_ODR_5
4129                     ; 62 }
4132  006c 81            	ret
4158                     ; 64 void startIIC(void)
4158                     ; 65 {
4159                     	switch	.text
4160  006d               _startIIC:
4164                     ; 66 	SDA_O = 1;
4166  006d 721a5005      	bset	_PB_ODR_5
4167                     ; 67 	SCL   = 1;
4169  0071 72185005      	bset	_PB_ODR_4
4170                     ; 68 	delay(1);
4172  0075 a601          	ld	a,#1
4173  0077 add6          	call	_delay
4175                     ; 69 	SDA_O = 0;
4177  0079 721b5005      	bres	_PB_ODR_5
4178                     ; 70 	delay(1);
4180  007d a601          	ld	a,#1
4181  007f adce          	call	_delay
4183                     ; 71 	SCL   = 0;
4185  0081 72195005      	bres	_PB_ODR_4
4186                     ; 72 }
4189  0085 81            	ret
4215                     ; 74 void stopIIC(void)
4215                     ; 75 {
4216                     	switch	.text
4217  0086               _stopIIC:
4221                     ; 76 	SCL   = 0;
4223  0086 72195005      	bres	_PB_ODR_4
4224                     ; 77 	SDA_O = 0;
4226  008a 721b5005      	bres	_PB_ODR_5
4227                     ; 78 	delay(1);
4229  008e a601          	ld	a,#1
4230  0090 adbd          	call	_delay
4232                     ; 79 	SCL   = 1;
4234  0092 72185005      	bset	_PB_ODR_4
4235                     ; 80 	delay(1);
4237  0096 a601          	ld	a,#1
4238  0098 adb5          	call	_delay
4240                     ; 81 	SDA_O = 1;
4242  009a 721a5005      	bset	_PB_ODR_5
4243                     ; 82 }
4246  009e 81            	ret
4292                     ; 84 static void write(uchar data)
4292                     ; 85 {
4293                     	switch	.text
4294  009f               L5362_write:
4296  009f 88            	push	a
4297  00a0 88            	push	a
4298       00000001      OFST:	set	1
4301                     ; 87 	SCL 	= 0;
4303  00a1 72195005      	bres	_PB_ODR_4
4304                     ; 88 	SDA_O = 0;
4306  00a5 721b5005      	bres	_PB_ODR_5
4307                     ; 89 	for(i = 0;i < 8;i++)
4309  00a9 0f01          	clr	(OFST+0,sp)
4310  00ab               L1662:
4311                     ; 91 		if(data&0x80)
4313  00ab 7b02          	ld	a,(OFST+1,sp)
4314  00ad a580          	bcp	a,#128
4315  00af 2706          	jreq	L7662
4316                     ; 93 			SDA_O = 1;
4318  00b1 721a5005      	bset	_PB_ODR_5
4320  00b5 2004          	jra	L1762
4321  00b7               L7662:
4322                     ; 97 			SDA_O = 0;
4324  00b7 721b5005      	bres	_PB_ODR_5
4325  00bb               L1762:
4326                     ; 99 		data <<= 1;
4328  00bb 0802          	sll	(OFST+1,sp)
4329                     ; 100 		delay(2);
4331  00bd a602          	ld	a,#2
4332  00bf ad8e          	call	_delay
4334                     ; 101 		SCL = 1;
4336  00c1 72185005      	bset	_PB_ODR_4
4337                     ; 102 		delay(2);
4339  00c5 a602          	ld	a,#2
4340  00c7 ad86          	call	_delay
4342                     ; 103 		SCL = 0;
4344  00c9 72195005      	bres	_PB_ODR_4
4345                     ; 89 	for(i = 0;i < 8;i++)
4347  00cd 0c01          	inc	(OFST+0,sp)
4350  00cf 7b01          	ld	a,(OFST+0,sp)
4351  00d1 a108          	cp	a,#8
4352  00d3 25d6          	jrult	L1662
4353                     ; 105 	SDA_O = 0;
4355  00d5 721b5005      	bres	_PB_ODR_5
4356                     ; 106 }
4359  00d9 85            	popw	x
4360  00da 81            	ret
4399                     ; 108 uchar receiveACK(void)
4399                     ; 109 {
4400                     	switch	.text
4401  00db               _receiveACK:
4403  00db 88            	push	a
4404       00000001      OFST:	set	1
4407                     ; 111 	SDA_O = 1;
4409  00dc 721a5005      	bset	_PB_ODR_5
4410                     ; 112 	SET_SDA(IN);
4412  00e0 a601          	ld	a,#1
4413  00e2 cd0038        	call	_SET_SDA
4415                     ; 113 	delay(2);
4417  00e5 a602          	ld	a,#2
4418  00e7 cd004f        	call	_delay
4420                     ; 114 	SCL = 1;
4422  00ea 72185005      	bset	_PB_ODR_4
4423                     ; 115 	delay(2);
4425  00ee a602          	ld	a,#2
4426  00f0 cd004f        	call	_delay
4428                     ; 116 	ack = SDA_I;
4430  00f3 4f            	clr	a
4431                     	btst	_PB_IDR_5
4432  00f9 49            	rlc	a
4433  00fa 6b01          	ld	(OFST+0,sp),a
4434                     ; 117 	SCL = 0;
4436  00fc 72195005      	bres	_PB_ODR_4
4437                     ; 118 	SDA_O = 0;
4439  0100 721b5005      	bres	_PB_ODR_5
4440                     ; 119 	SET_SDA(OUT);
4442  0104 4f            	clr	a
4443  0105 cd0038        	call	_SET_SDA
4445                     ; 120 	return ack;
4447  0108 7b01          	ld	a,(OFST+0,sp)
4450  010a 5b01          	addw	sp,#1
4451  010c 81            	ret
4499                     ; 123 static uchar read(void)
4499                     ; 124 {
4500                     	switch	.text
4501  010d               L1172_read:
4503  010d 89            	pushw	x
4504       00000002      OFST:	set	2
4507                     ; 127 	SDA_O = 1;
4509  010e 721a5005      	bset	_PB_ODR_5
4510                     ; 128 	SET_SDA(IN);
4512  0112 a601          	ld	a,#1
4513  0114 cd0038        	call	_SET_SDA
4515                     ; 129 	SCL 	= 0;
4517  0117 72195005      	bres	_PB_ODR_4
4518                     ; 130 	for(i = 0;i < 8;i++)
4520  011b 0f02          	clr	(OFST+0,sp)
4521  011d               L5372:
4522                     ; 132 		byte <<= 1;
4524  011d 0801          	sll	(OFST-1,sp)
4525                     ; 133 		if(SDA_I)
4527                     	btst	_PB_IDR_5
4528  0124 2402          	jruge	L3472
4529                     ; 135 			byte++;
4531  0126 0c01          	inc	(OFST-1,sp)
4532  0128               L3472:
4533                     ; 137 		delay(2);
4535  0128 a602          	ld	a,#2
4536  012a cd004f        	call	_delay
4538                     ; 138 		SCL = 1;
4540  012d 72185005      	bset	_PB_ODR_4
4541                     ; 139 		delay(2);
4543  0131 a602          	ld	a,#2
4544  0133 cd004f        	call	_delay
4546                     ; 140 		SCL = 0;
4548  0136 72195005      	bres	_PB_ODR_4
4549                     ; 130 	for(i = 0;i < 8;i++)
4551  013a 0c02          	inc	(OFST+0,sp)
4554  013c 7b02          	ld	a,(OFST+0,sp)
4555  013e a108          	cp	a,#8
4556  0140 25db          	jrult	L5372
4557                     ; 142 	SDA_O = 0;
4559  0142 721b5005      	bres	_PB_ODR_5
4560                     ; 143 	SET_SDA(OUT);
4562  0146 4f            	clr	a
4563  0147 cd0038        	call	_SET_SDA
4565                     ; 144 	return byte;
4567  014a 7b01          	ld	a,(OFST-1,sp)
4570  014c 85            	popw	x
4571  014d 81            	ret
4608                     ; 147 void sendACK(uchar ack)
4608                     ; 148 {
4609                     	switch	.text
4610  014e               _sendACK:
4614                     ; 149 	SCL = 0;
4616  014e 72195005      	bres	_PB_ODR_4
4617                     ; 150 	if(ack == ACK)
4619  0152 4d            	tnz	a
4620  0153 2606          	jrne	L3672
4621                     ; 152 		SDA_O = 0;
4623  0155 721b5005      	bres	_PB_ODR_5
4625  0159 2004          	jra	L5672
4626  015b               L3672:
4627                     ; 156 		SDA_O = 1;
4629  015b 721a5005      	bset	_PB_ODR_5
4630  015f               L5672:
4631                     ; 158 	delay(2);
4633  015f a602          	ld	a,#2
4634  0161 cd004f        	call	_delay
4636                     ; 159 	SCL = 1;
4638  0164 72185005      	bset	_PB_ODR_4
4639                     ; 160 	delay(2);
4641  0168 a602          	ld	a,#2
4642  016a cd004f        	call	_delay
4644                     ; 161 	SCL = 0;
4646  016d 72195005      	bres	_PB_ODR_4
4647                     ; 162 }
4650  0171 81            	ret
4706                     ; 164 static void writeByte(uchar addr,uchar data)
4706                     ; 165 {
4707                     	switch	.text
4708  0172               L7672_writeByte:
4710  0172 89            	pushw	x
4711  0173 88            	push	a
4712       00000001      OFST:	set	1
4715                     ; 167 	startIIC();
4717  0174 cd006d        	call	_startIIC
4719                     ; 168 	write(PCF8563|WRITE);
4721  0177 a6a2          	ld	a,#162
4722  0179 cd009f        	call	L5362_write
4724                     ; 169 	i = receiveACK();
4726  017c cd00db        	call	_receiveACK
4728                     ; 170 	write(addr);
4730  017f 7b02          	ld	a,(OFST+1,sp)
4731  0181 cd009f        	call	L5362_write
4733                     ; 171 	i = receiveACK();
4735  0184 cd00db        	call	_receiveACK
4737                     ; 172 	write(data);
4739  0187 7b03          	ld	a,(OFST+2,sp)
4740  0189 cd009f        	call	L5362_write
4742                     ; 173 	i = receiveACK();
4744  018c cd00db        	call	_receiveACK
4746                     ; 174 	stopIIC();
4748  018f cd0086        	call	_stopIIC
4750                     ; 175 }
4753  0192 5b03          	addw	sp,#3
4754  0194 81            	ret
4803                     ; 177 static uchar readByte(uchar addr)
4803                     ; 178 {
4804                     	switch	.text
4805  0195               L7103_readByte:
4807  0195 88            	push	a
4808  0196 88            	push	a
4809       00000001      OFST:	set	1
4812                     ; 181 	startIIC();
4814  0197 cd006d        	call	_startIIC
4816                     ; 182 	write(PCF8563|WRITE);
4818  019a a6a2          	ld	a,#162
4819  019c cd009f        	call	L5362_write
4821                     ; 183 	byte = receiveACK();
4823  019f cd00db        	call	_receiveACK
4825                     ; 184 	write(addr);
4827  01a2 7b02          	ld	a,(OFST+1,sp)
4828  01a4 cd009f        	call	L5362_write
4830                     ; 185 	byte = receiveACK();
4832  01a7 cd00db        	call	_receiveACK
4834                     ; 186 	startIIC();
4836  01aa cd006d        	call	_startIIC
4838                     ; 187 	write(PCF8563|READ);
4840  01ad a6a3          	ld	a,#163
4841  01af cd009f        	call	L5362_write
4843                     ; 188 	byte = receiveACK();
4845  01b2 cd00db        	call	_receiveACK
4847                     ; 189 	byte = read();
4849  01b5 cd010d        	call	L1172_read
4851  01b8 6b01          	ld	(OFST+0,sp),a
4852                     ; 190 	sendACK(NACK);
4854  01ba a601          	ld	a,#1
4855  01bc ad90          	call	_sendACK
4857                     ; 191 	stopIIC();
4859  01be cd0086        	call	_stopIIC
4861                     ; 192 	return byte;
4863  01c1 7b01          	ld	a,(OFST+0,sp)
4866  01c3 85            	popw	x
4867  01c4 81            	ret
4906                     ; 195 void updateRTC(void)
4906                     ; 196 {
4907                     	switch	.text
4908  01c5               _updateRTC:
4910  01c5 88            	push	a
4911       00000001      OFST:	set	1
4914                     ; 198 	startIIC();
4916  01c6 cd006d        	call	_startIIC
4918                     ; 199 	write(PCF8563|WRITE);
4920  01c9 a6a2          	ld	a,#162
4921  01cb cd009f        	call	L5362_write
4923                     ; 200 	i = receiveACK();
4925  01ce cd00db        	call	_receiveACK
4927                     ; 201 	write(0x00);
4929  01d1 4f            	clr	a
4930  01d2 cd009f        	call	L5362_write
4932                     ; 202 	i = receiveACK();
4934  01d5 cd00db        	call	_receiveACK
4936                     ; 203 	for(i = 0;i < 16;i++)
4938  01d8 0f01          	clr	(OFST+0,sp)
4939  01da               L1603:
4940                     ; 205 		write(RTC_RAM[i]);
4942  01da 7b01          	ld	a,(OFST+0,sp)
4943  01dc 5f            	clrw	x
4944  01dd 97            	ld	xl,a
4945  01de e600          	ld	a,(_RTC_RAM,x)
4946  01e0 cd009f        	call	L5362_write
4948                     ; 206 		i = receiveACK();
4950  01e3 cd00db        	call	_receiveACK
4952  01e6 6b01          	ld	(OFST+0,sp),a
4953                     ; 203 	for(i = 0;i < 16;i++)
4955  01e8 0c01          	inc	(OFST+0,sp)
4958  01ea 7b01          	ld	a,(OFST+0,sp)
4959  01ec a110          	cp	a,#16
4960  01ee 25ea          	jrult	L1603
4961                     ; 208 	stopIIC();
4963  01f0 cd0086        	call	_stopIIC
4965                     ; 209 }
4968  01f3 84            	pop	a
4969  01f4 81            	ret
5010                     ; 211 void readRTC(void)
5010                     ; 212 {
5011                     	switch	.text
5012  01f5               _readRTC:
5014  01f5 88            	push	a
5015       00000001      OFST:	set	1
5018                     ; 215 	startIIC();
5020  01f6 cd006d        	call	_startIIC
5022                     ; 216 	write(PCF8563|WRITE);
5024  01f9 a6a2          	ld	a,#162
5025  01fb cd009f        	call	L5362_write
5027                     ; 217 	i = receiveACK();
5029  01fe cd00db        	call	_receiveACK
5031                     ; 218 	write(0x02);
5033  0201 a602          	ld	a,#2
5034  0203 cd009f        	call	L5362_write
5036                     ; 219 	i = receiveACK();
5038  0206 cd00db        	call	_receiveACK
5040                     ; 220 	startIIC();
5042  0209 cd006d        	call	_startIIC
5044                     ; 221 	write(PCF8563|READ);
5046  020c a6a3          	ld	a,#163
5047  020e cd009f        	call	L5362_write
5049                     ; 222 	i = receiveACK();
5051  0211 cd00db        	call	_receiveACK
5053                     ; 223 	for(i = 2;i < 5;i++)
5055  0214 a602          	ld	a,#2
5056  0216 6b01          	ld	(OFST+0,sp),a
5057  0218               L5013:
5058                     ; 225 		RTC_RAM[i] = read();
5060  0218 7b01          	ld	a,(OFST+0,sp)
5061  021a 5f            	clrw	x
5062  021b 97            	ld	xl,a
5063  021c 89            	pushw	x
5064  021d cd010d        	call	L1172_read
5066  0220 85            	popw	x
5067  0221 e700          	ld	(_RTC_RAM,x),a
5068                     ; 226 		if(i == 4)sendACK(NACK);
5070  0223 7b01          	ld	a,(OFST+0,sp)
5071  0225 a104          	cp	a,#4
5072  0227 2607          	jrne	L3113
5075  0229 a601          	ld	a,#1
5076  022b cd014e        	call	_sendACK
5079  022e 2004          	jra	L5113
5080  0230               L3113:
5081                     ; 227 		else sendACK(ACK);
5083  0230 4f            	clr	a
5084  0231 cd014e        	call	_sendACK
5086  0234               L5113:
5087                     ; 223 	for(i = 2;i < 5;i++)
5089  0234 0c01          	inc	(OFST+0,sp)
5092  0236 7b01          	ld	a,(OFST+0,sp)
5093  0238 a105          	cp	a,#5
5094  023a 25dc          	jrult	L5013
5095                     ; 229 	stopIIC();
5097  023c cd0086        	call	_stopIIC
5099                     ; 230 }
5102  023f 84            	pop	a
5103  0240 81            	ret
5128                     ; 232 void _RTC_Init(void)
5128                     ; 233 {
5129                     	switch	.text
5130  0241               __RTC_Init:
5134                     ; 234 	IIC_Init();
5136  0241 cd0061        	call	_IIC_Init
5138                     ; 239 	writeByte(RTC_CR1,0x00);//Run RTC
5140  0244 5f            	clrw	x
5141  0245 cd0172        	call	L7672_writeByte
5143                     ; 240 }
5146  0248 81            	ret
5175                     ; 242 void _getTime(void)
5175                     ; 243 {
5176                     	switch	.text
5177  0249               __getTime:
5181                     ; 244 	if((MachineStatus == SETTING)&&(SetMenu == FUNCTION_1))return;
5183  0249 b600          	ld	a,_MachineStatus
5184  024b a102          	cp	a,#2
5185  024d 2607          	jrne	L7313
5187  024f b600          	ld	a,_SetMenu
5188  0251 a101          	cp	a,#1
5189  0253 2601          	jrne	L7313
5193  0255 81            	ret
5194  0256               L7313:
5195                     ; 245 	readRTC();
5197  0256 ad9d          	call	_readRTC
5199                     ; 246 	Now.Second = BCD2DEC(RTC_RAM[2]&0x7f);
5201  0258 b602          	ld	a,_RTC_RAM+2
5202  025a a47f          	and	a,#127
5203  025c cd0000        	call	_BCD2DEC
5205  025f b702          	ld	_Now+2,a
5206                     ; 247 	Now.Minute = BCD2DEC(RTC_RAM[3]&0x7f);
5208  0261 b603          	ld	a,_RTC_RAM+3
5209  0263 a47f          	and	a,#127
5210  0265 cd0000        	call	_BCD2DEC
5212  0268 b701          	ld	_Now+1,a
5213                     ; 248 	Now.Hour = BCD2DEC(RTC_RAM[4]&0x3f);
5215  026a b604          	ld	a,_RTC_RAM+4
5216  026c a43f          	and	a,#63
5217  026e cd0000        	call	_BCD2DEC
5219  0271 b700          	ld	_Now,a
5220                     ; 249 }
5223  0273 81            	ret
5249                     ; 251 void _setTime(void)
5249                     ; 252 {
5250                     	switch	.text
5251  0274               __setTime:
5255                     ; 253 	writeByte(RTC_HOU,DEC2BCD(Now.Hour));
5257  0274 b600          	ld	a,_Now
5258  0276 cd0016        	call	_DEC2BCD
5260  0279 97            	ld	xl,a
5261  027a a604          	ld	a,#4
5262  027c 95            	ld	xh,a
5263  027d cd0172        	call	L7672_writeByte
5265                     ; 254 	writeByte(RTC_MIN,DEC2BCD(Now.Minute));
5267  0280 b601          	ld	a,_Now+1
5268  0282 cd0016        	call	_DEC2BCD
5270  0285 97            	ld	xl,a
5271  0286 a603          	ld	a,#3
5272  0288 95            	ld	xh,a
5273  0289 cd0172        	call	L7672_writeByte
5275                     ; 255 	writeByte(RTC_SEC,DEC2BCD(Now.Second));
5277  028c b602          	ld	a,_Now+2
5278  028e cd0016        	call	_DEC2BCD
5280  0291 97            	ld	xl,a
5281  0292 a602          	ld	a,#2
5282  0294 95            	ld	xh,a
5283  0295 cd0172        	call	L7672_writeByte
5285                     ; 256 	writeByte(RTC_CR1,0x00);//Run RTC
5287  0298 5f            	clrw	x
5288  0299 cd0172        	call	L7672_writeByte
5290                     ; 257 }
5293  029c 81            	ret
5318                     	xdef	_readRTC
5319                     	xdef	_updateRTC
5320                     	xdef	_sendACK
5321                     	xdef	_receiveACK
5322                     	xdef	_stopIIC
5323                     	xdef	_startIIC
5324                     	xdef	_IIC_Init
5325                     	xdef	_delay
5326                     	xdef	_SET_SDA
5327                     	switch	.ubsct
5328  0000               _RTC_RAM:
5329  0000 000000000000  	ds.b	16
5330                     	xdef	_RTC_RAM
5331                     	xref.b	_SetMenu
5332                     	xref.b	_MachineStatus
5333                     	xref.b	_Now
5334                     	xdef	_BCD2DEC
5335                     	xdef	_DEC2BCD
5336                     	xdef	__setTime
5337                     	xdef	__getTime
5338                     	xdef	__RTC_Init
5339                     	xref.b	c_x
5359                     	xref	c_smodx
5360                     	xref	c_sdivx
5361                     	end
