#ifndef _RTC_H_
#define _RTC_H_

extern void _RTC_Init(void);
extern void _getTime(void);
extern void _setTime(void);
extern unsigned char DEC2BCD(unsigned char DEC);
extern unsigned char BCD2DEC(unsigned char BCD);

#endif