.386P
.model flat
extern _ExitProcess@4:near

.data
number1		BYTE		10
number2		BYTE		20
number3		BYTE		30
number4		BYTE		40

.stack

.code
main PROC
	mov AL, number4
	mov AH, number3
	xchg number1, AL
	xchg number2, AH
	mov number4, AL
	mov number3, AH

	call _ExitProcess@4
main ENDP
END main


