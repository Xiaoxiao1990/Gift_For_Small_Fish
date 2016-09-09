#include "includes.h"

void _timerBaseInitial(void)
{
	TIM4_IER = 0x00; // disable interrup
	TIM4_EGR = 0x01; // enable update
	TIM4_PSCR = 2; // timerclock=manclock/64=8MHZ/64=8us
	TIM4_ARR = 255; // set reload resister
	TIM4_CNTR = 255; // set conter initial,cycle time=(ARR+1)*16=2.048ms
	TIM4_CR1 = 0x01; // b0 = 1,enable timer 4,b1 = 0, enable update
}

void _timer1_Initial(void)
{
	//��ʼ����ʱ��1  
	_asm("sim");
	TIM1_PSCRH = 0;
	TIM1_PSCRL = 2;    //(fCK_CNT)����fCK_PSC/( PSCR[15:0]+1)
	TIM1_CNTRH = 0xc3;
	TIM1_CNTRL = 0x50;//�����Ĵ�����ֵ
	TIM1_IER = 0x01;//��������ж�
	TIM1_RCR = 0;//�ظ������Ĵ���ֵ 
	TIM1_CR1 = 0x01;//���Զ�װ�أ��򿪼�����
	_asm("rim");                // ����CPUȫ���ж�
}

void _timer2_Initial(void)
{
	TIM2_CCMR2 = 0x60;
	//OC1M = 110 ģʽ2 ����С������ֵʱΪ1������Ϊ��
	//OC1PE Ԥװ��ʹ�ܹ�
	//CC1S = 00 ͨ��2����Ϊ�Ƚ����
	TIM2_CCER1 = 0x10;
	//�ߵ�ƽ��Ч
	//����ͨ��2�������
	
	//PWM Frequency
	TIM2_PSCR = 0x00;//Fmaster/2^n = 8M/2^0 = 8MHz
	//ʱ�ӷ�Ƶ����2^2 = 1
	/*f = Fpscr/CNT = 8M/1000  = 8kHz,1/8us per count 1*/
	//counter 1000
	//TIM2_ARRH = 0x03;
	//TIM2_ARRL = 0xE8;
	//count 1000;grayscale:1000;
	TIM2_ARRH = 0x01;
	TIM2_ARRL = 0xF4;
	//PWM Ratio
	TIM2_CCR2H = 0x00;
	TIM2_CCR2L = 0x00;
//	TIM2_CCR3H = 0;
//	TIM2_CCR3L = 0;
	//��ʼ��ռ�ձ�Ϊ0
	
	TIM2_CR1 |= 0x01;//����������
}

void _timerBase(void)		//2.048ms
{											
	if (bitTIM4_SR1_UIF) // 
	{
		bitTIM4_SR1_UIF = 0; 
		isTimeProcess = Yes;
	}
}

void updateGrayScale(void)
{
	uint lightness;
	if(LightnessMode < 1)return;//Lightness adjust by manual
	if(!isCanUpdateGrayScale)
	{
		isCanUpdateGrayScale = 1;
		lightness = LightValue>>1;//LightValue:10(ON)~1000(OFF);
		if(lightness > 499)lightness = 499;//0%
		if(lightness < 30)lightness = 0;//100%
		
		if(isPIR)//Detected Small Fish
		{
			//night
			if((LightValue > 800)||(Now.Hour < 7 || Now.Hour >= 21))
			{//21:00~6:59
				//��������������
				if(GrayScale < 250)GrayScale += 10;//������һ��
			}
			else
			{
				if(GrayScale < 500)GrayScale += 20;//������һ��
			}
		}
		GrayScale = lightness;
	}
}

void _timerWheel(void)
{
	static uchar timeCNT = 0;
	if(is500ms)
	{
		is500ms = 0;
		_getTime();
	}
	if(isOneSecond)//500ms
	{
		isOneSecond = Clear;
		isUpdateDisplay = Yes;
		
		updateGrayScale();
		if(LittleFishWakeUp > 0)LittleFishWakeUp--;
		else
		{
			isPIR = 0;
		}
		if(++timeCNT < 10)DisplayMode = 0;
		else if(timeCNT < 20)DisplayMode = 1;
		else timeCNT = 0;
		
		if(MachineStatus >= SETTING)
		{
			if(++inSetTimer > 25)
			{
				isInSetting = 0;
				inSetTimer = 0;
				MachineStatus = IDEL;
				SetStep = 0;
				//_EEPROM_saveSettings();
			}
		}
	}
}