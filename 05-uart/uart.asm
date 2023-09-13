.include "../t88.inc/sys.inc"
.include "../t88.inc/port.inc"
.include "../t88.inc/timers.inc"

.cseg
.org 0x000
       ; Tiny88 interrupt vectors are different from Atmega88
       rjmp reset  ;  1 | 0x000 | RESET        | RESET External/Power-on/Brown-out/Watchdog Reset
       rjmp exit   ;  2 | 0x001 | INT0         | External Interrupt Request 0
       rjmp int1_h ;  3 | 0x002 | INT1         | External Interrupt Request 1
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
str:
       .db "Hello world!",0x0D,0x0A,0x00,0x00 ; \r\n\0\0
reset: 
       init_stack RAMEND_T88
setz:  ; init str       
       ldi ZH, 0x00
       ldi ZL, LOW(2*str)
       ; set D0 - output
       set_ddr  DDRD,  (1<<PIND0)
       ; set D0 - ON (1)
       set_pins PORTD, (1<<PIND0)
       ; setup timer
       set_timer0_us 26 ; 38400 baud
       ; setup int1
       ldi r16,0x8
       sts EICRA,r16
       ldi r16,0x2
       sts (EIMSK + 0x20),r16
       clr r16
       sei
loop: 
       sleep
       rjmp loop
compa:
      cpi  r16, 0x00
      breq startbit 
      cpi  r16, 0x09
      breq stopbit
      ; set current bit
      clr  r18
      add  r18,   r17
      andi r18,   0x1
      cpi  r18,   0
      breq clrbit   
      set_pins PORTD, (1<<PIND0)
      rjmp nextbit
clrbit:
      clr_pins PORTD, (1<<PIND0)
nextbit:
      ; next bit
      lsr  r17
      inc  r16
      rjmp exit
stopbit:
      ; set stop bit
      set_pins PORTD, (1<<PIND0)
      clr r16
      rjmp exit
startbit:
      ; set start bit
      clr_pins PORTD, (1<<PIND0)
      ; first bit
      inc  r16
      ; next symbol
      lpm  r17, Z+
      ; test end ofstring
      cpi  r17, 0x00
      brne exit
      ; init str again 
      ldi  ZL, LOW(2*str)
exit: 
      reti
int1_h:
       cli
       ldi r16,0x00
       out TCCR0B,r16
       sts EIFR,r16
       rjmp exit
