.include "../t88.inc/sys.inc"
.include "../t88.inc/port.inc"

.cseg
.org 0x00
       init_stack RAMEND_T88
       ;--------------------
       set_ddr DDRD, (1<<PIND0)
       ;--------------------
       ldi r16,(1<<CS02)|(0<<CS01)|(1<<CS00) ; 0x5 - clkIO/1024 (From prescaler)
       out TCCR0B,r16 ; TCCR0A(Tiny88) = TCCR0B(Atmega88) = 0x25
       clr r16
       out TCNT0,r16
loop:
       in   r16,TCNT0
       cpi  r16,0xff       
       brne loop
       eor  r16,r16   ; clr r16
       out  TCNT0,r16 
       inc  r17
       cpi  r17,0x3e
       brne loop
       ;------------------
       inv_pins PORTD, (1<<PIND0)
       ;------------------
       eor  r17,r17   ; clr r17
       rjmp loop

