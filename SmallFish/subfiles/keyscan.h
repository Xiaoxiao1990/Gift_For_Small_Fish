/*IO_devices.h file
*IO devices in this project above
*2 digital tubes,3 buttons,8 LEDs
**/
#ifndef _IO_DEVICES_H_
#define _IO_DEVICES_H_

extern void _IOInitial(void);
extern void _keyScan(void);
extern void	_displayDecode(void);
extern void	_keyScanProcess(void);
#endif