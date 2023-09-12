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

.macro setDDRD
      push r16  
      sub  r16,r16
      in   r16,DDRD
      ori  r16,@0
      out  DDRD,r16
      pop  r16
.endmacro

.macro setPORTD
      push r16  
      sub r16,r16
      in  r16,PORTD
      ori r16,@0
      out PORTD,r16
      pop  r16
.endmacro

.macro clrPORTD
      push r16  
      sub  r16,r16
      in   r16,PORTD
      andi r16,~@0
      out  PORTD,r16
      pop  r16
.endmacro

.macro invPORTD
      push r16
      push r17 
      sub r16,r16
      in  r16,PORTD
      ldi r17,@0
      eor r16,r17
      out PORTD,r16
      pop  r17
      pop  r16
.endmacro

.macro setTimerA_us 
      push r16
      ldi r16,(@0<<1)
      out OCR0A,r16 ; Output Compare Register A
      ldi r16,0x02   ; Bit 1 – OCIE0A: Timer/Counter0 Output Compare Match A Interrupt Enable
      sts TIMSK0,r16 ; Timer/Counter Interrupt Mask Register
      ldi r16,0x0A   ; Bit 3 – CTC0: Clear Timer on Compare Match Mode; Bit 2:0 - Clock select - clkIO/8
      out TCCR0B,r16 ; TCCR0A(Tiny88) = TCCR0B(Atmega88) = 0x25 - Timer/Counter Control Register A 
      clr r16        ; Clear
      out TCNT0,r16  ; Timer/Counter Register
      pop r16
.endmacro

