.386P
.model flat
extern _ExitProcess@4:near

.data

.stack

.code


main PROC
	;Take the value of n
	mov eax, 2 ; ecx used for loop counter
	mov edx, 1 ; previous
	mov esi, 1 ; current
	mov edi, 1 ; next

	mov ecx, eax
	dec ecx
	dec ecx
	cmp ecx, 0
	jle finish
	begin:
		add edi, edx
		mov edx, esi
		mov esi, edi
	loop begin ; Loops if ecx is greater than 0
	
	finish:
	mov eax, edi
	push eax
	call _ExitProcess@4
main ENDP
END main


