   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  75                     ; 81 void FLASH_Unlock(FLASH_MemType_TypeDef FLASH_MemType)
  75                     ; 82 {
  77                     	switch	.text
  78  0000               _FLASH_Unlock:
  82                     ; 84     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
  84                     ; 87     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
  86  0000 a1fd          	cp	a,#253
  87  0002 260a          	jrne	L73
  88                     ; 89         FLASH->PUKR = FLASH_RASS_KEY1;
  90  0004 35565062      	mov	20578,#86
  91                     ; 90         FLASH->PUKR = FLASH_RASS_KEY2;
  93  0008 35ae5062      	mov	20578,#174
  95  000c 2008          	jra	L14
  96  000e               L73:
  97                     ; 95         FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
  99  000e 35ae5064      	mov	20580,#174
 100                     ; 96         FLASH->DUKR = FLASH_RASS_KEY1;
 102  0012 35565064      	mov	20580,#86
 103  0016               L14:
 104                     ; 98 }
 107  0016 81            	ret
 142                     ; 106 void FLASH_Lock(FLASH_MemType_TypeDef FLASH_MemType)
 142                     ; 107 {
 143                     	switch	.text
 144  0017               _FLASH_Lock:
 148                     ; 109     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
 150                     ; 112   FLASH->IAPSR &= (uint8_t)FLASH_MemType;
 152  0017 c4505f        	and	a,20575
 153  001a c7505f        	ld	20575,a
 154                     ; 113 }
 157  001d 81            	ret
 180                     ; 120 void FLASH_DeInit(void)
 180                     ; 121 {
 181                     	switch	.text
 182  001e               _FLASH_DeInit:
 186                     ; 122     FLASH->CR1 = FLASH_CR1_RESET_VALUE;
 188  001e 725f505a      	clr	20570
 189                     ; 123     FLASH->CR2 = FLASH_CR2_RESET_VALUE;
 191  0022 725f505b      	clr	20571
 192                     ; 124     FLASH->NCR2 = FLASH_NCR2_RESET_VALUE;
 194  0026 35ff505c      	mov	20572,#255
 195                     ; 125     FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_DUL);
 197  002a 7217505f      	bres	20575,#3
 198                     ; 126     FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_PUL);
 200  002e 7213505f      	bres	20575,#1
 201                     ; 127     (void) FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
 203  0032 c6505f        	ld	a,20575
 204                     ; 128 }
 207  0035 81            	ret
 262                     ; 136 void FLASH_ITConfig(FunctionalState NewState)
 262                     ; 137 {
 263                     	switch	.text
 264  0036               _FLASH_ITConfig:
 268                     ; 139   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 270                     ; 141     if (NewState != DISABLE)
 272  0036 4d            	tnz	a
 273  0037 2706          	jreq	L711
 274                     ; 143         FLASH->CR1 |= FLASH_CR1_IE; /* Enables the interrupt sources */
 276  0039 7212505a      	bset	20570,#1
 278  003d 2004          	jra	L121
 279  003f               L711:
 280                     ; 147         FLASH->CR1 &= (uint8_t)(~FLASH_CR1_IE); /* Disables the interrupt sources */
 282  003f 7213505a      	bres	20570,#1
 283  0043               L121:
 284                     ; 149 }
 287  0043 81            	ret
 321                     ; 158 void FLASH_EraseByte(uint32_t Address)
 321                     ; 159 {
 322                     	switch	.text
 323  0044               _FLASH_EraseByte:
 325       00000000      OFST:	set	0
 328                     ; 161     assert_param(IS_FLASH_ADDRESS_OK(Address));
 330                     ; 164    *(PointerAttr uint8_t*) (uint16_t)Address = FLASH_CLEAR_BYTE; 
 332  0044 1e05          	ldw	x,(OFST+5,sp)
 333  0046 7f            	clr	(x)
 334                     ; 166 }
 337  0047 81            	ret
 380                     ; 176 void FLASH_ProgramByte(uint32_t Address, uint8_t Data)
 380                     ; 177 {
 381                     	switch	.text
 382  0048               _FLASH_ProgramByte:
 384       00000000      OFST:	set	0
 387                     ; 179     assert_param(IS_FLASH_ADDRESS_OK(Address));
 389                     ; 180     *(PointerAttr uint8_t*) (uint16_t)Address = Data;
 391  0048 7b07          	ld	a,(OFST+7,sp)
 392  004a 1e05          	ldw	x,(OFST+5,sp)
 393  004c f7            	ld	(x),a
 394                     ; 181 }
 397  004d 81            	ret
 431                     ; 190 uint8_t FLASH_ReadByte(uint32_t Address)
 431                     ; 191 {
 432                     	switch	.text
 433  004e               _FLASH_ReadByte:
 435       00000000      OFST:	set	0
 438                     ; 193     assert_param(IS_FLASH_ADDRESS_OK(Address));
 440                     ; 196     return(*(PointerAttr uint8_t *) (uint16_t)Address); 
 442  004e 1e05          	ldw	x,(OFST+5,sp)
 443  0050 f6            	ld	a,(x)
 446  0051 81            	ret
 489                     ; 207 void FLASH_ProgramWord(uint32_t Address, uint32_t Data)
 489                     ; 208 {
 490                     	switch	.text
 491  0052               _FLASH_ProgramWord:
 493       00000000      OFST:	set	0
 496                     ; 210     assert_param(IS_FLASH_ADDRESS_OK(Address));
 498                     ; 213     FLASH->CR2 |= FLASH_CR2_WPRG;
 500  0052 721c505b      	bset	20571,#6
 501                     ; 214     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
 503  0056 721d505c      	bres	20572,#6
 504                     ; 217     *((PointerAttr uint8_t*)(uint16_t)Address)       = *((uint8_t*)(&Data));
 506  005a 7b07          	ld	a,(OFST+7,sp)
 507  005c 1e05          	ldw	x,(OFST+5,sp)
 508  005e f7            	ld	(x),a
 509                     ; 219     *(((PointerAttr uint8_t*)(uint16_t)Address) + 1) = *((uint8_t*)(&Data)+1); 
 511  005f 7b08          	ld	a,(OFST+8,sp)
 512  0061 1e05          	ldw	x,(OFST+5,sp)
 513  0063 e701          	ld	(1,x),a
 514                     ; 221     *(((PointerAttr uint8_t*)(uint16_t)Address) + 2) = *((uint8_t*)(&Data)+2); 
 516  0065 7b09          	ld	a,(OFST+9,sp)
 517  0067 1e05          	ldw	x,(OFST+5,sp)
 518  0069 e702          	ld	(2,x),a
 519                     ; 223     *(((PointerAttr uint8_t*)(uint16_t)Address) + 3) = *((uint8_t*)(&Data)+3); 
 521  006b 7b0a          	ld	a,(OFST+10,sp)
 522  006d 1e05          	ldw	x,(OFST+5,sp)
 523  006f e703          	ld	(3,x),a
 524                     ; 224 }
 527  0071 81            	ret
 572                     ; 232 void FLASH_ProgramOptionByte(uint16_t Address, uint8_t Data)
 572                     ; 233 {
 573                     	switch	.text
 574  0072               _FLASH_ProgramOptionByte:
 576  0072 89            	pushw	x
 577       00000000      OFST:	set	0
 580                     ; 235     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 582                     ; 238     FLASH->CR2 |= FLASH_CR2_OPT;
 584  0073 721e505b      	bset	20571,#7
 585                     ; 239     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 587  0077 721f505c      	bres	20572,#7
 588                     ; 242     if (Address == 0x4800)
 590  007b a34800        	cpw	x,#18432
 591  007e 2607          	jrne	L542
 592                     ; 245        *((NEAR uint8_t*)Address) = Data;
 594  0080 7b05          	ld	a,(OFST+5,sp)
 595  0082 1e01          	ldw	x,(OFST+1,sp)
 596  0084 f7            	ld	(x),a
 598  0085 200c          	jra	L742
 599  0087               L542:
 600                     ; 250        *((NEAR uint8_t*)Address) = Data;
 602  0087 7b05          	ld	a,(OFST+5,sp)
 603  0089 1e01          	ldw	x,(OFST+1,sp)
 604  008b f7            	ld	(x),a
 605                     ; 251        *((NEAR uint8_t*)((uint16_t)(Address + 1))) = (uint8_t)(~Data);
 607  008c 7b05          	ld	a,(OFST+5,sp)
 608  008e 43            	cpl	a
 609  008f 1e01          	ldw	x,(OFST+1,sp)
 610  0091 e701          	ld	(1,x),a
 611  0093               L742:
 612                     ; 253     FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 614  0093 a6fd          	ld	a,#253
 615  0095 cd017d        	call	_FLASH_WaitForLastOperation
 617                     ; 256     FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 619  0098 721f505b      	bres	20571,#7
 620                     ; 257     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 622  009c 721e505c      	bset	20572,#7
 623                     ; 258 }
 626  00a0 85            	popw	x
 627  00a1 81            	ret
 663                     ; 265 void FLASH_EraseOptionByte(uint16_t Address)
 663                     ; 266 {
 664                     	switch	.text
 665  00a2               _FLASH_EraseOptionByte:
 667  00a2 89            	pushw	x
 668       00000000      OFST:	set	0
 671                     ; 268     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 673                     ; 271     FLASH->CR2 |= FLASH_CR2_OPT;
 675  00a3 721e505b      	bset	20571,#7
 676                     ; 272     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 678  00a7 721f505c      	bres	20572,#7
 679                     ; 275      if (Address == 0x4800)
 681  00ab a34800        	cpw	x,#18432
 682  00ae 2603          	jrne	L762
 683                     ; 278        *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 685  00b0 7f            	clr	(x)
 687  00b1 2009          	jra	L172
 688  00b3               L762:
 689                     ; 283        *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 691  00b3 1e01          	ldw	x,(OFST+1,sp)
 692  00b5 7f            	clr	(x)
 693                     ; 284        *((NEAR uint8_t*)((uint16_t)(Address + (uint16_t)1 ))) = FLASH_SET_BYTE;
 695  00b6 1e01          	ldw	x,(OFST+1,sp)
 696  00b8 a6ff          	ld	a,#255
 697  00ba e701          	ld	(1,x),a
 698  00bc               L172:
 699                     ; 286     FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 701  00bc a6fd          	ld	a,#253
 702  00be cd017d        	call	_FLASH_WaitForLastOperation
 704                     ; 289     FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 706  00c1 721f505b      	bres	20571,#7
 707                     ; 290     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 709  00c5 721e505c      	bset	20572,#7
 710                     ; 291 }
 713  00c9 85            	popw	x
 714  00ca 81            	ret
 777                     ; 297 uint16_t FLASH_ReadOptionByte(uint16_t Address)
 777                     ; 298 {
 778                     	switch	.text
 779  00cb               _FLASH_ReadOptionByte:
 781  00cb 5204          	subw	sp,#4
 782       00000004      OFST:	set	4
 785                     ; 299     uint8_t value_optbyte, value_optbyte_complement = 0;
 787                     ; 300     uint16_t res_value = 0;
 789                     ; 303     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 791                     ; 306     value_optbyte = *((NEAR uint8_t*)Address); /* Read option byte */
 793  00cd f6            	ld	a,(x)
 794  00ce 6b02          	ld	(OFST-2,sp),a
 795                     ; 307     value_optbyte_complement = *(((NEAR uint8_t*)Address) + 1); /* Read option byte complement */
 797  00d0 e601          	ld	a,(1,x)
 798  00d2 6b01          	ld	(OFST-3,sp),a
 799                     ; 310     if (Address == 0x4800)	 
 801  00d4 a34800        	cpw	x,#18432
 802  00d7 2608          	jrne	L523
 803                     ; 312         res_value =	 value_optbyte;
 805  00d9 7b02          	ld	a,(OFST-2,sp)
 806  00db 5f            	clrw	x
 807  00dc 97            	ld	xl,a
 808  00dd 1f03          	ldw	(OFST-1,sp),x
 810  00df 2023          	jra	L723
 811  00e1               L523:
 812                     ; 316         if (value_optbyte == (uint8_t)(~value_optbyte_complement))
 814  00e1 7b01          	ld	a,(OFST-3,sp)
 815  00e3 43            	cpl	a
 816  00e4 1102          	cp	a,(OFST-2,sp)
 817  00e6 2617          	jrne	L133
 818                     ; 318             res_value = (uint16_t)((uint16_t)value_optbyte << 8);
 820  00e8 7b02          	ld	a,(OFST-2,sp)
 821  00ea 5f            	clrw	x
 822  00eb 97            	ld	xl,a
 823  00ec 4f            	clr	a
 824  00ed 02            	rlwa	x,a
 825  00ee 1f03          	ldw	(OFST-1,sp),x
 826                     ; 319             res_value = res_value | (uint16_t)value_optbyte_complement;
 828  00f0 7b01          	ld	a,(OFST-3,sp)
 829  00f2 5f            	clrw	x
 830  00f3 97            	ld	xl,a
 831  00f4 01            	rrwa	x,a
 832  00f5 1a04          	or	a,(OFST+0,sp)
 833  00f7 01            	rrwa	x,a
 834  00f8 1a03          	or	a,(OFST-1,sp)
 835  00fa 01            	rrwa	x,a
 836  00fb 1f03          	ldw	(OFST-1,sp),x
 838  00fd 2005          	jra	L723
 839  00ff               L133:
 840                     ; 323             res_value = FLASH_OPTIONBYTE_ERROR;
 842  00ff ae5555        	ldw	x,#21845
 843  0102 1f03          	ldw	(OFST-1,sp),x
 844  0104               L723:
 845                     ; 326     return(res_value);
 847  0104 1e03          	ldw	x,(OFST-1,sp)
 850  0106 5b04          	addw	sp,#4
 851  0108 81            	ret
 925                     ; 335 void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef FLASH_LPMode)
 925                     ; 336 {
 926                     	switch	.text
 927  0109               _FLASH_SetLowPowerMode:
 929  0109 88            	push	a
 930       00000000      OFST:	set	0
 933                     ; 338     assert_param(IS_FLASH_LOW_POWER_MODE_OK(FLASH_LPMode));
 935                     ; 341     FLASH->CR1 &= (uint8_t)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); 
 937  010a c6505a        	ld	a,20570
 938  010d a4f3          	and	a,#243
 939  010f c7505a        	ld	20570,a
 940                     ; 344     FLASH->CR1 |= (uint8_t)FLASH_LPMode; 
 942  0112 c6505a        	ld	a,20570
 943  0115 1a01          	or	a,(OFST+1,sp)
 944  0117 c7505a        	ld	20570,a
 945                     ; 345 }
 948  011a 84            	pop	a
 949  011b 81            	ret
1007                     ; 353 void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef FLASH_ProgTime)
1007                     ; 354 {
1008                     	switch	.text
1009  011c               _FLASH_SetProgrammingTime:
1013                     ; 356     assert_param(IS_FLASH_PROGRAM_TIME_OK(FLASH_ProgTime));
1015                     ; 358     FLASH->CR1 &= (uint8_t)(~FLASH_CR1_FIX);
1017  011c 7211505a      	bres	20570,#0
1018                     ; 359     FLASH->CR1 |= (uint8_t)FLASH_ProgTime;
1020  0120 ca505a        	or	a,20570
1021  0123 c7505a        	ld	20570,a
1022                     ; 360 }
1025  0126 81            	ret
1050                     ; 367 FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void)
1050                     ; 368 {
1051                     	switch	.text
1052  0127               _FLASH_GetLowPowerMode:
1056                     ; 369     return((FLASH_LPMode_TypeDef)(FLASH->CR1 & (uint8_t)(FLASH_CR1_HALT | FLASH_CR1_AHALT)));
1058  0127 c6505a        	ld	a,20570
1059  012a a40c          	and	a,#12
1062  012c 81            	ret
1087                     ; 377 FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
1087                     ; 378 {
1088                     	switch	.text
1089  012d               _FLASH_GetProgrammingTime:
1093                     ; 379     return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
1095  012d c6505a        	ld	a,20570
1096  0130 a401          	and	a,#1
1099  0132 81            	ret
1133                     ; 387 uint32_t FLASH_GetBootSize(void)
1133                     ; 388 {
1134                     	switch	.text
1135  0133               _FLASH_GetBootSize:
1137  0133 5204          	subw	sp,#4
1138       00000004      OFST:	set	4
1141                     ; 389     uint32_t temp = 0;
1143                     ; 392     temp = (uint32_t)((uint32_t)FLASH->FPR * (uint32_t)512);
1145  0135 c6505d        	ld	a,20573
1146  0138 5f            	clrw	x
1147  0139 97            	ld	xl,a
1148  013a 90ae0200      	ldw	y,#512
1149  013e cd0000        	call	c_umul
1151  0141 96            	ldw	x,sp
1152  0142 1c0001        	addw	x,#OFST-3
1153  0145 cd0000        	call	c_rtol
1155                     ; 395     if (FLASH->FPR == 0xFF)
1157  0148 c6505d        	ld	a,20573
1158  014b a1ff          	cp	a,#255
1159  014d 2611          	jrne	L354
1160                     ; 397         temp += 512;
1162  014f ae0200        	ldw	x,#512
1163  0152 bf02          	ldw	c_lreg+2,x
1164  0154 ae0000        	ldw	x,#0
1165  0157 bf00          	ldw	c_lreg,x
1166  0159 96            	ldw	x,sp
1167  015a 1c0001        	addw	x,#OFST-3
1168  015d cd0000        	call	c_lgadd
1170  0160               L354:
1171                     ; 401     return(temp);
1173  0160 96            	ldw	x,sp
1174  0161 1c0001        	addw	x,#OFST-3
1175  0164 cd0000        	call	c_ltor
1179  0167 5b04          	addw	sp,#4
1180  0169 81            	ret
1282                     ; 412 FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG)
1282                     ; 413 {
1283                     	switch	.text
1284  016a               _FLASH_GetFlagStatus:
1286  016a 88            	push	a
1287       00000001      OFST:	set	1
1290                     ; 414     FlagStatus status = RESET;
1292                     ; 416     assert_param(IS_FLASH_FLAGS_OK(FLASH_FLAG));
1294                     ; 419     if ((FLASH->IAPSR & (uint8_t)FLASH_FLAG) != (uint8_t)RESET)
1296  016b c4505f        	and	a,20575
1297  016e 2706          	jreq	L325
1298                     ; 421         status = SET; /* FLASH_FLAG is set */
1300  0170 a601          	ld	a,#1
1301  0172 6b01          	ld	(OFST+0,sp),a
1303  0174 2002          	jra	L525
1304  0176               L325:
1305                     ; 425         status = RESET; /* FLASH_FLAG is reset*/
1307  0176 0f01          	clr	(OFST+0,sp)
1308  0178               L525:
1309                     ; 429     return status;
1311  0178 7b01          	ld	a,(OFST+0,sp)
1314  017a 5b01          	addw	sp,#1
1315  017c 81            	ret
1400                     ; 531 IN_RAM(FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef FLASH_MemType)) 
1400                     ; 532 {
1401                     	switch	.text
1402  017d               _FLASH_WaitForLastOperation:
1404  017d 5205          	subw	sp,#5
1405       00000005      OFST:	set	5
1408                     ; 533     uint8_t flagstatus = 0x00;
1410  017f 0f05          	clr	(OFST+0,sp)
1411                     ; 534     uint32_t timeout = OPERATION_TIMEOUT;
1413  0181 aeffff        	ldw	x,#65535
1414  0184 1f03          	ldw	(OFST-2,sp),x
1415  0186 ae000f        	ldw	x,#15
1416  0189 1f01          	ldw	(OFST-4,sp),x
1418  018b 2010          	jra	L375
1419  018d               L765:
1420                     ; 560         flagstatus = (uint8_t)(FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS));
1422  018d c6505f        	ld	a,20575
1423  0190 a405          	and	a,#5
1424  0192 6b05          	ld	(OFST+0,sp),a
1425                     ; 561         timeout--;
1427  0194 96            	ldw	x,sp
1428  0195 1c0001        	addw	x,#OFST-4
1429  0198 a601          	ld	a,#1
1430  019a cd0000        	call	c_lgsbc
1432  019d               L375:
1433                     ; 558     while ((flagstatus == 0x00) && (timeout != 0x00))
1435  019d 0d05          	tnz	(OFST+0,sp)
1436  019f 2609          	jrne	L775
1438  01a1 96            	ldw	x,sp
1439  01a2 1c0001        	addw	x,#OFST-4
1440  01a5 cd0000        	call	c_lzmp
1442  01a8 26e3          	jrne	L765
1443  01aa               L775:
1444                     ; 566     if (timeout == 0x00 )
1446  01aa 96            	ldw	x,sp
1447  01ab 1c0001        	addw	x,#OFST-4
1448  01ae cd0000        	call	c_lzmp
1450  01b1 2604          	jrne	L106
1451                     ; 568         flagstatus = FLASH_STATUS_TIMEOUT;
1453  01b3 a602          	ld	a,#2
1454  01b5 6b05          	ld	(OFST+0,sp),a
1455  01b7               L106:
1456                     ; 571     return((FLASH_Status_TypeDef)flagstatus);
1458  01b7 7b05          	ld	a,(OFST+0,sp)
1461  01b9 5b05          	addw	sp,#5
1462  01bb 81            	ret
1525                     ; 581 IN_RAM(void FLASH_EraseBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType))
1525                     ; 582 {
1526                     	switch	.text
1527  01bc               _FLASH_EraseBlock:
1529  01bc 89            	pushw	x
1530  01bd 5206          	subw	sp,#6
1531       00000006      OFST:	set	6
1534                     ; 583   uint32_t startaddress = 0;
1536                     ; 593   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1538                     ; 594   if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1540  01bf 7b0b          	ld	a,(OFST+5,sp)
1541  01c1 a1fd          	cp	a,#253
1542  01c3 260c          	jrne	L536
1543                     ; 596       assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1545                     ; 597       startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1547  01c5 ae8000        	ldw	x,#32768
1548  01c8 1f05          	ldw	(OFST-1,sp),x
1549  01ca ae0000        	ldw	x,#0
1550  01cd 1f03          	ldw	(OFST-3,sp),x
1552  01cf 200a          	jra	L736
1553  01d1               L536:
1554                     ; 601       assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1556                     ; 602       startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1558  01d1 ae4000        	ldw	x,#16384
1559  01d4 1f05          	ldw	(OFST-1,sp),x
1560  01d6 ae0000        	ldw	x,#0
1561  01d9 1f03          	ldw	(OFST-3,sp),x
1562  01db               L736:
1563                     ; 610     pwFlash = (PointerAttr uint32_t *)(uint16_t)(startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE));
1565  01db 1e07          	ldw	x,(OFST+1,sp)
1566  01dd a640          	ld	a,#64
1567  01df cd0000        	call	c_cmulx
1569  01e2 96            	ldw	x,sp
1570  01e3 1c0003        	addw	x,#OFST-3
1571  01e6 cd0000        	call	c_ladd
1573  01e9 be02          	ldw	x,c_lreg+2
1574  01eb 1f01          	ldw	(OFST-5,sp),x
1575                     ; 614     FLASH->CR2 |= FLASH_CR2_ERASE;
1577  01ed 721a505b      	bset	20571,#5
1578                     ; 615     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NERASE);
1580  01f1 721b505c      	bres	20572,#5
1581                     ; 619     *pwFlash = (uint32_t)0;
1583  01f5 1e01          	ldw	x,(OFST-5,sp)
1584  01f7 a600          	ld	a,#0
1585  01f9 e703          	ld	(3,x),a
1586  01fb a600          	ld	a,#0
1587  01fd e702          	ld	(2,x),a
1588  01ff a600          	ld	a,#0
1589  0201 e701          	ld	(1,x),a
1590  0203 a600          	ld	a,#0
1591  0205 f7            	ld	(x),a
1592                     ; 627 }
1595  0206 5b08          	addw	sp,#8
1596  0208 81            	ret
1700                     ; 638 IN_RAM(void FLASH_ProgramBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType, 
1700                     ; 639                         FLASH_ProgramMode_TypeDef FLASH_ProgMode, uint8_t *Buffer))
1700                     ; 640 {
1701                     	switch	.text
1702  0209               _FLASH_ProgramBlock:
1704  0209 89            	pushw	x
1705  020a 5206          	subw	sp,#6
1706       00000006      OFST:	set	6
1709                     ; 641     uint16_t Count = 0;
1711                     ; 642     uint32_t startaddress = 0;
1713                     ; 645     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1715                     ; 646     assert_param(IS_FLASH_PROGRAM_MODE_OK(FLASH_ProgMode));
1717                     ; 647     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1719  020c 7b0b          	ld	a,(OFST+5,sp)
1720  020e a1fd          	cp	a,#253
1721  0210 260c          	jrne	L317
1722                     ; 649         assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1724                     ; 650         startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1726  0212 ae8000        	ldw	x,#32768
1727  0215 1f03          	ldw	(OFST-3,sp),x
1728  0217 ae0000        	ldw	x,#0
1729  021a 1f01          	ldw	(OFST-5,sp),x
1731  021c 200a          	jra	L517
1732  021e               L317:
1733                     ; 654         assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1735                     ; 655         startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1737  021e ae4000        	ldw	x,#16384
1738  0221 1f03          	ldw	(OFST-3,sp),x
1739  0223 ae0000        	ldw	x,#0
1740  0226 1f01          	ldw	(OFST-5,sp),x
1741  0228               L517:
1742                     ; 659     startaddress = startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE);
1744  0228 1e07          	ldw	x,(OFST+1,sp)
1745  022a a640          	ld	a,#64
1746  022c cd0000        	call	c_cmulx
1748  022f 96            	ldw	x,sp
1749  0230 1c0001        	addw	x,#OFST-5
1750  0233 cd0000        	call	c_lgadd
1752                     ; 662     if (FLASH_ProgMode == FLASH_PROGRAMMODE_STANDARD)
1754  0236 0d0c          	tnz	(OFST+6,sp)
1755  0238 260a          	jrne	L717
1756                     ; 665         FLASH->CR2 |= FLASH_CR2_PRG;
1758  023a 7210505b      	bset	20571,#0
1759                     ; 666         FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NPRG);
1761  023e 7211505c      	bres	20572,#0
1763  0242 2008          	jra	L127
1764  0244               L717:
1765                     ; 671         FLASH->CR2 |= FLASH_CR2_FPRG;
1767  0244 7218505b      	bset	20571,#4
1768                     ; 672         FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NFPRG);
1770  0248 7219505c      	bres	20572,#4
1771  024c               L127:
1772                     ; 676     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1774  024c 5f            	clrw	x
1775  024d 1f05          	ldw	(OFST-1,sp),x
1776  024f               L327:
1777                     ; 682   *((PointerAttr uint8_t*) (uint16_t)startaddress + Count) = ((uint8_t)(Buffer[Count]));
1779  024f 1e0d          	ldw	x,(OFST+7,sp)
1780  0251 72fb05        	addw	x,(OFST-1,sp)
1781  0254 f6            	ld	a,(x)
1782  0255 1e03          	ldw	x,(OFST-3,sp)
1783  0257 72fb05        	addw	x,(OFST-1,sp)
1784  025a f7            	ld	(x),a
1785                     ; 676     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1787  025b 1e05          	ldw	x,(OFST-1,sp)
1788  025d 1c0001        	addw	x,#1
1789  0260 1f05          	ldw	(OFST-1,sp),x
1792  0262 1e05          	ldw	x,(OFST-1,sp)
1793  0264 a30040        	cpw	x,#64
1794  0267 25e6          	jrult	L327
1795                     ; 685 }
1798  0269 5b08          	addw	sp,#8
1799  026b 81            	ret
1812                     	xdef	_FLASH_WaitForLastOperation
1813                     	xdef	_FLASH_ProgramBlock
1814                     	xdef	_FLASH_EraseBlock
1815                     	xdef	_FLASH_GetFlagStatus
1816                     	xdef	_FLASH_GetBootSize
1817                     	xdef	_FLASH_GetProgrammingTime
1818                     	xdef	_FLASH_GetLowPowerMode
1819                     	xdef	_FLASH_SetProgrammingTime
1820                     	xdef	_FLASH_SetLowPowerMode
1821                     	xdef	_FLASH_EraseOptionByte
1822                     	xdef	_FLASH_ProgramOptionByte
1823                     	xdef	_FLASH_ReadOptionByte
1824                     	xdef	_FLASH_ProgramWord
1825                     	xdef	_FLASH_ReadByte
1826                     	xdef	_FLASH_ProgramByte
1827                     	xdef	_FLASH_EraseByte
1828                     	xdef	_FLASH_ITConfig
1829                     	xdef	_FLASH_DeInit
1830                     	xdef	_FLASH_Lock
1831                     	xdef	_FLASH_Unlock
1832                     	xref.b	c_lreg
1833                     	xref.b	c_x
1834                     	xref.b	c_y
1853                     	xref	c_ladd
1854                     	xref	c_cmulx
1855                     	xref	c_lzmp
1856                     	xref	c_lgsbc
1857                     	xref	c_ltor
1858                     	xref	c_lgadd
1859                     	xref	c_rtol
1860                     	xref	c_umul
1861                     	end
