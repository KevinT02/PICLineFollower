;
; A program which moves a robot in a predictable pattern
; of forwards, backwards, left, and right, repeatedly.
;
;  Hardware Notes:
;   PIC16F684 running at 4 MHz
;	2 DC motors of 143:1 used, through a LM293D IC Driver
;   The left motor is controlled by RC0 and RC1
;   The right motor is controlled by RC2 and RC3
;
;   Directions:
;  	to go forward:		PORTC&lt;3:0&gt;=1010=10
;	to go backwards:	PORTC&lt;3:0&gt;=0101=5
;	to spin left:		PORTC&lt;3:0&gt;=1001=9
;	to spin right:		PORTC&lt;3:0&gt;=0110=6

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
	 	
repeat:		; endlessly repeat moving forward, 
			; backward, spin right, spin left

    movlw 10		; move forward for 4 seconds
	movwf PORTC			
	Dlay 5000000
		
	movlw 9			; spin left for 2 seconds
	movwf PORTC
	Dlay 2250000
	
	movlw 5			; move backwards for 4 seconds
	movwf PORTC
	Dlay 4500000
			
	movlw 6			; spin right for 2 seconds
	movwf PORTC
	Dlay 3750000

	clrf PORTC			; stop for half second
	Dlay 2000000
	
 	goto repeat

  end  	                         
