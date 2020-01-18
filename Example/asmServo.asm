;
;  Move a servo motor to three different positions: 
;     -neutral
;	  -90 degrees clockwise of the "neutral" position
;	  -90 degrees counter-clockwise of the "neutral" position
;
;  Hardware Notes:
;   PIC16F684 running at 4 MHz
;	servo controlled by RC5

; Kevin Tu
; 2020-01-17
;------------------------------------------------------------------------------------------------------
; Setup
	LIST R=DEC							
	INCLUDE "p16f684.inc" 
	INCLUDE "asmDelay.inc"

 __CONFIG _FCMEN_OFF &amp; _IESO_OFF &amp; _BOD_OFF &amp; _CPD_OFF &amp; _CP_OFF &amp; _MCLRE_ON &amp; _PWRTE_ON &amp; _WDT_OFF &amp; _INTOSCIO

;  Variables
	CBLOCK 0x020 
	cycle1
	cycle2
	cycle3
	ENDC 

;-----------------------------------------------------------------------------------------------------
 PAGE
;  Configuring SFRs (Special Function Register) 

 	org    0	
	
 	movlw   7               ; turn off Comparators
  	movwf   CMCON0

  	bsf     STATUS, RP0		; switch to Bank 1
 	clrf    ANSEL ^ 0x080   ; make all PORTS digital      	

	clrf	TRISC ^ 0X080	; teach all of PORT C to be outputs
	bcf	    STATUS, RP0	    ; return to Bank 0

;-----------------------------------------------------------------------------------------------------
 PAGE
; Code Body

initialize:			;generate a square wave, with a 23ms period 
	movlw 65		;repeat moving the servo
	movwf cycle1	;first initialize counting registers
	movwf cycle2
	movwf cycle3

neutral: 			;position servo at neutral position, 
 	bsf PORTC,5		;requires a 1.5ms duty cycle
	Dlay 1500
	bcf PORTC,5
	Dlay 21500
	decfsz cycle1, f
	goto neutral
	
ninety_plus: 		;position servo at 90 degrees clockwise
	bsf PORTC,5		;of the neutral position,
	Dlay 650		;requires a .65ms duty cycle
	bcf PORTC,5
	Dlay 22350
	decfsz cycle2, f
	goto ninety_plus 		

ninety_minus: 		;position servo at 90 degree counter-clockwise
	bsf PORTC,5		;of the neutral position,
	Dlay 2250		;requires a 2.25ms duty cycle
	bcf PORTC,5
	Dlay 20750
	decfsz cycle3, f
	goto ninety_minus 		
	goto initialize

 end    
