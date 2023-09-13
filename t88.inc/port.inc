.macro set_ddr
      push r16  
      sub  r16,r16
      in   r16,@0
      ori  r16,@1
      out  DDRD,r16
      pop  r16
.endmacro

.macro set_pins
      push r16  
      sub r16,r16
      in  r16,@0
      ori r16,@1
      out PORTD,r16
      pop  r16
.endmacro

.macro clr_pins
      push r16  
      sub  r16,r16
      in   r16,@0
      andi r16,~@1
      out  PORTD,r16
      pop  r16
.endmacro

.macro inv_pins
      push r16
      push r17 
      sub r16,r16
      in  r16,@0
      ldi r17,@1
      eor r16,r17
      out PORTD,r16
      pop  r17
      pop  r16
.endmacro
