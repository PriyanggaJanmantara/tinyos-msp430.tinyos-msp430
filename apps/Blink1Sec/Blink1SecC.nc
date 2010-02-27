/* -*- mode: nesc; mode: flyspell-prog; -*- */
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

#include "Timer.h"

module Blink1SecC @safe()
{
    uses interface Timer<TMilli> as Timer;
    uses interface Leds;
    uses interface Boot;
}
implementation
{
    enum {
        CYCLE = 1000,
        FLASH = 200,
    };
    bool on = TRUE;
    
    event void Boot.booted() {
        call Leds.led0On();
        call Timer.startPeriodic(FLASH);
    }

    event void Timer.fired() {
        if (on) {
            call Timer.startPeriodic(CYCLE - FLASH);
        } else {
            call Timer.startPeriodic(FLASH);
        }
        call Leds.led0Toggle();
        on = !on;
    }
}

/*
 * Local Variables:
 * c-file-style: "bsd"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 * vim: set et ts=4 sw=4:
 */
