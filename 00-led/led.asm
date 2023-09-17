.include "../t88.inc/sys.inc"
.include "../t88.inc/port.inc"

.cseg
.org 0x00
; setup data direction
	ddr_setup   DDRD,  (1<<PIND0)
; setup led on, PD0 is 1
	port_setup  PORTD, (1<<PIND0)
loop: rjmp loop

