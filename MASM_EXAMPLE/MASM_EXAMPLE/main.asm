.486
.MODEL FLAT
.CODE
PUBLIC _addFunction
_addFunction PROC
	; Prologue
	push ebp
	mov ebp, esp

	; Function calls
	mov eax, [ebp + 8]	; move arg 1 into eax
	mov edx, [ebp + 12]	; move arg 2 into edx
	add eax, edx
	
	; epilogue
	pop ebp
	ret					; return sum
_addFunction ENDP
main PROC
	push 3
	push 2
	call _addFunction
	add esp, 8
	ret					; return sum
main ENDP
END