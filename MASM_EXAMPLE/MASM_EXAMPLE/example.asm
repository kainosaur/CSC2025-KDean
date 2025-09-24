.486
.MODEL FLAT
.CODE
PUBLIC _myFunc
_myFunc PROC
	; Subroutine Prologue
	; https://stackoverflow.com/questions/21718397/what-are-the-esp-and-the-ebp-registers
	; esp is stack pointer, ebp is for a stack frame so when
	; a function is entered, ebp can get a copy at that point
	; ebp: base pointer?
	push ebp		; Stack frame base pointer
					; Push to stack to save the old base pointer value
	mov ebp, esp	; esp is Stack pointer
	; EIP contains the offset of teh next instruction to be executed
	sub esp, 4		; Make room for one 4-byte local var
	; Why in this context is 4 bytes getting substracted? Why not just
	; the literal number 4?
	; its sub <reg>,<mem> , and not sub <reg>, <con>?
	push edi		; Saves the values of registers that the funciton
	push esi		; will modify. This functions uses EDI and ESI
	; EBX, EBP, and ESP do not need to be saved.
	; EBX -> Memory Pointer, base reg
	; EBP -> already on the stack, to be popped later
	; ESP -> stack pointer

	; Subroutine Body
	mov eax, [ebp+8]	; Move value of parameter 1 into EAX
						; BaseReg + Disp
	mov esi, [ebp+12]	; Move value of parameter 2 into ESI
	mov edi, [ebp+16]	; Move value of 3 into EDI

	mov [ebp-4], edi	; Move EDI into the local var
	add [ebp-4], esi	; Add ESI into the local var
	add eax, [ebp-4]	; add the contents of the local var
						; into EAX (final result)

		; Subroutine Epilogue
		pop esi			; recover reg vals
		pop edi
		mov esp, ebp	; Deallocate local var
		pop ebp			; Restore teh caller's base pointer value
		ret
	_myFunc ENDP
	END

