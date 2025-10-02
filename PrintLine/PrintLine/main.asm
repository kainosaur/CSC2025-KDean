.386P
.model flat
extern _ExitProcess@4:near
extern _GetStdHandle@4:near
extern _WriteConsoleA@20:near

.data
msg			byte	'Hello, World', 10
handle		dword	?
written		dword	?

.stack

.code
_PrintLine PROC
	; Prologue
	push ebp
	mov ebp, esp
	sub esp, 6

	; This was confusing to me at first,
	; the closest push is what is retrieved first
	mov eax, [ebp + 8]		;msg length
	mov edx, [ebp + 12]		;offset written
	mov edi, [ebp + 16]		;handle arg
	mov ebx, [ebp + 20]		;msg arg
	; WriteConsole(handle, &msg[0], numCharsToWrite, &written, 0)
	push 0
	push edx
	push eax
	push ebx
	push edi
	call _WriteConsoleA@20

	; epilogue
	mov esp, ebp
	pop ebp
	ret ecx
_PrintLine ENDP
main PROC
	; handle = GetStdHandle(-11)
	push -11
	call _GetStdHandle@4		; ret eax
	mov handle, eax

	push offset msg				; pushing on msg, then offset msg		
	push handle
	push offset written	
	push LENGTHOF msg
	call _PrintLine
	
	push ecx					; characters written returned
	call _ExitProcess@4
main ENDP
END main

