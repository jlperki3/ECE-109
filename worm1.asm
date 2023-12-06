;;;;; 
; Josh Perkins 

			.ORIG x3000
; Clear registers
START		AND R0, R0, #0
			AND R1, R1, #0
			AND R2, R2, #0
			AND R3, R3, #0
			AND R4, R4, #0
			AND R5, R5, #0
			AND R6, R6, #0


; Clear graphic
			LD R2, DOWN
			LD R0, BLACK
			LD R5, TOPLEFT
			LD R3, ALLPIX

LOOP1		STR R0, R5, #0 
			ADD R5, R5, #1
			ADD R3, R3, #-1
			BRzp LOOP1

; Set start location 
			LD R6, WHITE
			LD R1, START1
			LD R2, DOWN
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0 
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0 
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0 
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2


; Check for q
WAIT		GETC
			LD R3, NEGQ
			ADD R4, R0, R3
			BRz ENDJUMP


; Check for "ENTER" (Linefeed)
			LD R3, NEGLF
			AND R4, R4, #0 				; Clear
			ADD R4, R0, R3
			BRz CLEARPIX
			 

; Check for move direction command
MOVE		LD R3, NEGW
			AND R4, R4, #0 	
			ADD R4, R0, R3
			BRz MOVEUP

			LD R3, NEGA
			AND R4, R4, #0 	
			ADD R4, R0, R3
			BRz MOVELEFT

			LD R3, NEGS
			AND R4, R4, #0 	
			ADD R4, R0, R3
			BRz MOVEDOWN

			LD R3, NEGD
			AND R4, R4, #0 	
			ADD R4, R0, R3
			BRz MOVERIGHT
			BRnzp COLOR

; Move up
MOVEUP		AND R4, R4, #0
			LD R2, TOPLEFT
			LD R3, UP 
			ADD R3, R3, R3
			ADD R3, R3, R3
			ADD R3, R3, R3
			NOT R2, R2
			ADD R2, R2, #1
			ADD R4, R1, R3
			ADD R2, R2, R4
			BRn LOOPCOLOR					; needs to go to color loop

			LD R2, BIGUP 
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			LD R2, DOWN
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			BRnzp WAIT

MOVELEFT	LD R2, TOPLEFT
			NOT R2, R2
			ADD R2, R2, #1
			LD R4, BOTLEFT
			NOT R5, R4 
			ADD R5, R5, #1
			LD R3, UP 
BOUNDL		AND R0, R0, #0
			ADD R0, R1, R5				; check for r1 on edge
			BRz LOOPCOLOR				; if yes go to color loop
			AND R0, R0, #0 				; if no clear r0
			ADD R4, R3, R4				; move check pixle up one row
			NOT R5, R4			
			ADD R5, R5, #1	
			ADD R0, R2, R4				; check if new pixle is equal to stop location
			BRp BOUNDL					; if no start r1 check loop again

			LD R2, LEFT
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			LD R2, DOWN
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			BRnzp WAIT

MOVEDOWN	AND R4, R4, #0
			LD R2, BOTRIGHT
			NOT R2, R2
			ADD R2, R2, #1
			ADD R4, R1, #1
			ADD R2, R2, R4
			BRp LOOPCOLOR

			LD R2, DOWN
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			BRnzp WAIT

MOVERIGHT 	LD R2, TOPLEFT
			NOT R2, R2
			ADD R2, R2, #1
			LD R4, BOTRIGHT2
			NOT R5, R4 
			ADD R5, R5, #1
			LD R3, UP 
BOUNDR		AND R0, R0, #0
			ADD R0, R1, R5				; check for r1 on edge
			BRz LOOPCOLOR				; if yes go to color loop
			AND R0, R0, #0 				; if no clear r0
			ADD R4, R3, R4				; move check pixle up one row
			NOT R5, R4			
			ADD R5, R5, #1	
			ADD R0, R2, R4				; check if new pixle is equal to stop location
			BRp BOUNDR					; if no start r1 check loop again

			LD R2, RIGHT 
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			LD R2, DOWN
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			BRnzp WAIT


; Values
RED			.FILL x7C00
GREEN		.FILL x03E0
BLUE		.FILL x001F
YELLOW		.FILL x7FED
WHITE		.FILL x7FFF
BLACK		.FILL x0000
START1		.FILL xE440
START2		.FILL xE4C0
DOWN		.FILL #128
UP 			.FILL #-128
BIGUP		.FILL #-1024
LEFT		.FILL #-516
RIGHT 		.FILL #-508
NEGQ		.FILL #-113
NEGR		.FILL #-114
NEGG		.FILL #-103
NEGB		.FILL #-98
NEGY		.FILL #-121
NEGSPACE	.FILL #-32
NEGLF		.FILL #-10
NEGW		.FILL #-119
NEGA 		.FILL #-97
NEGS 		.FILL #-115
NEGD		.FILL #-100
ALLPIX		.FILL #15871 
TOPLEFT		.FILL xC000
BOTRIGHT	.FILL xFDFF
BOTRIGHT2   .FILL xFE7C
BOTLEFT		.FILL xFE00
CURRCOORD 	.FILL #0
ENDJUMP		BRnzp END 
WAITJUMP 	BRnzp WAIT


; Check for color input
COLOR		LD R3, NEGR
			AND R4, R4, #0 				; Clear
			ADD R4, R0, R3
			BRz RED1

			LD R3, NEGG
			AND R4, R4, #0 				; Clear
			ADD R4, R0, R3
			BRz GREEN1

			LD R3, NEGB
			AND R4, R4, #0 				; Clear
			ADD R4, R0, R3
			BRz BLUE1

			LD R3, NEGY
			AND R4, R4, #0 				; Clear
			ADD R4, R0, R3
			BRz YELLOW1

			LD R3, NEGSPACE
			AND R4, R4, #0 				; Clear
			ADD R4, R0, R3
			BRz WHITE1
			BRnp WAIT



; Clear graphics display
CLEARPIX	ST R1, CURRCOORD			; Store location
			LD R2, DOWN
			LD R0, BLACK
			LD R5, TOPLEFT
			LD R3, ALLPIX

LOOP2		STR R0, R5, #0 				; clear all pixels
			ADD R5, R5, #1
			ADD R3, R3, #-1
			BRzp LOOP2

			LD R1, CURRCOORD			; Add pen back
			LD R3, UP 
			ADD R1, R1, R3
			ADD R1, R1, R3
			ADD R1, R1, R3
			ADD R1, R1, R3

			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			BRnzp WAITJUMP


; Change color input
RED1		LD R6, RED 
			BRnzp WAITJUMP

GREEN1		LD R6, GREEN
			BRnzp WAITJUMP

BLUE1		LD R6, BLUE
			BRnzp WAITJUMP

YELLOW1		LD R6, YELLOW
			BRnzp WAITJUMP

WHITE1		LD R6, WHITE
			BRnzp WAITJUMP						


; Edge color cycle
LOOPCOLOR 	LD R4, RED
			AND R5, R5, #0
			AND R2, R2, #0 
			NOT R5, R4
			ADD R5, R5, #1
			ADD R2, R5, R6
			BRnp NEXT1
			LD R4, GREEN
			BRnzp EDGE

NEXT1		LD R4, GREEN 
			AND R5, R5, #0 
			AND R2, R2, #0 
			NOT R5, R4
			ADD R5, R5, #1
			ADD R2, R5, R6
			BRnp NEXT2
			LD R4, BLUE 
			BRnzp EDGE

NEXT2		LD R4, BLUE 
			AND R5, R5, #0 
			AND R2, R2, #0 
			NOT R5, R4
			ADD R5, R5, #1
			ADD R2, R5, R6
			BRnp NEXT3
			LD R4 YELLOW
			BRnzp EDGE

NEXT3		LD R4, YELLOW 
			AND R5, R5, #0 
			AND R2, R2, #0 
			NOT R5, R4
			ADD R5, R5, #1
			ADD R2, R5, R6
			BRnp NEXT4
			LD R4, WHITE 
			BRnzp EDGE

NEXT4		LD R4, WHITE 
			AND R5, R5, #0 
			AND R2, R2, #0 
			NOT R5, R4
			ADD R5, R5, #1
			ADD R2, R5, R6
			BRnp LOOPCOLOR
			LD R4, RED 
			BRnzp EDGE

EDGE		LD R3, UP 
			LD R2, DOWN
			ADD R6, R4, #0
			ADD R1, R1, R3
			ADD R1, R1, R3
			ADD R1, R1, R3
			ADD R1, R1, R3

			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			STR R6, R1, #0
			STR R6, R1, #1
			STR R6, R1, #2
			STR R6, R1, #3
			ADD R1, R1, R2
			BRnzp WAITJUMP

; HALT program
END 		HALT












