#include "includes.h"

void _configSet(void)
{
	/***************************************************************
	========================== IO setting ==========================
	DDR CR1 CR2 引脚设置
		0  0  0  悬浮输入
		0  0  1  上拉输入
		0  1  0  中断悬浮输入
		0  1  1  中断上拉输入
		1  0  0  开漏输出
		1  1  0  推挽输出
		1  X  1  输出（最快速度为10MHZ）
STM8S103K3
  ***************************************************************/
	PA_DDR = 0B00000110;
	PA_CR1 = 0B00001110;
	PA_CR2 = 0B00000000;
	PA_ODR = 0B00000000;
	
	PB_DDR = 0B00010000;
	PB_CR1 = 0B00010000;
	PB_CR2 = 0B00000000;
	PB_ODR = 0B00010000;

	PC_DDR = 0B10100000;
	PC_CR1 = 0B11100000;
	PC_CR2 = 0B00000000;
	PC_ODR = 0B00000000;
	
	PD_DDR = 0B00101000;
	PD_CR1 = 0B01101010;
	PD_CR2 = 0B00000000;
	PD_ODR = 0B00000000;
	/***************************************************************
	======================== system clock ==========================
	internal clock: 8MHz
  ***************************************************************/
	
	// ---------------high internal oscilator--------------------
	//CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
	//CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);	//system clk 8M
	
	CLK_SWR = 0xE1; 		//internal clock 16M as main clock
	CLK_CKDIVR = 0x08;  //fcpu = fmaster = fHSI/2 = 8MHz
	
	CLK_ICKR = CLK_ICKR | 0x08; // 打开芯片内部的低速振荡器LSI
	//while((CLK_ICKR & 0x10) == 0); // 等待振荡器稳定
}