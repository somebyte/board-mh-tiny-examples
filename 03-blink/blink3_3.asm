.include "../t88.inc/macros.inc"

.cseg
.org 0x000
       ; Tiny88 interrupt vectors are different from Atmega88
       rjmp reset  ;  1 | 0x000 | RESET        | RESET External/Power-on/Brown-out/Watchdog Reset
       reti        ;  2 | 0x001 | INT0         | External Interrupt Request 0
       reti        ;  3 | 0x002 | INT1         | External Interrupt Request 1
       reti        ;  4 | 0x003 | PCINT0       | Pin Change Interrupt Request 0
       reti        ;  5 | 0x004 | PCINT1       | Pin Change Interrupt Request 1
       reti        ;  6 | 0x005 | PCINT2       | Pin Change Interrupt Request 2
       reti        ;  7 | 0x006 | PCINT3       | Pin Change Interrupt Request 3
       reti        ;  8 | 0x007 | WDT          | Watchdog Time-out Interrupt
       reti        ;  9 | 0x008 | TIMER1_CAPT  | Timer/Counter1 Capture Event
       reti        ; 10 | 0x009 | TIMER1_COMPA | Timer/Counter1 Compare Match A
       reti        ; 11 | 0x00A | TIMER1_COMPB | Timer/Counter1 Compare Match B
       reti        ; 12 | 0x00B | TIMER1_OVF   | Timer/Counter1 Overflow
       rjmp compa  ; 13 | 0x00C | TIMER0_COMPA | Timer/Counter0 Compare Match A
       reti        ; 14 | 0x00D | TIMER0_COMPB | Timer/Counter0 Compare Match B
       reti        ; 15 | 0x00E | TIMER0_OVF   | Timer/Counter0 Overflow
       reti        ; 16 | 0x00F | SPI_STC      | SPI Serial Transfer Complete
       reti        ; 17 | 0x010 | ADC          | ADC Conversion Complete
       reti        ; 18 | 0x011 | EE_RDY       | EEPROM Ready
       reti        ; 19 | 0x012 | ANA_COMP     | Analog Comparator
       reti        ; 20 | 0x013 | TWI          | 2-wire Serial Interface

reset: 
       init_stack RAMEND_T88
       ;------------
       setDDRD (1<<PIND0)
       ;------------
       ldi r16,0x3F   ; Value OCRA0
       out OCR0A,r16  ; OCR0A – Output Compare Register A
       ldi r16,0x02   ; Timer/Counter0 Output Compare Match A Interrupt Enable
       sts TIMSK0,r16 ; 
       ldi r16,0x0D   ; (1<<CTC0)|(1<<CS02)|(1<<CS01)|(0<<CS00)
                      ; CTC0: Clear Timer on Compare Match Mode
       out TCCR0B,r16 ; TCCR0A(Tiny88) = TCCR0B(Atmega88) = 0x25 
       clr r16        ; Clear
       out TCNT0,r16  ; Timer/Counter Register
       sei 
loop: 
       sleep
       rjmp loop     
compa:
       inc r16
       cpi r16, 0x3E
       brne exit
       invPORTD (1<<PIND0)
       clr r16
exit: 
       reti
