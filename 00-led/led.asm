.include "../t88.inc/macros.inc"

.cseg
.org 0x00
      init_stack RAMEND_T88

; setup data direction
      setDDRD (1<<PIND0)

; setup led on, PD0 is 1
      setPORTD (1<<PIND0)

loop: rjmp loop

