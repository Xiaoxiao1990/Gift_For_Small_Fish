#ifndef _INCLUDES_H_
#define _INCLUDES_H_

#include "stm8s003F3.h"					/*Register map*/
#include "stm8s_bitsdefine.h"
#include "config.h"
#include "display.h"
#include "time.h"
#include "rtc.h"
#include "keyscan.h"
#include "adc.h"
#include "eeprom.h"
#include "output.h"

#define Yes 1
#define No  0

#define Set 	1
#define Reset 0

#define Clear Reset

/*MachineStatus define*/
#define IDEL								0
#define SELECT							1
#define SETTING							2
/*Set Menu*/
#define FUNCTION_0					0
#define FUNCTION_1					1
#define FUNCTION_2					2
#define FUNCTION_3					3
#define FUNCTION_4					4
#define FUNCTION_5					5
#define FUNCTION_6					6
/*SetMode define*/
#define SET_TIME_HH					0
#define SET_TIME_HL					1
#define SET_TIME_MH					2
#define SET_TIME_ML					3
#define SET_TIME_SH					4
#define SET_TIME_SL					5

typedef unsigned char uchar;
typedef unsigned int uint;

//Recoder
#define REC			PA_ODR_1
#define PLAYE		PA_ODR_2

typedef struct{
	uchar Hour;
	uchar Minute;
	uchar Second;
}Time_TypeDef;

extern Time_TypeDef Now;
extern uchar LED_Buf[8];
extern uchar DisplayMode;
extern _Bool isUpdateDisplay;
extern _Bool isOneSecond;
extern _Bool is500ms;
extern _Bool is50ms;//for display
extern _Bool isFlash1Hz;
extern _Bool isFlash2Hz;
extern uchar inSetTimer;
extern uchar MachineStatus;
extern uchar SetMenu;
extern uchar SetStep;
extern _Bool isTimeProcess;
extern _Bool isInSetting;
extern signed int CorrectTemp;
extern signed int CurrentTemp;
extern uint LightValue;
extern uint GrayScale;
extern _Bool isCanUpdateGrayScale;
extern _Bool isBeeper;
extern uchar ErrorCode;
extern _Bool isPIR;
extern uchar LittleFishWakeUp;
extern uchar LightnessMode;
extern uint testValue;
extern uint RandSeed;
/*
DisplayMode:
0-Controller Off:000
1-ON:On time
2-ON:Off time
3-Set
*/

#endif