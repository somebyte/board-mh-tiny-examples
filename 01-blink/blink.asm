.include "../t88.inc/sys.inc"
.include "../t88.inc/port.inc"

.cseg
.org 0x00
; setup data direction
	ddr_setup  DDRD,  (1<<PIND0)
; led on
	port_setup PORTD, (1<<PIND0)
loop:
	port_invertion PORTD, (1<<PIND0)
	clr  r16
p1:
	inc  r16
	clr  r17
p2:
	inc  r17
	clr  r18
p3:
	inc  r18
	cpi  r18,  0x33
	brne p3
	cpi  r17,  0xff
	brne p2
	cpi  r16,  0xff
	brne p1
	rjmp loop

