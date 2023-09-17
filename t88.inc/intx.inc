
.macro intx_enable
	lds  r16,(EIMSK + 0x20)
	ori  r16,@0
	sts  (EIMSK + 0x20),r16
.endmacro

.macro intx_enable_safely
	push r16
	intx_enable @0
	pop r16
.endmacro

.macro intx_disable
	lds  r16,(EIMSK + 0x20)
	andi  r16,@0
	sts  (EIMSK + 0x20),r16
.endmacro

.macro intx_disable_safely
	push r16
	intx_disable @0
	pop r16
.endmacro

.macro _intx_setup
	lds  r16,EICRA
	andi r16,@1
	ori  r16,@0
	sts  EICRA,r16
.endmacro

.macro _intx_setup_safely
	push r16
	_intx_setup @0,@1
	pop r16
.endmacro

.macro _intx_clrflag
	lds  r16,EIFR
	ori r16,@0
	sts  EIFR,r16
.endmacro

.macro _intx_clrflag_safely
	push r16
	_intx_clrflag @0
	pop r16
.endmacro
