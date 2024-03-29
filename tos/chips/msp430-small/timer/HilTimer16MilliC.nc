
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
 * - Neither the name of the copyright holder nor the names of
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
 * HilTimerMilliC provides a parameterized interface to a virtualized
 * millisecond timer.  TimerMilliC in tos/system/ uses this component to
 * allocate new timers.
 *
 * @author Cory Sharp <cssharp@eecs.berkeley.edu>
 * @see  Please refer to TEP 102 for more information about this component and its
 *          intended use.
 */

configuration HilTimer16MilliC
{
  provides interface Init;
  provides interface Timer16<TMilli> as Timer16Milli[ uint8_t num ];
  provides interface LocalTime<TMilli>;
}
implementation
{
  components new AlarmMilli16C();
  components new AlarmToTimer16C(TMilli);
  components new VirtualizeTimer16C(TMilli,uniqueCount(UQ_TIMER16_MILLI));
  components new CounterToLocalTimeC(TMilli);
  components CounterMilli32C;

  Init = AlarmMilli16C;
  Timer16Milli = VirtualizeTimer16C;
  LocalTime = CounterToLocalTimeC;

  VirtualizeTimer16C.TimerFrom -> AlarmToTimer16C;
  AlarmToTimer16C.Alarm -> AlarmMilli16C;
  CounterToLocalTimeC.Counter -> CounterMilli32C;
}
