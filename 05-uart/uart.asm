.include "../t88.inc/sys.inc"
.include "../t88.inc/port.inc"
.include "../t88.inc/timers.inc"
.include "../t88.inc/intx.inc"
.include "../t88.inc/int1.inc"

.cseg
.org 0x000
	; Tiny88 interrupt vectors are different from Atmega88
	rjmp reset  ;  1 | 0x000 | RESET        | RESET External/Power-on/Brown-out/Watchdog Reset
	reti        ;  2 | 0x001 | INT0         | External Interrupt Request 0
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
str:  .db "Hello world!",0x0D,0x0A,0x00,0x00 ; \r\n\0\0
reset: 
	stack_setup RAMEND_T88  
	; set D0 - output
	ddr_setup  DDRD,  (1<<PIND0)
	; set D0 - ON (1)
	port_setup PORTD, (1<<PIND0)
	; setup timer
	timer0A_setup_us 27; 38400 baud
	; setup int1
	int1_setup  0x0
	int1_enable
	sei
loop: 
	sleep
	rjmp loop
exit:
	reti
int1_h:
	int1_disable
	clr  r16
	clr  r17
	clr  r18
	clr  r19
	; init str
	ldi ZH, 0x00
	ldi ZL, LOW(2*str)
	timer0A_start
	rjmp exit
wait:
	inc  r19
	rjmp exit
compa:
	cpi  r19, 0x9
	brne wait	
	cpi  r17, 0x00 ; 0   bit is a start bit 
	breq startbit 
	cpi  r17, 0x09 ; 9th bit is a stop bit 
	breq stopbit
	; set current bit
	clr  r18
	add  r18,r16
	andi r18,0x1
	cpi  r18,0
	breq clrbit   
      	port_setup_safely PORTD, (1<<PIND0)
	rjmp nextbit
clrbit:
	port_clear_safely PORTD, (1<<PIND0)
nextbit:
	; next bit
	lsr  r16
	inc  r17
	rjmp exit
startbit:
	; next symbol
	inc  r17
	lpm  r16, Z+
	cpi  r16, 0x00
	breq tx_stop
	; set startbit
	port_clear_safely PORTD, (1<<PIND0)
	rjmp exit
stopbit:
	; set stop bit
	port_setup PORTD, (1<<PIND0)
	clr r17
	rjmp exit
tx_stop:
	timer0A_stop
	port_setup PORTD, (1<<PIND0)
	int1_enable
	rjmp exit
