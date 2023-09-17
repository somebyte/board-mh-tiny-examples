.include "m88def.inc"
.set RAMEND_T88 = 0x02FF  ; Tiny88 has a different SRAM size than Atmega88
                          ; see RAMEND in /usr/share/m88def.inc

.macro stack_setup
	ldi r16,LOW(@0)
	out SPL,r16
	ldi r16,HIGH(@0)
	out SPH,r16
.endmacro

.macro stack_setup_safely
	push r16
	stack_setup @0
	pop r16
.endmacro
