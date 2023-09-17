.macro int0_enable
	intx_enable 0x1
.endmacro

.macro int0_enable_safely
	push r16
	int0_enable
	pop r16
.endmacro

.macro int0_disable
	intx_disable 0x2
.endmacro

.macro int0_disable_safely
	push r16
	int0_disable
	pop  r16
.endmacro

.macro int0_setup
	_intx_setup @0,0xC 
.endmacro

.macro int0_setup_safely
	push r16
	int0_setup @0
	pop r16
.endmacro

