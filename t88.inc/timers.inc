.macro timer0A_start
	lds r16,TIMSK0
	ori r16,0x02   ; Bit 1 – OCIE0A: Timer/Counter0 Output Compare Match A Interrupt Enable
	sts TIMSK0,r16 ; Timer/Counter Interrupt Mask Register
.endmacro

.macro timer0A_start_safely
	push r16
	timer0A_start
	pop r16
.endmacro


.macro timer0A_stop
	lds  r16,TIMSK0
	andi r16,0xFD   ; Bit 1 – OCIE0A: Timer/Counter0 Output Compare Match A Interrupt Enable
	sts  TIMSK0,r16 ; Timer/Counter Interrupt Mask Register
.endmacro

.macro timer0A_stop_safely
	push r16
	timer0A_stop
	pop r16
.endmacro

.macro  timer0A_setup_us
	lds  r16,TIMSK0
	andi r16,0xFD
	sts  TIMSK0,r16
	ldi r16,(@0<<1)
	out OCR0A,r16  ; Output Compare Register A
	ldi r16,0x0A   ; Bit 3 – CTC0: Clear Timer on Compare Match Mode; Bit 2:0 - Clock select - clkIO/8
	out TCCR0B,r16 ; TCCR0A(Tiny88) = TCCR0B(Atmega88) = 0x25 - Timer/Counter Control Register A
	clr r16        ; Clear
	out TCNT0,r16  ; Timer/Counter Register
.endmacro

.macro timer0A_setup_us_safely
	push r16
	timer0A_setup_us @0
	pop r16
.endmacro
