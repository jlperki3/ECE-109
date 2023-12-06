;subme.asm
; This program will find the difference between 2 number between the range of 0-49
; SubMe - Josh Perkins 

;Set start address to 3000
.ORIG x3000


; Clear registers
CLR			AND R1, R1, #0
			AND R3, R3, #0
			AND R4, R4, #0
			AND R5, R5, #0
			AND R6, R6, #0


; Prompt user to input start number
P1			LEA R0, Prompt1
			PUTS
IN1A		GETC
			OUT						;Echo character in R0 to console


; Check for input of "q"
			LD R2, NEGq
			ADD R1, R0, R2
			BRz ENDJUMP


; Check range between 0-9
			LD R2, NEG0
			ADD R1, R0, R2			;Checks for ASCII values <0
			BRn IN1A				;If the input ASCII val is <0 then script retrieves new input

			LD R2, NEG9
			ADD R1, R0, R2			;Checks for ASCII values >9
			BRp IN1A				;If the input ASCII valus is >9 then the script retrieves an new input
			ADD R5, R0, R5


; Get second digit
IN1B		GETC
			OUT


; Check for input of "q"
			LD R2, NEGq
			ADD R1, R0, R2
			BRz ENDJUMP


; Check for line feed (ENTER)
			LD R2, NEGLF
			ADD R1, R0, R2
			BRz LFBRANCH1


; Check range between 0-9
			LD R2, NEG0
			ADD R1, R0, R2			;Checks for ASCII values <0
			BRn IN1B				;If the input ASCII val is <0 then script retrieves new input

			LD R2, NEG9
			ADD R1, R0, R2			;Checks for ASCII values >9
			BRp IN1B				;If the input ASCII valus is >9 then the script retrieves an new input
			ADD R6, R0, R6


; Convert from ASCII to decimal
			LD R2, NEGASCII
			ADD R5, R2, R5
			ADD R6, R2, R6


; Multiply first number by ten so that it can be added to the second number to make the full two digit number
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
			ADD R4, R4, R6			; R4 has whole two digit number in it
			ST R4, NUM1				; The first number is now stored in variable NUM1
			BRnzp RANGE1


LFBRANCH1	LD R2, NEGASCII
			ADD R5, R5, R2
			ST R5, NUM1	
			BRnzp RANGE1


; Check range (0-49) which is stored in NUM1
RANGE1		
			LD R2, NUM1
			LD R3, MIN
			ADD R4, R2, R3
			BRn INVALID1

			LD R3, MAX
			ADD R4, R2, R3
			BRp INVALID1
			BRnz P2
			


; If NUM1 is out of range "Invalid Entry" will be printed to screen
INVALID1
			LEA R0, Prompt5
			PUTS
			BRnzp CLR


Prompt1		.STRINGZ "\nEnter Start Number(0-49): "
Prompt2		.STRINGZ "\nEnter End Number(0-49): "
Prompt3		.STRINGZ "\nThank You For Playing!"
Prompt4		.STRINGZ "\nThe difference of the two numbers is: "
Prompt5		.STRINGZ "\nInvalid Entry"
NEGq		.FILL #-113
NEG0		.FILL #-48
NEG9		.FILL #-57
NEGLF		.FILL #-10
NEGASCII	.FILL #-48
PLUSASCII	.FILL #48
MIN			.FILL #0
MAX			.FILL #-49
NUM1		.FILL x0000
NUM2		.FILL x0000
DIFFERENCE 	.FIll #0
DASH		.FILL #45
FLIPDIFF	.FILL #0

ENDJUMP		BRnzp END 
CLRJUMP		BRnzp CLR
; Second number input
P2			LEA R0, Prompt2
			PUTS
			AND R5, R5, #0 			;;;;;;;;;;;;;; clear
			AND R6, R6, #0 			;;;;;;;;;;;;;; clear
IN2A		GETC
			OUT


; Check for input of "q"
			LD R2, NEGq
			ADD R1, R0, R2
			BRz END


; Check range between 0-9
			LD R2, NEG0
			ADD R1, R0, R2 			;Checks for ASCII values <0
			BRn IN2A				;If the input ASCII val is <0 then script retrieves new input

			LD R2, NEG9
			ADD R1, R0, R2			;Checks for ASCII values <0
			BRp IN2A				;If the input ASCII val is <0 then script retrieves new input
			ADD R5, R0, R5			;;;;;;;;;;;;;;;;; #0


; Get second digit
IN2B		GETC
			OUT


; Check for input of "q"
			LD R2, NEGq
			ADD R1, R0, R2
			BRz END


; Check for line feed (ENTER)
			LD R2, NEGLF
			ADD R1, R0, R2
			BRz LFBRANCH2


; Check range between 0-9
			LD R2, NEG0
			ADD R1, R0, R2 			;Checks for ASCII values <0
			BRn IN2B				;If the input ASCII val is <0 then script retrieves new input

			LD R2, NEG9
			ADD R1, R0, R2			;Checks for ASCII values <0
			BRp IN2B				;If the input ASCII val is <0 then script retrieves new input
			ADD R6, R0, R6			;;;;;;;;;;;;;;;;;#0


; Convert from ASCII to decimal
			LD R2, NEGASCII
			ADD R5, R2, R5
			ADD R6, R2, R6


 ;Multiply first number by ten so that it can be added to the second number to make the full two digit number
 			AND R4, R4, #0 			; Clear R4

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
			ADD R4, R4, R6			; R4 has whole two digit number in it
			ST R4, NUM2				; The second number is now stored in variable NUM2
			BRnzp RANGE2


LFBRANCH2	LD R2, NEGASCII
			ADD R5, R5, R2
			ST R5, NUM2	
			BRnzp RANGE2


; Check range (0-49) which is stored in NUM2
RANGE2		
			LD R2, NUM2
			LD R3, MIN
			ADD R4, R2, R3
			BRn INVALID2

			LD R3, MAX
			ADD R4, R2, R3
			BRp INVALID2 			; If NUM2 is out of range "Invalid Entry" will be printed to screen
			BRnz SUBTRACT

INVALID2
			LEA R0, Prompt5
			PUTS
			BRnzp P2 
			
; Make NUM2 negative NUM1 to get a subtraction
SUBTRACT	NOT R2, R2 
			ADD R2, R2, #1
			

; Add NUM1 neg NUM2 to get a subtraction
			AND R3, R3, #0 			; Clear 
			LD R1, NUM1
			ADD R3, R1, R2
			ST R3, DIFFERENCE
			BRzp DISPLAYP
			BRn DISPLAYN

			; Separate 10s and 1s

DISPLAYP	LD R5, DIFFERENCE
			AND R6, R6, #0			; Clear

DIV10P		ADD R6, R6, #1 
			ADD R5, R5, #-10
			BRzp DIV10P

			ADD R6, R6, #-1			; Tens
			ADD R5, R5, #10 		; Ones

			; Display tens positive
			LEA R0, Prompt4
			PUTS
			ADD R0, R6, R6
			BRz ONESP
			LD R2, PLUSASCII
			ADD R0, R2, R6
			OUT


; Display ones positive
ONESP		LD R2, PLUSASCII
			ADD R0, R2, R5
			OUT
			BRnzp TOP


DISPLAYN	; Display Negatives
			; Print "-" for negatives
			LEA R0, Prompt4			; Print difference prompt
			PUTS

			LD R0, DASH
			OUT						; Print negative symbol
			ADD R0, R3, R2 			; Check for negative again then send line to 2s complement negative code
			BRn FLIPNEG
			

FLIPNEG	
			NOT R3, R3 
			ADD R3, R3, #1
			ST R3, FLIPDIFF
			

	; Separate 10s and 1s

			LD R5, FLIPDIFF
			AND R6, R6, #0			; Clear


DIV10N		ADD R6, R6, #1 
			ADD R5, R5, #-10
			BRzp DIV10N

			ADD R6, R6, #-1			; Tens
			ADD R5, R5, #10 		; Ones


; Display tens negative
			ADD R0, R6, R6
			BRz ONESN
			LD R2, PLUSASCII
			ADD R0, R2, R6
			OUT


; Display ones negative
ONESN		LD R2, PLUSASCII
			ADD R0, R2, R5
			OUT
			BRnzp TOP

TOP			LEA R0, CLRJUMP
			JMP R0



END			LEA R0, Prompt3
			PUTS
			HALT



