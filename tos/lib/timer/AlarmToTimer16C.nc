//$Id: AlarmToTimerC.nc,v 1.7 2010-06-29 22:07:50 scipio Exp $

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

#include "Timer16.h"

/**
 * AlarmToTimerC converts a 16-bit Alarm to a Timer16.
 *
 * <p>See TEP102 for more details.
 * @param precision_tag A type indicating the precision of the Alarm and
 * Timer being converted.
 *
 * @author Cory Sharp <cssharp@eecs.berkeley.edu>
 */

generic module AlarmToTimer16C(typedef precision_tag) @safe()
{
  provides interface Timer16<precision_tag>;
  uses interface Alarm<precision_tag,uint16_t>;
}
implementation
{
  // there might be ways to save bytes here, but I'll do it in the obviously
  // right way for now
  uint16_t m_dt;
  bool m_oneshot;

  void start(uint16_t t0, uint16_t dt, bool oneshot)
  {
    m_dt = dt;
    m_oneshot = oneshot;
    call Alarm.startAt(t0, dt);
  }

  command void Timer16.startPeriodic(uint16_t dt)
  { start(call Alarm.getNow(), dt, FALSE); }

  command void Timer16.startOneShot(uint16_t dt)
  { start(call Alarm.getNow(), dt, TRUE); }

  command void Timer16.stop()
  { call Alarm.stop(); }

  task void fired()
  { 
    if(m_oneshot == FALSE)
      start(call Alarm.getAlarm(), m_dt, FALSE);
    signal Timer16.fired();
  }

  async event void Alarm.fired()
  { post fired(); }

  command bool Timer16.isRunning()
  { return call Alarm.isRunning(); }

  command bool Timer16.isOneShot()
  { return m_oneshot; }

  command void Timer16.startPeriodicAt(uint16_t t0, uint16_t dt)
  { start(t0, dt, FALSE); }

  command void Timer16.startOneShotAt(uint16_t t0, uint16_t dt)
  { start(t0, dt, TRUE); }

  command uint16_t Timer16.getNow()
  { return call Alarm.getNow(); }

  command uint16_t Timer16.gett0()
  { return call Alarm.getAlarm() - m_dt; }

  command uint16_t Timer16.getdt()
  { return m_dt; }
}

