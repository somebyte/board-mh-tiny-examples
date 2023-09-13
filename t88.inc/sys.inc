.include "m88def.inc"
.set RAMEND_T88 = 0x02FF  ; Tiny88 has a different SRAM size than Atmega88
                          ; see RAMEND in /usr/share/m88def.inc

.macro init_stack
      ldi r16,LOW(@0)
      out SPL,r16
      ldi r16,HIGH(@0)
      out SPH,r16
      clr r16
.endmacro





