.include "../t88.inc/macros.inc"

.cseg
.org 0x00
       init_stack RAMEND_T88
; setup data direction
       setDDRD  (1<<PIND0)

; led on
       setPORTD (1<<PIND0)
loop:
       invPORTD (1<<PIND0)
       clr  r16
p1:    inc  r16
       clr  r17
p2:    inc  r17
       clr  r18
p3:    inc  r18
       cpi  r18,  0x33
       brne p3       
       cpi  r17,  0xff
       brne p2 
       cpi  r16,  0xff
       brne p1
       rjmp loop

