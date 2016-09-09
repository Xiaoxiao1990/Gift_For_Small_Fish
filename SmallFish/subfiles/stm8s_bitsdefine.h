/**
  ******************************************************************************
  * @file    stm8s.h
  * @author  MCD Application Team
  * @version V2.0.0
  * @date    25-February-2011
  * @brief   This file contains all HW registers definitions and memory mapping.
  ******************************************************************************/
#ifndef _MACRO_BITS_DEFINE_H_ 
#define _MACRO_BITS_DEFINE_H_ 

/*----------------------------------------------------------------------------*/
//IO bits define

/* Port A data output bits*/
volatile _Bool	PA_ODR_0		@PA_ODR:0;
volatile _Bool	PA_ODR_1		@PA_ODR:1;
volatile _Bool	PA_ODR_2		@PA_ODR:2;
volatile _Bool	PA_ODR_3		@PA_ODR:3;
volatile _Bool	PA_ODR_4		@PA_ODR:4;
volatile _Bool	PA_ODR_5		@PA_ODR:5;
volatile _Bool	PA_ODR_6		@PA_ODR:6;
volatile _Bool	PA_ODR_7		@PA_ODR:7;

/* Port A data input bits*/
volatile _Bool	PA_IDR_0		@PA_IDR:0;
volatile _Bool	PA_IDR_1		@PA_IDR:1;
volatile _Bool	PA_IDR_2		@PA_IDR:2;
volatile _Bool	PA_IDR_3		@PA_IDR:3;
volatile _Bool	PA_IDR_4		@PA_IDR:4;
volatile _Bool	PA_IDR_5		@PA_IDR:5;
volatile _Bool	PA_IDR_6		@PA_IDR:6;
volatile _Bool	PA_IDR_7		@PA_IDR:7;

/* Port B data output bits*/
volatile _Bool	PB_ODR_0		@PB_ODR:0;
volatile _Bool	PB_ODR_1		@PB_ODR:1;
volatile _Bool	PB_ODR_2		@PB_ODR:2;
volatile _Bool	PB_ODR_3		@PB_ODR:3;
volatile _Bool	PB_ODR_4		@PB_ODR:4;
volatile _Bool	PB_ODR_5		@PB_ODR:5;
volatile _Bool	PB_ODR_6		@PB_ODR:6;
volatile _Bool	PB_ODR_7		@PB_ODR:7;

/* Port B data input bits*/
volatile _Bool	PB_IDR_0		@PB_IDR:0;
volatile _Bool	PB_IDR_1		@PB_IDR:1;
volatile _Bool	PB_IDR_2		@PB_IDR:2;
volatile _Bool	PB_IDR_3		@PB_IDR:3;
volatile _Bool	PB_IDR_4		@PB_IDR:4;
volatile _Bool	PB_IDR_5		@PB_IDR:5;
volatile _Bool	PB_IDR_6		@PB_IDR:6;
volatile _Bool	PB_IDR_7		@PB_IDR:7;

/* Port C data output bits*/
volatile _Bool	PC_ODR_0		@PC_ODR:0;
volatile _Bool	PC_ODR_1		@PC_ODR:1;
volatile _Bool	PC_ODR_2		@PC_ODR:2;
volatile _Bool	PC_ODR_3		@PC_ODR:3;
volatile _Bool	PC_ODR_4		@PC_ODR:4;
volatile _Bool	PC_ODR_5		@PC_ODR:5;
volatile _Bool	PC_ODR_6		@PC_ODR:6;
volatile _Bool	PC_ODR_7		@PC_ODR:7;

/* Port C data input bits*/
volatile _Bool	PC_IDR_0		@PC_IDR:0;
volatile _Bool	PC_IDR_1		@PC_IDR:1;
volatile _Bool	PC_IDR_2		@PC_IDR:2;
volatile _Bool	PC_IDR_3		@PC_IDR:3;
volatile _Bool	PC_IDR_4		@PC_IDR:4;
volatile _Bool	PC_IDR_5		@PC_IDR:5;
volatile _Bool	PC_IDR_6		@PC_IDR:6;
volatile _Bool	PC_IDR_7		@PC_IDR:7;

/* Port D data output bits*/
volatile _Bool	PD_ODR_0		@PD_ODR:0;
volatile _Bool	PD_ODR_1		@PD_ODR:1;
volatile _Bool	PD_ODR_2		@PD_ODR:2;
volatile _Bool	PD_ODR_3		@PD_ODR:3;
volatile _Bool	PD_ODR_4		@PD_ODR:4;
volatile _Bool	PD_ODR_5		@PD_ODR:5;
volatile _Bool	PD_ODR_6		@PD_ODR:6;
volatile _Bool	PD_ODR_7		@PD_ODR:7;

/* Port D data input bits*/
volatile _Bool	PD_IDR_0		@PD_IDR:0;
volatile _Bool	PD_IDR_1		@PD_IDR:1;
volatile _Bool	PD_IDR_2		@PD_IDR:2;
volatile _Bool	PD_IDR_3		@PD_IDR:3;
volatile _Bool	PD_IDR_4		@PD_IDR:4;
volatile _Bool	PD_IDR_5		@PD_IDR:5;
volatile _Bool	PD_IDR_6		@PD_IDR:6;
volatile _Bool	PD_IDR_7		@PD_IDR:7;

/*Port E data output bits*/
volatile _Bool PE_ODR_5     @PD_ODR:5;

/*Port F data output bits*/
//volatile _Bool PF_ODR_4     @PF_ODR:4;
/*----------------------------------------------------------------------------*/

/** @addtogroup ADC1_Registers_Bits_Definition
  * @{
  */

 volatile _Bool bitADC1_CSR_EOC    @ADC_CSR:7;  /*!< End of Conversion mask */
 volatile _Bool bitADC1_CSR_AWD    @ADC_CSR:6; /*!< Analog Watch Dog Status mask */
 volatile _Bool bitADC1_CSR_EOCIE    @ADC_CSR:5; /*!< Interrupt Enable for EOC mask */
 volatile _Bool bitADC1_CSR_AWDIE    @ADC_CSR:4; /*!< Analog Watchdog interrupt enable mask */
 volatile _Bool bitADC1_CR1_ADON    @ADC_CR1:0; /*!< A/D Converter on/off mask */


/*----------------------------------------------------------------------------*/

/** @addtogroup BEEP_Registers_Bits_Definition
  * @{
  */
volatile _Bool bitBEEP_CSR_BEEPEN  @BEEP_CSR:5; /*!< Beeper enable mask */
/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  Clock Controller (CLK)
  */
/** @addtogroup CLK_Registers_Bits_Definition
  * @{
  */
 volatile _Bool bitCLK_ICKR_LSIRDY     @CLK_ICKR:4; /*!< Low speed internal oscillator ready */
 volatile _Bool bitCLK_ICKR_LSIEN      @CLK_ICKR:3; /*!< Low speed internal RC oscillator enable */
 volatile _Bool bitCLK_ICKR_HSIRDY     @CLK_ICKR:1; /*!< High speed internal RC oscillator ready */
 volatile _Bool bitCLK_ICKR_HSIEN      @CLK_ICKR:0; /*!< High speed internal RC oscillator enable */

 volatile _Bool bitCLK_ECKR_HSERDY     @CLK_ECKR:1; /*!< High speed external crystal oscillator ready */
 volatile _Bool bitCLK_ECKR_HSEEN      @CLK_ECKR:0; /*!< High speed external crystal oscillator enable */

 volatile _Bool bitCLK_SWCR_SWEN       @CLK_SWCR:1; /*!< Switch start/stop */
 volatile _Bool bitCLK_SWCR_SWBSY      @CLK_SWCR:0; /*!< Switch busy flag*/

/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  16-bit timer with complementary PWM outputs (TIM1)
  */

/** @addtogroup TIM1_Registers_Bits_Definition
  * @{
  */
/* CR1*/
volatile _Bool bitTIM1_CR1_ARPE	@TIM1_CR1:0; /*!< Auto-Reload Preload Enable mask. */
volatile _Bool bitTIM1_CR1_CEN	@TIM1_CR1:0; /*!< Counter Enable mask. */
/*IER*/
volatile _Bool bitTIM1_IER_UIE	@TIM1_IER:0; /*!< Update Interrupt Enable mask. */
/*SR1*/
volatile _Bool bitTIM1_SR1_UIF	@TIM1_SR1:0; /*!< Update Interrupt Flag mask. */

/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  16-bit timer (TIM2)
  */

/** @addtogroup TIM2_Registers_Bits_Definition
  * @{
  */
/*CR1*/
volatile _Bool bitTIM2_CR1_ARPE	@TIM2_CR1:7; /*!< Auto-Reload Preload Enable mask. */
volatile _Bool bitTIM2_CR1_CEN	@TIM2_CR1:0; /*!< Counter Enable mask. */
/*IER*/
volatile _Bool bitTIM2_IER_CC3IE	@TIM2_IER:3; /*!< Capture/Compare 3 Interrupt Enable mask. */
volatile _Bool bitTIM2_IER_CC2IE	@TIM2_IER:2; /*!< Capture/Compare 2 Interrupt Enable mask. */
volatile _Bool bitTIM2_IER_CC1IE	@TIM2_IER:1; /*!< Capture/Compare 1 Interrupt Enable mask. */
volatile _Bool bitTIM2_IER_UIE	@TIM2_IER:0; /*!< Update Interrupt Enable mask. */

volatile _Bool bitTIM2_CCER1_CC2E  @TIM2_CCER1:4; /*!< Capture/Compare 2 output enable mask. */

/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  16-bit timer (TIM3)
  */

/** @addtogroup TIM3_Registers_Bits_Definition
  * @{
  */
	/*
/*CR1*/
//volatile _Bool bitTIM3_CR1_ARPE	@TIM3_CR1:7; /*!< Auto-Reload Preload Enable mask. */
//volatile _Bool bitTIM3_CR1_CEN	@TIM3_CR1:0; /*!< Counter Enable mask. */
/*IER*/
//volatile _Bool bitTIM3_IER_CC2IE	@TIM3_IER:2; /*!< Capture/Compare 2 Interrupt Enable mask. */
//volatile _Bool bitTIM3_IER_CC1IE	@TIM3_IER:1; /*!< Capture/Compare 1 Interrupt Enable mask. */
//volatile _Bool bitTIM3_IER_UIE	@TIM3_IER:0; /*!< Update Interrupt Enable mask. */
/*SR1*/
//volatile _Bool bitTIM3_SR1_CC2IF	@TIM3_SR1:2; /*!< Capture/Compare 2 Interrupt Flag mask. */
//volatile _Bool bitTIM3_SR1_CC1IF	@TIM3_SR1:1; /*!< Capture/Compare 1 Interrupt Flag mask. */
//volatile _Bool bitTIM3_SR1_UIF	@TIM3_SR1:0; /*!< Update Interrupt Flag mask. */

/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  8-bit system timer (TIM4)
  */

/** @addtogroup TIM4_Registers_Bits_Definition
  * @{
  */
/*CR1*/
volatile _Bool bitTIM4_CR1_ARPE	@TIM4_CR1:7; /*!< Auto-Reload Preload Enable mask. */
volatile _Bool bitTIM4_CR1_CEN	@TIM4_CR1:0; /*!< Counter Enable mask. */
/*IER*/
volatile _Bool bitTIM4_IER_UIE	@TIM4_IER:0; /*!< Update Interrupt Enable mask. */
/*SR1*/
volatile _Bool bitTIM4_SR1_UIF	@TIM4_SR:0; /*!< Update Interrupt Flag mask. */
/*EGR*/
volatile _Bool bitTIM4_EGR_UG	@TIM4_EGR:0; /*!< Update Generation mask. */
/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  FLASH program and Data memory (FLASH)
  */

/** @addtogroup FLASH_Registers_Bits_Definition
  * @{
  */
volatile _Bool bitFLASH_IAPSR_DUL	@FLASH_IAPSR:3; /*!< Data EEPROM unlocked flag mask */
volatile _Bool bitFLASH_IAPSR_EOP	@FLASH_IAPSR:2;  /*!< End of operation flag mask */

/**
  * @}
  */

/**
  * @}
  */

/*----------------------------------------------------------------------------*/
/**
  * @brief  Universal Synchronous Asynchronous Receiver Transmitter (UART1)
  */

/** @addtogroup UART1_Registers_Bits_Definition
  * @{
  */
/*SR*/
volatile _Bool bitUART1_SR_TXE	@UART1_SR:7; /*!< Transmit Data Register Empty mask */
volatile _Bool bitUART1_SR_TC	@UART1_SR:6; /*!< Transmission Complete mask */
volatile _Bool bitUART1_SR_RXNE	@UART1_SR:5; /*!< Read Data Register Not Empty mask */
volatile _Bool bitUART1_SR_IDLE	@UART1_SR:4; /*!< IDLE line detected mask */
volatile _Bool bitUART1_SR_OR	@UART1_SR:3;	/*!< OverRun error mask */
volatile _Bool bitUART1_SR_NF	@UART1_SR:2; /*!< Noise Flag mask */
volatile _Bool bitUART1_SR_FE	@UART1_SR:1; /*!< Framing Error mask */
volatile _Bool bitUART1_SR_PE	@UART1_SR:0; /*!< Parity Error mask */
/*CR2*/
volatile _Bool bitUART1_CR2_TIEN	@UART1_CR2:7; /*!< Transmitter Interrupt Enable*/ 
volatile _Bool bitUART1_CR2_TCIEN	@UART1_CR2:6; /*!< Transmission Complete Interrupt Enable mask */
volatile _Bool bitUART1_CR2_RIEN	@UART1_CR2:5; /*!< Receiver Interrupt Enable mask */
volatile _Bool bitUART1_CR2_ILIEN	@UART1_CR2:4; /*!< IDLE Line Interrupt Enable mask */
volatile _Bool bitUART1_CR2_TEN	@UART1_CR2:3; /*!< Transmitter Enable mask */
volatile _Bool bitUART1_CR2_REN	@UART1_CR2:2; /*!< Receiver Enable mask */

/**
  * @}
  */

#endif
/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
