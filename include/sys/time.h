/*
 * Copyright (c) 2011-2012 LeafGrass <leafgrass.g@gmail.com>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
 * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
 * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
 * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
 */

/*
 * @file    include/sys/time.h
 * @brief   header of ousia timer
 * @log     2011.8 initial revision
 */

#ifndef __SYS_TIME_H__
#define __SYS_TIME_H__


/*
 * process timer control block
 * FIXME some of these members are
 * redundant, needs a cleansheet
 */
struct _ptcb_t {
	uint32 ticks_running;
	uint32 ticks_sleeping;
	uint32 deadline;
};

uint32 os_systime_get(void);
void _sys_time_systick_init(void);
void _sys_time_register_hook(void (*fn)(void));


#endif /* __SYS_TIME_H__ */
