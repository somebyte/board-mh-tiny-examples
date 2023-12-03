.macro ddr_setup
	sub  r16,r16
	in   r16,@0
	ori  r16,@1
	out  @0,r16
.endmacro

.macro ddr_setup_safely
	push r16
	ddr_setup @0,@1
	pop r16
.endmacro

.macro port_setup
	sub r16,r16
	in  r16,@0
	ori r16,@1
	out @0,r16
.endmacro

.macro port_setup_safely
	push r16
	port_setup @0,@1
	pop r16
.endmacro

.macro port_clear
	sub  r16,r16
	in   r16,@0
	andi r16,~@1
	out  @0,r16
.endmacro

.macro port_clear_safely
	push r16
	port_clear @0,@1
	pop r16
.endmacro

.macro port_invertion
	sub r16,r16
	in  r16,@0
	ldi r17,@1
	eor r16,r17
	out @0,r16
.endmacro

.macro port_invertion_safely
	push r16
	push r17
	port_invertion @0,@1
	pop r17
	pop r16
.endmacro
