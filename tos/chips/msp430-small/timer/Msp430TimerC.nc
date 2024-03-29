
/* Copyright (c) 2000-2003 The Regents of the University of California.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holders nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 
/**
 * @author Cory Sharp <cssharp@eecs.berkeley.edu>
 */

configuration Msp430TimerC
{
  provides interface Msp430Timer as TimerA;
  provides interface Msp430TimerControl as ControlA0;
  provides interface Msp430TimerControl as ControlA1;
  provides interface Msp430Compare as CompareA0;
  provides interface Msp430Compare as CompareA1;
  provides interface Msp430Capture as CaptureA0;
  provides interface Msp430Capture as CaptureA1;
#if defined(__MSP430_HAS_TA3__)
  provides interface Msp430TimerControl as ControlA2;
  provides interface Msp430Compare as CompareA2;
  provides interface Msp430Capture as CaptureA2;
#endif

#if defined(__MSP430_HAS_T1A2__) || defined(__MSP430_HAS_T1A3__)
  provides interface Msp430Timer as Timer1A;
  provides interface Msp430TimerControl as Control1A0;
  provides interface Msp430Compare as Compare1A0;
  provides interface Msp430Capture as Capture1A0;
  provides interface Msp430TimerControl as Control1A1;
  provides interface Msp430Compare as Compare1A1;
  provides interface Msp430Capture as Capture1A1;
#if defined(__MSP430_HAS_T1A3__)
  provides interface Msp430TimerControl as Control1A2;
  provides interface Msp430Compare as Compare1A2;
  provides interface Msp430Capture as Capture1A2;
#endif
#endif

#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
  provides interface Msp430Timer as TimerB;
  provides interface Msp430TimerControl as ControlB0;
  provides interface Msp430TimerControl as ControlB1;
  provides interface Msp430TimerControl as ControlB2;
  provides interface Msp430Compare as CompareB0;
  provides interface Msp430Compare as CompareB1;
  provides interface Msp430Compare as CompareB2;
  provides interface Msp430Capture as CaptureB0;
  provides interface Msp430Capture as CaptureB1;
  provides interface Msp430Capture as CaptureB2;
#endif
#if defined(__MSP430_HAS_TB7__)
  provides interface Msp430TimerControl as ControlB3;
  provides interface Msp430TimerControl as ControlB4;
  provides interface Msp430TimerControl as ControlB5;
  provides interface Msp430TimerControl as ControlB6;
  provides interface Msp430Compare as CompareB3;
  provides interface Msp430Compare as CompareB4;
  provides interface Msp430Compare as CompareB5;
  provides interface Msp430Compare as CompareB6;
  provides interface Msp430Capture as CaptureB3;
  provides interface Msp430Capture as CaptureB4;
  provides interface Msp430Capture as CaptureB5;
  provides interface Msp430Capture as CaptureB6;
#endif
}
implementation
{
  components new Msp430TimerP( TAIV_, TAR_, TACTL_, TAIFG, TACLR, TAIE,
               TASSEL0, TASSEL1, FALSE ) as Msp430TimerA
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
           , new Msp430TimerP( TBIV_, TBR_, TBCTL_, TBIFG, TBCLR, TBIE,
               TBSSEL0, TBSSEL1, TRUE ) as Msp430TimerB
#endif
           , new Msp430TimerCapComP( TACCTL0_, TACCR0_ ) as Msp430TimerA0
           , new Msp430TimerCapComP( TACCTL1_, TACCR1_ ) as Msp430TimerA1
#if defined(__MSP430_HAS_TA3__)
           , new Msp430TimerCapComP( TACCTL2_, TACCR2_ ) as Msp430TimerA2
#endif
#if defined(__MSP430_HAS_T1A2__) || defined(__MSP430_HAS_T1A3__)
           , new Msp430TimerP(TA1IV_, TA1R_, TA1CTL_, TAIFG, TACLR, TAIE,
               TASSEL0, TASSEL1, FALSE) as Msp430Timer1A
           , new Msp430TimerCapComP(TACCTL0_, TACCR0_) as Msp430Timer1A0
           , new Msp430TimerCapComP(TACCTL1_, TACCR1_) as Msp430Timer1A1
#if defined(__MSP430_HAS_T1A3__)
           , new Msp430TimerCapComP(TACCTL2_, TACCR2_) as Msp430Timer1A2
#endif
#endif
#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
           , new Msp430TimerCapComP( TBCCTL0_, TBCCR0_ ) as Msp430TimerB0
           , new Msp430TimerCapComP( TBCCTL1_, TBCCR1_ ) as Msp430TimerB1
           , new Msp430TimerCapComP( TBCCTL2_, TBCCR2_ ) as Msp430TimerB2
#endif
#if defined(__MSP430_HAS_TB7__)
           , new Msp430TimerCapComP( TBCCTL3_, TBCCR3_ ) as Msp430TimerB3
           , new Msp430TimerCapComP( TBCCTL4_, TBCCR4_ ) as Msp430TimerB4
           , new Msp430TimerCapComP( TBCCTL5_, TBCCR5_ ) as Msp430TimerB5
           , new Msp430TimerCapComP( TBCCTL6_, TBCCR6_ ) as Msp430TimerB6
#endif
           , Msp430TimerCommonP as Common
           ;

  // Timer A
  TimerA = Msp430TimerA.Timer;
  Msp430TimerA.Overflow -> Msp430TimerA.Event[10];
  Msp430TimerA.VectorTimerX0 -> Common.VectorTimerA0;
  Msp430TimerA.VectorTimerX1 -> Common.VectorTimerA1;

  // Timer A0
  ControlA0 = Msp430TimerA0.Control;
  CompareA0 = Msp430TimerA0.Compare;
  CaptureA0 = Msp430TimerA0.Capture;
  Msp430TimerA0.Timer -> Msp430TimerA.Timer;
  Msp430TimerA0.Event -> Msp430TimerA.Event[0];

  // Timer A1
  ControlA1 = Msp430TimerA1.Control;
  CompareA1 = Msp430TimerA1.Compare;
  CaptureA1 = Msp430TimerA1.Capture;
  Msp430TimerA1.Timer -> Msp430TimerA.Timer;
  Msp430TimerA1.Event -> Msp430TimerA.Event[2];

#if defined(__MSP430_HAS_TA3__)
  // Timer A2
  ControlA2 = Msp430TimerA2.Control;
  CompareA2 = Msp430TimerA2.Compare;
  CaptureA2 = Msp430TimerA2.Capture;
  Msp430TimerA2.Timer -> Msp430TimerA.Timer;
  Msp430TimerA2.Event -> Msp430TimerA.Event[4];
#endif

#if defined(__MSP430_HAS_T1A2__) || defined(__MSP430_HAS_T1A3__)
  // Timer1 A
  Timer1A = Msp430Timer1A.Timer;
  Msp430Timer1A.Overflow -> Msp430Timer1A.Event[10];
  Msp430Timer1A.VectorTimerX0 -> Common.VectorTimer1A0;
  Msp430Timer1A.VectorTimerX1 -> Common.VectorTimer1A1;

  // Timer1 A0
  Control1A0 = Msp430Timer1A0.Control;
  Compare1A0 = Msp430Timer1A0.Compare;
  Capture1A0 = Msp430Timer1A0.Capture;
  Msp430Timer1A0.Timer -> Msp430Timer1A.Timer;
  Msp430Timer1A0.Event -> Msp430Timer1A.Event[0];

  // Timer1 A1
  Control1A1 = Msp430Timer1A1.Control;
  Compare1A1 = Msp430Timer1A1.Compare;
  Capture1A1 = Msp430Timer1A1.Capture;
  Msp430Timer1A1.Timer -> Msp430Timer1A.Timer;
  Msp430Timer1A1.Event -> Msp430Timer1A.Event[2];

#if defined(__MSP430_HAS_T1A3__)
  // Timer1 A2
  Control1A2 = Msp430Timer1A2.Control;
  Compare1A2 = Msp430Timer1A2.Compare;
  Capture1A2 = Msp430Timer1A2.Capture;
  Msp430Timer1A2.Timer -> Msp430Timer1A.Timer;
  Msp430Timer1A2.Event -> Msp430Timer1A.Event[4];
#endif
#endif

#if defined(__MSP430_HAS_TB3__) || defined(__MSP430_HAS_TB7__)
  // Timer B
  TimerB = Msp430TimerB.Timer;
  Msp430TimerB.Overflow -> Msp430TimerB.Event[14];
  Msp430TimerB.VectorTimerX0 -> Common.VectorTimerB0;
  Msp430TimerB.VectorTimerX1 -> Common.VectorTimerB1;

  // Timer B0
  ControlB0 = Msp430TimerB0.Control;
  CompareB0 = Msp430TimerB0.Compare;
  CaptureB0 = Msp430TimerB0.Capture;
  Msp430TimerB0.Timer -> Msp430TimerB.Timer;
  Msp430TimerB0.Event -> Msp430TimerB.Event[0];

  // Timer B1
  ControlB1 = Msp430TimerB1.Control;
  CompareB1 = Msp430TimerB1.Compare;
  CaptureB1 = Msp430TimerB1.Capture;
  Msp430TimerB1.Timer -> Msp430TimerB.Timer;
  Msp430TimerB1.Event -> Msp430TimerB.Event[2];

  // Timer B2
  ControlB2 = Msp430TimerB2.Control;
  CompareB2 = Msp430TimerB2.Compare;
  CaptureB2 = Msp430TimerB2.Capture;
  Msp430TimerB2.Timer -> Msp430TimerB.Timer;
  Msp430TimerB2.Event -> Msp430TimerB.Event[4];
#endif

#if defined(__MSP430_HAS_TB7__)
  // Timer B3
  ControlB3 = Msp430TimerB3.Control;
  CompareB3 = Msp430TimerB3.Compare;
  CaptureB3 = Msp430TimerB3.Capture;
  Msp430TimerB3.Timer -> Msp430TimerB.Timer;
  Msp430TimerB3.Event -> Msp430TimerB.Event[6];

  // Timer B4
  ControlB4 = Msp430TimerB4.Control;
  CompareB4 = Msp430TimerB4.Compare;
  CaptureB4 = Msp430TimerB4.Capture;
  Msp430TimerB4.Timer -> Msp430TimerB.Timer;
  Msp430TimerB4.Event -> Msp430TimerB.Event[8];

  // Timer B5
  ControlB5 = Msp430TimerB5.Control;
  CompareB5 = Msp430TimerB5.Compare;
  CaptureB5 = Msp430TimerB5.Capture;
  Msp430TimerB5.Timer -> Msp430TimerB.Timer;
  Msp430TimerB5.Event -> Msp430TimerB.Event[10];

  // Timer B6
  ControlB6 = Msp430TimerB6.Control;
  CompareB6 = Msp430TimerB6.Compare;
  CaptureB6 = Msp430TimerB6.Capture;
  Msp430TimerB6.Timer -> Msp430TimerB.Timer;
  Msp430TimerB6.Event -> Msp430TimerB.Event[12];
#endif
}

