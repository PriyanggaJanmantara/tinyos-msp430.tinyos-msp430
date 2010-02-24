configuration Msp430TimerVloMapC
{
    provides interface Msp430Timer[uint8_t id];
    provides interface Msp430TimerControl[uint8_t id];
    provides interface Msp430Compare[uint8_t id];
}
implementation
{
    components Msp430TimerC;

    Msp430Timer[0] = Msp430TimerC.TimerA;
    Msp430TimerControl[0] = Msp430TimerC.ControlA0;
    Msp430Compare[0] = Msp430TimerC.CompareA0;

    Msp430Timer[1] = Msp430TimerC.TimerA;
    Msp430TimerControl[1] = Msp430TimerC.ControlA1;
    Msp430Compare[1] = Msp430TimerC.CompareA1;

#if defined(__MSP430_HAS_TA3__)
    Msp430Timer[2] = Msp430TimerC.TimerA;
    Msp430TimerControl[2] = Msp430TimerC.ControlA2;
    Msp430Compare[2] = Msp430TimerC.CompareA2;
#endif
}