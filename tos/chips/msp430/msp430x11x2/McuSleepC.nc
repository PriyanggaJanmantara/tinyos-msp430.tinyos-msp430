module McuSleepC @safe()
{
    provides {
        interface McuSleep;
        interface McuPowerState;
    }
    uses {
        interface McuPowerOverride;
    }
}
implementation
{
    bool dirty = TRUE;
    mcu_power_t powerState = MSP430_POWER_ACTIVE;

    /* Note that the power values are maintained in an order
     * based on their active components, NOT on their values.*/
    // NOTE: This table should be in progmem.
    const uint16_t msp430PowerBits[MSP430_POWER_LPM4 + 1] = {
        0,                                       // ACTIVE
        SR_CPUOFF,                               // LPM0
        SR_SCG0+SR_CPUOFF,                       // LPM1
        SR_SCG1+SR_CPUOFF,                       // LPM2
        SR_SCG1+SR_SCG0+SR_CPUOFF,               // LPM3
        SR_SCG1+SR_SCG0+SR_OSCOFF+SR_CPUOFF,     // LPM4
    };
    
    mcu_power_t getPowerState() {
        mcu_power_t pState = MSP430_POWER_LPM4;
        // TimerA check
        if (((TACCTL0 & CCIE) || (TACCTL1 & CCIE))
            && (TACTL & TASSEL_3) == TASSEL_2)
            pState = MSP430_POWER_LPM3;
    
        return pState;
    }
  
    void computePowerState() {
        powerState = mcombine(getPowerState(),
                              call McuPowerOverride.lowestState());
    }
  
    async command void McuSleep.sleep() {
        uint16_t temp;
        if (dirty) {
            computePowerState();
            //dirty = 0;
        }
        temp = msp430PowerBits[powerState] | SR_GIE;
        __asm__ __volatile__( "bis  %0, r2" : : "m" (temp) );
        // All of memory may change at this point...
        asm volatile ("" : : : "memory");
        __nesc_disable_interrupt();
    }

    async command void McuPowerState.update() {
        atomic dirty = 1;
    }

    default async command mcu_power_t McuPowerOverride.lowestState() {
        return MSP430_POWER_LPM4;
    }
}
