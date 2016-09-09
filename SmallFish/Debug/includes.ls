   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
3788                     	bsct
3789  0000               _LightnessMode:
3790  0000 01            	dc.b	1
4096                     	switch	.ubsct
4097  0000               _RandSeed:
4098  0000 0000          	ds.b	2
4099                     	xdef	_RandSeed
4100  0002               _testValue:
4101  0002 0000          	ds.b	2
4102                     	xdef	_testValue
4103                     	xdef	_LightnessMode
4104  0004               _LittleFishWakeUp:
4105  0004 00            	ds.b	1
4106                     	xdef	_LittleFishWakeUp
4107                     .bit:	section	.data,bit
4108  0000               _isPIR:
4109  0000 00            	ds.b	1
4110                     	xdef	_isPIR
4111                     	switch	.ubsct
4112  0005               _ErrorCode:
4113  0005 00            	ds.b	1
4114                     	xdef	_ErrorCode
4115                     	switch	.bit
4116  0001               _isBeeper:
4117  0001 00            	ds.b	1
4118                     	xdef	_isBeeper
4119  0002               _isCanUpdateGrayScale:
4120  0002 00            	ds.b	1
4121                     	xdef	_isCanUpdateGrayScale
4122                     	switch	.ubsct
4123  0006               _GrayScale:
4124  0006 0000          	ds.b	2
4125                     	xdef	_GrayScale
4126  0008               _LightValue:
4127  0008 0000          	ds.b	2
4128                     	xdef	_LightValue
4129  000a               _CurrentTemp:
4130  000a 0000          	ds.b	2
4131                     	xdef	_CurrentTemp
4132  000c               _CorrectTemp:
4133  000c 0000          	ds.b	2
4134                     	xdef	_CorrectTemp
4135                     	switch	.bit
4136  0003               _isInSetting:
4137  0003 00            	ds.b	1
4138                     	xdef	_isInSetting
4139  0004               _isTimeProcess:
4140  0004 00            	ds.b	1
4141                     	xdef	_isTimeProcess
4142                     	switch	.ubsct
4143  000e               _SetStep:
4144  000e 00            	ds.b	1
4145                     	xdef	_SetStep
4146  000f               _SetMenu:
4147  000f 00            	ds.b	1
4148                     	xdef	_SetMenu
4149  0010               _MachineStatus:
4150  0010 00            	ds.b	1
4151                     	xdef	_MachineStatus
4152  0011               _inSetTimer:
4153  0011 00            	ds.b	1
4154                     	xdef	_inSetTimer
4155                     	switch	.bit
4156  0005               _isFlash2Hz:
4157  0005 00            	ds.b	1
4158                     	xdef	_isFlash2Hz
4159  0006               _isFlash1Hz:
4160  0006 00            	ds.b	1
4161                     	xdef	_isFlash1Hz
4162  0007               _is50ms:
4163  0007 00            	ds.b	1
4164                     	xdef	_is50ms
4165  0008               _is500ms:
4166  0008 00            	ds.b	1
4167                     	xdef	_is500ms
4168  0009               _isOneSecond:
4169  0009 00            	ds.b	1
4170                     	xdef	_isOneSecond
4171  000a               _isUpdateDisplay:
4172  000a 00            	ds.b	1
4173                     	xdef	_isUpdateDisplay
4174                     	switch	.ubsct
4175  0012               _DisplayMode:
4176  0012 00            	ds.b	1
4177                     	xdef	_DisplayMode
4178  0013               _LED_Buf:
4179  0013 000000000000  	ds.b	8
4180                     	xdef	_LED_Buf
4181  001b               _Now:
4182  001b 000000        	ds.b	3
4183                     	xdef	_Now
4203                     	end
