/* *****************************************************************************
 * @file    platform/stm32/stm32utils/utils.h
 *
 * @brief   stm32 library libmaple utilities
 *
 * @log     2011-08-03 Initial revision
 *
 * *****************************************************************************
 * COPYRIGHT (C) LEAFGRASS - Librae (g.leafgrass@gmail.com)
 *
 * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
 * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
 * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
 * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
 * ****************************************************************************/

#ifndef __STM32UTILS_H__
#define __STM32UTILS_H__

#define SYSTICK_RELOAD_VAL  71999 /* takes a cycle to reload */
#define SERIAL_BAUDRATE     9600

#if (USART_CONSOLE_BANK == USART1)
#define USART_CONSOLE_PORT  GPIOA
#define USART_CONSOLE_TX    9
#define USART_CONSOLE_RX    10
#elif (USART_CONSOLE_BANK == USART2)
#define USART_CONSOLE_PORT  GPIOA
#define USART_CONSOLE_TX    2
#define USART_CONSOLE_RX    3
#elif (USART_CONSOLE_BANK == USART3)
#define USART_CONSOLE_PORT  GPIOB
#define USART_CONSOLE_TX    10
#define USART_CONSOLE_RX    11
#else
#error "You must specify a USART_CONSOLE_BANK."
#endif

void stm32utils_board_init(void);
void stm32utils_io_putc(void *p, char ch);


#endif /* __STM32UTILS_H__ */

