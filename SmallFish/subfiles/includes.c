#include "includes.h"

/*Global*/
Time_TypeDef Now;
uchar LED_Buf[8];
uchar DisplayMode;
_Bool isUpdateDisplay;
_Bool isOneSecond;
_Bool is500ms;
_Bool is50ms;//for display
_Bool isFlash1Hz;
_Bool isFlash2Hz;
uchar inSetTimer;
uchar SetMenu;
uchar SetStep;
uchar MachineStatus;
_Bool isTimeProcess;
_Bool isInSetting;
signed int CorrectTemp;
signed int CurrentTemp;
uint LightValue;
uint GrayScale;
_Bool isCanUpdateGrayScale;
uchar LightnessMode = 1;//Auto as default:;
uchar ErrorCode;
_Bool isBeeper;
_Bool isPIR;
uchar LittleFishWakeUp;
uint RandSeed;

uint testValue;