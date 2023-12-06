; mines.asm
; Josh Perkins 
; Submitted 4/18/2022
; This program is a mine sweeper game
; When the user enters an x(0-15) and y(0-14) coordinate the program will display a red box for hit and a white box for miss at that location
; Input q shows all missed mines in blue

; Set Origin
			.ORIG x3000


; Clear registers
CLR			AND R0, R0, #0
			AND R1, R1, #0
			AND R2, R2, #0
			AND R3, R3, #0
			AND R4, R4, #0
			AND R5, R5, #0
			AND R6, R6, #0


; Clear screen
			LD R2, DOWN
			LD R0, BLACK
			LD R5, TOPLEFT
			LD R3, ALLPIX

LOOP1		STR R0, R5, #0 
			ADD R5, R5, #1
			ADD R3, R3, #-1
			BRzp LOOP1

START		BRnzp TENSX

			; Subroutine to get 1st input digits			
INPUT1 		ST R7, SVR7
INPUT1A		GETC
			OUT

; Check for input of "q"
			LD R2, NEGq
			ADD R1, R0, R2
			BRz ENDJUMP

; Check range between 0-9
			LD R2, NEG0
			ADD R1, R0, R2			;Checks for ASCII values <0
			BRn INPUT1A				;If the input ASCII val is <0 then script retrieves new input

			LD R2, NEG9
			ADD R1, R0, R2			;Checks for ASCII values >9
			BRp INPUT1A				;If the input ASCII valus is >9 then the script retrieves an new input

			LD R7, SVR7
			RET

			; Subroutine to get 2nd input digits
INPUT2 		ST R7, SVR7
INPUT2A		GETC
			OUT

; Check for input of "q"
			LD R2, NEGq
			ADD R1, R0, R2
			BRz ENDJUMP

; Check for line feed (ENTER)
			LD R2, NEGLF
			ADD R1, R0, R2
			BRz LFBRANCH

; Check range between 0-9
			LD R2, NEG0
			ADD R1, R0, R2			;Checks for ASCII values <0
			BRn INPUT2A				;If the input ASCII val is <0 then script retrieves new input

			LD R2, NEG9
			ADD R1, R0, R2			;Checks for ASCII values >9
			BRp INPUT2A				;If the input ASCII valus is >9 then the script retrieves an new input
			BRnzp BACK


LFBRANCH	
BACK		LD R7, SVR7
			RET


			; Subroutine to combine tens and ones place
; Convert from ASCII to decimal
COMBINE		ST R7, SVR7
			LD R2, NEGASCII
			ADD R5, R2, R5
			ADD R6, R2, R6

;Multiply first number by ten so that it can be added to the second number to make the full two digit number
			AND R4, R4, #0			; Clear R4

			ADD R4, R4, R5
			ADD R4, R4, R5
			ADD R4, R4, R5
			ADD R4, R4, R5
			ADD R4, R4, R5
			ADD R4, R4, R5
			ADD R4, R4, R5
			ADD R4, R4, R5
			ADD R4, R4, R5
			ADD R4, R4, R5

; Do (10xR5)+R6 to make the two digit number
			ADD R5, R4, R6			; R4 has whole two digit number in it

			LD R7, SVR7
			RET


			; Subroutine to check range of final X/Y coordinates
RANGE		ST R7, SVR7
			LD R3, MIN
			ADD R4, R2, R3
			BRn INVALID

			ADD R4, R1, R2
			BRp INVALID

			LD R7, SVR7 
			RET

INVALID		LEA R0, Prompt3
			PUTS
			BRnzp START


; Get tens place x digit
TENSX		LEA R0, PROMPT1			; Request X-input
			PUTS
			JSR INPUT1
			ST R0, XNUM1


; Get ones place x digit
ONESX		JSR INPUT2
			ST R0, XNUM2
			LD R2, NEGLF
			ADD R2, R0, R2
			BRz COORDXA
			LD R5, XNUM1			;Prepare register for combine subroutine 
			LD R6, XNUM2			;Prepare register for combine subroutine 
			JSR COMBINE
			BRnzp COORDX

COORDXA		LD R5, XNUM1
			LD R2, NEGASCII
			ADD R5, R2, R5
COORDX		ST R5, WHOLEX
			LD R2, WHOLEX
			LD R1 MAXX
			JSR RANGE


; Get tens place y digit
TENSY		LEA R0, PROMPT2
			PUTS
			JSR INPUT1
			ST R0, YNUM1


; Get ones place y digit
ONESY		JSR INPUT2
			ST R0, YNUM2
			LD R2, NEGLF
			ADD R2, R0, R2
			BRz COORDYA
			LD R5, YNUM1			;Prepare register for combine subroutine 
			LD R6, YNUM2			;Prepare register for combine subroutine 
			JSR COMBINE
			BRnzp COORDY

COORDYA		LD R5, YNUM1
			LD R2, NEGASCII
			ADD R5, R2, R5
COORDY		ST R5, WHOLEY
			LD R2, WHOLEY
			LD R1 MAXY
			JSR RANGE


; Get the bitmap value that corrisponds to input Y-coordinate 
			LD R2, WHOLEY			;Find which row is being checked
			LD R1, 0Y 
			ADD R2, R1, R2
			LDR R2, R2, #0 			;R2 now has the bit map row at the input y value

; Find the value in the column that corrisponds to input X-coordinate
			LD R1, 0X 				;LD R1 with equivalent of X=0
			LD R3, DIV2
			LD R4, WHOLEX
			BRz MASK
			AND R0, R0, #0
DIVLOOPA	JSR DIVLOOP

			ST R0, DIVX
			AND R0, R0, #0
			LD R1, DIVX
			ADD R4, R4, #-1
			BRz MASK

			BRnp DIVLOOPA

			;Subroutine to divide X value by two
DIVLOOP		ST R7, SVR7
			ADD R0, R0, #1
			ADD R1, R1, R3
			BRp DIVLOOP
			RET


; Variables 
PROMPT1			.STRINGZ "\n\n\nEnter X (0-15): "
PROMPT2 		.STRINGZ "\n\n\nEnter Y (0-14): "
PROMPT3			.STRINGZ "\n\nBogus"
PROMPT4			.STRINGZ "\n\nHIT"
PROMPT5			.STRINGZ "\n\nMISS"
PROMPT6 		.STRINGZ "\n\nThank you for Playing!"
NEGASCII		.FILL #-48
XNUM1			.FILL xA000
XNUM2 			.FILL xA001
YNUM1			.FILL xA004
YNUM2			.FILL xA005 
WHOLEX			.FILL xA002
WHOLEY			.FILL xA003 
SVR7			.FILL xA006
SVR7A			.FILL xA00E
DIVX			.FILL xA007
MIN				.FILL #0
MAXX			.FILL #-15
MAXY			.FILL #-14
NEGq			.FILL #-113
NEGLF			.FILL #-10
NEG0			.FILL #-48
NEG9			.FILL #-57
DOWN			.FILL #128
BIGDOWN			.FILL #1024
BLACK			.FILL x0000
RED				.FILL x7C00
WHITE			.FILL x7FFF
BLUE 			.FILL x001F
TOPLEFT			.FILL xC000
ALLPIX			.FILL #15871 
DIV2			.FILL #-2
0Y				.FILL x5000
0X 				.FILL x8000
XCOORD 			.FILL xA008
YCOORD			.FILL xA009
XYCOORD			.FILL xA00A
LOCATION		.FILL xA00B
NEXTY 			.FILL xA00C
NEXTX			.FILL xA010
ENDY 			.FILL xA00D
ENDX			.FILL xA00F

ENDJUMP		BRnzp END



; AND the X and Y coordinate together to determine HIT or MISS
MASK 		AND R3, R1, R2
			BRnp HIT 
			BRz MISS


			;Sub routine to get XY coordinate into hex
CONVERT		ST R7, SVR7
CONVERTEND	LD R1, TOPLEFT			;xC000 + 8(x) + 128(y)
			
; Multiply X by 8
			AND R3, R3, #0
			AND R4, R4, #0
			ADD R0, R5, R2
			BRz MULTXA
			ADD R3, R3, #8
MULTX		ADD R4, R4, R2
			ADD R3, R3, #-1
			BRp MULTX
MULTXA		ST R4, XCOORD			;XCOORD now has input 8(x) 

; Multiply 8Y by 128
			AND R3, R3, #0
			AND R4, R4, #0
			ADD R0, R5, R2
			BRz MULTYA
			LD R3, BIGDOWN
MULTY		ADD R4, R4, R5
			ADD R3, R3, #-1
			BRp MULTY 
MULTYA		ST R4, YCOORD			;YCOORD now has input 128(8y)

; GET final coordinate address value
			LD R3, YCOORD
			LD R2, XCOORD
			ADD R1, R1, R2
			ADD R1, R1, R3			;R1 now has final coord address value
			ST R1, XYCOORD			

			LD R7, SVR7
			RET


; Change color for HIT
HIT 		LEA R0, PROMPT4
			PUTS
			LD R6, RED
			LD R2, WHOLEX
			LD R5, WHOLEY
			JSR CONVERT
			JSR MKBLOCK
			JSR START


; Change color for MISS
MISS 		LEA R0, PROMPT5
			PUTS
			LD R6, WHITE
			LD R2, WHOLEX
			LD R5, WHOLEY
			JSR CONVERT
			JSR MKBLOCK
			JSR START

			; Subroutine to print square at correct coordinate
MKBLOCK		ST R7, SVR7
			AND R3, R3, #0
			ADD R3, R3, #8
			LD R4, DOWN
			LD R1, XYCOORD
PRINT		STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			STR R6, R1, #4
			STR R6, R1, #5
			STR R6, R1, #6
			STR R6, R1, #7
			ADD R1, R1, R4
			ADD R3, R3, #-1
			BRp PRINT

			LD R7, SVR7
			RET


			; Subroutine to print blue boxes
BLUEBOX		ST R7, SVR7A			;Saves R7 for return purposes
			LD R7, SVR7A
			ST R7, SVR7
			LD R1, NEXTX			;;;;;;;;;;;;;
			AND R0, R1, R5			;Mask to check for hit
			BRz BLUEBOXA			;If no HIT then go to BLUEBOXA(middle ENDLOOP)
			LD R6, BLUE 			;IF HIT LD R6 with blue to get ready for print sub

			LD R2, ENDX
			LD R5, ENDY
			ST R1, NEXTX
			JSR CONVERT
			JSR MKBLOCK
			LD R7, SVR7A

			RET
;			BRnzp CONVERTEND		;XYCOORD has graphics address value

			



BLUEBOXA	LD R7, SVR7
			RET

END 		LEA R0, PROMPT6
			PUTS
			LD R1, 0X				;R1 x8000
			LD R2, 0Y				;R2 x5000
			LD R3, DIV2				;R3 #-2
			AND R4, R4, #0 			;Clear R4
			ST R4, ENDY
			ST R4, ENDX				;testing
			ST R2, NEXTY
			ST R1, NEXTX
			BRnzp ENDLOOP1
;			ADD R4, R4, #15 		;Load R4 with 15 as a Y row counter

ENDLOOP		LD R2, NEXTY
ENDLOOP1	LDR R5, R2, #0 			;R5 holds binary of row Y

;			LD R2, 0Y
			JSR BLUEBOX 			;Jumps to BLUEBOX subroutine
			LD R2, NEXTY			;Restores current Y value in R2
			ADD R2, R2, #1         	;Moves Y row down by one
			ST R2, NEXTY			;Establishes new Y value in R2
			LD R4, ENDY				;testing
			ADD R4, R4, #1 			;testing
			ST R4, ENDY				;testing
			ADD R4, R4, #-15        ;testing
			BRn ENDLOOP				;If positive it repeats ENDLOOP checks all y value in colX

									;If not positive the x value moves up(right)1
			LD R3, DIV2
			AND R0, R0, #0
			LD R1, NEXTX
			JSR DIVLOOP 			;Jumps to divider loop to move x+1
			LD R4, ENDX
;			ST R0, 0Y
			ST R0, NEXTX			;Stores the new x mask value in location
			AND R0, R0, #0 			;Clears R0
			ADD R4, R4, #1
			ST R4, ENDX
			LD R3, NEXTY
			ADD R3, R3, #-15
			ST R3, NEXTY
			LD R3, ENDY
			ADD R3, R3, #-15
			ST R3, ENDY
			LD R1, 0X				;R1 x8000
			LD R2, 0Y				;R2 x5000
			ADD R4, R4, #-16
			BRn ENDLOOP1			;If x<15 ENDLOOP cycle starts again

			HALT


