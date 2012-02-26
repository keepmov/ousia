/* stm32 port */
#ifndef __OUSIA_CFG_H__
#define __OUSIA_CFG_H__

#define OUSIA_USE_ULIB
#define OUSIA_USE_LIBMAPLE

#define OUSIA_PRINT_TYPE_SERIAL	0
#define OUSIA_PRINT_TYPE_USB	1
#define OUSIA_PRINT_TYPE	OUSIA_PRINT_TYPE_USB

/*
 * scheduler strategy
 * 0 - EDFS
 * 1 - EDFS_OPT
 * 2 - HPFS
 * 3 - CFS
 */
#define OUSIA_SCHED_STRATEGY_EDFS
/*#define OUSIA_SCHED_STRATEGY_EDFS_OPT*/
/*#define OUSIA_SCHED_STRATEGY_HPFS*/
/*#define OUSIA_SCHED_STRATEGY_CFS*/

#endif /* __OUSIA_CFG_H__ */
