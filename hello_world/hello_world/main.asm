.386P
.model flat
extern _ExitProcess@4:near
extern _GetStdHandle@4:near
extern _WriteConsoleA@20:near
public _go

.data
msg			byte	'Hello, World', 10
handle		dword	?
written		dword	?

.stack

.code
_go:
	; handle = GetStdHandle(-11)
	push -11
	call _GetStdHandle@4		; ret eax
	mov handle, eax

	; WriteConsole(handle, &msg[0], numCharsToWrite, &written, 0)
	; calls are read right to left
	push 0
	push offset written			; offset is the address?
	push 13						; 13 chars to write
	push offset msg				
	push handle
	call _WriteConsoleA@20
	push 0
	call _ExitProcess@4
end _go
END

