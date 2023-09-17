.include "../t88.inc/sys.inc"
.include "../t88.inc/port.inc"

.cseg
.org 0x000
	rjmp reset  ;  1 | 0x000 | RESET        | RESET External/Power-on/Brown-out/Watchdog Reset
.org 0x00E
	rjmp overf  ; 15 | 0x00E | TIMER0_OVF   | Timer/Counter0 Overflow

	; stack is not used
reset:
	; led D0
	ddr_setup  DDRD,  (1<<PIND0)
	; led on
	port_setup PORTD, (1<<PIND0)
	;------------
	clr r16
	out TCNT0,r16
	ldi r16,0x01
	sts TIMSK0,r16
	ldi r16,0x05
	out TCCR0B,r16 ; TCCR0A(Tiny88) = TCCR0B(Atmega88) = 0x25 
	clr r16
	sei 
loop:
	sleep
	rjmp loop     
overf:
	inc r16
	cpi r16,0x3e
	brne exit
	in  r16,PORTD
	ldi r17,(1<<PIND0)
	eor r16,r17
	out PORTD,r16
	clr r16
exit: 
	sei
	rjmp loop
