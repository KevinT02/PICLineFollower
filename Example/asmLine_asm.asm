;------------------------------------------------------------------------------------------------------
; Setup
	LIST R=DEC							
	INCLUDE "p16f684.inc" 
	INCLUDE "asmDelay.inc"

 __CONFIG _FCMEN_OFF &amp; _IESO_OFF &amp; _BOD_OFF &amp; _CPD_OFF &amp; _CP_OFF &amp; _MCLRE_ON &amp; _PWRTE_ON &amp; _WDT_OFF &amp; _INTOSCIO

;  Variables
	CBLOCK 0x020 
		 
	ENDC 

;--------------------------------------------------------------------------
  PAGE
;  Configuring SFRs (Special Function Register)

	org    0
	
	movlw   7                   ; turn off Comparators
  	movwf   CMCON0

  	bsf     STATUS, RP0			; all PORTS are Digital
 	clrf    ANSEL ^ 0X080        	

	clrf	TRISC ^ 0X080		; teach all of PORT C to be outputs

	movlw 	b'111000'			; teach RA4, RA5 to be digital inputs
	movwf	TRISA^0X080			; and the rest as outputs
	bcf	    STATUS, RP0	 		; (RA3 must always be an input)

;-----------------------------------------------------------------------------------------------------
 PAGE
; Code Body
	 	
loop:
    movlw  10			;Move forward 
	movwf PORTC			;until hits black line, move accordingly
	Dlay 100000
	nop
		
		clrf PORTC		;stop momentarily to get a
		Dlay 30000		;more accurate reading from sensors
		
	btfss PORTA, 5		;if left sensor hits black line, 
		call turn_left	;turn left

	btfss PORTA, 4		;if right sensor hits black line,
		call turn_right	;turn right
	
 	goto loop

; -------------------------------------------------------------------------------------------------------------------------------
; subroutines
	
turn_left:				;turn robot left
	movlw 9
	movwf PORTC
	nop
	Dlay 60000
		clrf PORTC
		Dlay 30000
	return				;return back to main program loop

turn_right:	;turn robot right	
	movlw 6
	movwf PORTC
	nop
	Dlay 60000
		clrf PORTC
		Dlay 30000
	return				;return back to main program loop

  end                           
