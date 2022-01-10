			AREA question1, CODE, READWRITE
			ENTRY
			LDR r0, =STRING1					;input string1 values at given memory location
			ADR r1, STRING2						;input string2 marker to store new values
			MOV r2, #-0x01						;counter to increment by number of characters, set at negative 1 to account for first add to reach beginning of string

CharLoop	ADD r2, #0x01						;add 1 to check next character
			LDRB r5, [r0, r2]					;load character at address pointed to in r0 into r5, incremented by r2

			CMP r5, #0x00						;determine if r5 is the end of string by subtracting r5 from 0
			BEQ Loop							;if end of string, branch to Loop, end

TCheck		CMP r5, #0x74						;compare r5 to "t" (hex = 74) by subtracting r5 from 74
			BNE Store1							;if not equal, branch to Store

			CMP r2, #0x00						;check if "t" is the first character in string by checking counter
			BEQ HCheck							;if first character in string, skip Before and branch to Hcheck (to check next character)

Before		SUB r11, r2, #0x01					;put value of r2-0x1 into r11 to decrement to previous character
			LDRB r10, [r0, r11]					;load character at r0 decremented by r11 to point to previous character, into r10

			CMP r10, #0x20						;compare r10 to " " (hex = 20) by subtracting r10 from 20
			BNE Store1							;if not equal, it is not a space, branch to Store

HCheck		ADD r2, #0x01						;put value of r2+1 into r2 to point to next character
			LDRB r6, [r0, r2]					;load character at r0 incremented by r2, next character, into r6

			CMP r6, #0x68						;compare r6 to "h" (hex = 68) by subtracting r6 from 68
			BNE Store2							;if not equal, branch to Store

ECheck		ADD r2, #0x01						;put value of r2+1 into r2 to point to next character
			LDRB r7, [r0, r2]					;store byte in r1 incremented by r2 to r7

			CMP r7, #0x65						;compare r7 to "h" (hex = 65) by subtracting r10 from 68
			BNE Store3							;if not equal, branch to Store

After		ADD r11, r2, #0x01					;put value of r2-1 into r11 to increment to find next character
			LDRB r10, [r0, r11]					;load character at r0 incremented by r11 to point to next character, into r10

			CMP r10, #20						;determine if r10 is a space " " (hex=20) by subtracting r10 from 20
			BEQ CharLoop						;if so, loop back to CharLoop to check next character

			CMP r10, #0x00						;determine if r10 is end of string (hex = 0) by subtracting r10 from 0
			BEQ Loop							;if there is no character after, end string

Store1		STRB r5, [r1], #0x01				;store values in r5 into address pointed to by r1, increment r1 by 1 after to move to next memory slot
Store2		STRB r6, [r1], #0x01				;store values in r6 into address pointed to by r1, increment r1 by 1 after to move to next memory slot
Store3		STRB r7, [r1], #0x01				;store values in r7 into address pointed to by r1, increment r1 by 1 after to move to next memory slot
			B CharLoop							;branch to CharLoop to check next character
												;the code runs through correctly, but it keeps giving me a write access error for storing

Loop		B Loop

			AREA question1, DATA, READWRITE

STRING1		DCB "and the man said they must go"	;String1
EoS			DCB 0x00							;end of string1
STRING2		space 0x7F							;just allocating 127 bytes
			END
