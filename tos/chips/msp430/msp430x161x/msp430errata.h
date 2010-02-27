/* -*- mode: c; mode: flyspell-prog; -*- */
/*
 * Copyright (C) 2010 Tadashi G. Takaoka
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef _H_msp430errata_h
#define _H_msp430errata_h

/* See SLAZ018B MSP430F15x/16x/161x Device Erratasheet, Revised July 2007 */

#if defined(__MSP430_1610_) || defined(__MSP430_1611__) || defined(__MSP430_1612__)

#if !defined(__MSP430_REV__)
#warning "__MSP430_REV__ not defined, default to 'A'"
#define __MSP430_REV__ 'A'
#endif

#if __MSP430_REV__ == 'A' || __MSP430_REV__ == 'B'
#define ERRATA_ADC18
#define ERRATA_BCL5
#define ERRATA_CPU4
#define ERRATA_I2C7
#define ERRATA_I2C8
#define ERRATA_I2C9
#define ERRATA_I2C10
#define ERRATA_I2C11
#define ERRATA_I2C12
#define ERRATA_I2C13
#define ERRATA_I2C14
#define ERRATA_TA12
#define ERRATA_TA16
#define ERRATA_TB2
#define ERRATA_TB16
#define ERRATA_US15
#define ERRATA_WDG2
#endif

#if __MSP430_REV__ == 'A'
#define ERRATA_SVS2
#define ERRATA_US14
#endif

#else
#error "This msp430errata.h is for MSP430F161x"
#endif

#endif

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
