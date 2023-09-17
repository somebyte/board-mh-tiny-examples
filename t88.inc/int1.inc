.macro int1_enable
	intx_enable 0x2
.endmacro

.macro int1_enable_safely
	push r16
	int1_enable
	pop r16
.endmacro

.macro int1_disable
	intx_disable 0x1
.endmacro

.macro int1_disable_safely
	push r16
	int0_disable
	pop  r16
.endmacro

.macro int1_setup
	_intx_setup (@0<<2),0x3
.endmacro

.macro int1_setup_safely
	push r16
	int1_setup (@0<<2)
	pop r16
.endmacro