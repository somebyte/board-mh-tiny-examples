.include "../t88.inc/sys.inc"
.include "../t88.inc/port.inc"

.cseg
.org 0x00
      init_stack RAMEND_T88
; setup data direction
      set_ddr   DDRD,  (1<<PIND0)
; setup led on, PD0 is 1
      set_pins  PORTD, (1<<PIND0)

loop: rjmp loop

