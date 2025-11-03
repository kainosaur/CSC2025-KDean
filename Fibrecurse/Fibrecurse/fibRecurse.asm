.386P
.model flat
public _fibRecurse

.code
_fibRecurse PROC
	;Prologue
	push ebp
	mov ebp, esp
	sub esp, 4

	; arg into eax
	mov eax, [ebp + 8]	; int n
	cmp eax, 1
	je _end

	cmp eax, 0
	je _end

	dec eax		;n-1
	push eax
	call _fibRecurse
	mov [ebp-4], eax		; reserve eax
	dec dword ptr [esp]		; n-2
	call _fibRecurse
	
	add eax, [ebp-4]		; add the reserved previous _fibRecurse
							; to new _fibRecurse

	; Epilogue
	_end:
	add esp, 4				; restore esp
	mov esp, ebp
	pop ebp
	ret

_fibRecurse ENDP
END