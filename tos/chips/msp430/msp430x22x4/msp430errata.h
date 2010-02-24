#ifndef _H_msp430errata_h
#define _H_msp430errata_h

/* See SLAZ034G MSP430F22x2/22x4 Device Erratasheet, Revised March 2009 */

#if defined(__MSP430_2232__) || defined(__MSP430_2234__) || defined(__MSP430_2252__) || \
    defined(__MSP430_2254__) || defined(__MSP430_2272__) || defined(__MSP430_2274__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'D'"
#define __MSP430_REV__ 'D'
#endif

#if __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E' || __MSP430_REV__ == 'F' || \
    __MSP430_REV__ == 'G'
#define ERRATA_BCL12
#define ERRATA_CPU19
#define ERRATA_FLASH24
#define ERRATA_FLASH27
#define ERRATA_PORT10
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TAB22
#define ERRATA_TB2
#define ERRATA_TB16
#define ERRATA_USCI20
#define ERRATA_USCI21
#define ERRATA_USCI22
#define ERRATA_USCI23
#define ERRATA_USCI24
#define ERRATA_USCI25
#define ERRATA_USCI26
#define ERRATA_USCI27
#define ERRATA_XOSC5
#endif

#if __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E' || __MSP430_REV__ == 'F'
#define ERRATA_BCL13
#endif

#if __MSP430_REV__ == 'D' || __MSP430_REV__ == 'E'
#define ERRATA_CPU14
#define ERRATA_FLASH22
#define ERRATA_JTAG14
#define ERRATA_USCI16
#endif

#if __MSP430_REV__ == 'D'
#define ERRATA_FLASH21
#define ERRATA_JTAG13
#endif

#else
#error "This msp430errata.h is for MSP430F22x2/22x4"
#endif

#endif