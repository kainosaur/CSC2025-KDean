.386P
.model flat
extern _ExitProcess@4:near

extern _fibRecurse:near

.data

.code

main PROC
	push 7			; Pushing int n for fibonacci
	call _fibRecurse
	
	push eax		; Final Results returned in _ExitProcess
	call _ExitProcess@4

main ENDP
END

