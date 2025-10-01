.386
.model flat,stdcall
.stack 4096

STD_OUTPUT_HANDLE EQU -11       ; from Win32 API, output handle const
STD_INPUT_HANDLE EQU -10        ; input handle const

bufSize = 1024

WriteConsole EQU <WriteConsoleA>
ReadConsole  EQU <ReadConsoleA>

ExitProcess PROTO,          ; exit program
    dwExitCode:DWORD        ; return code


GetStdHandle PROTO,         ; get standard handle
    nStdHandle:DWORD        ; type of console handle


WriteConsole PROTO,                 ; write a buffer to the console
    handle:DWORD,                   ; output handle
    lpBuffer:PTR BYTE,              ; pointer to buffer
    nNumberOfBytesToWrite:DWORD,    ; size of buffer
    lpNumberOfBytesWritten:PTR DWORD,   ; num bytes written
    lpReserved:DWORD                    ; (not used)

;https://csc.csudh.edu/mmccullough/asm/help/source/win32lib/readconsole.htm
ReadConsole PROTO,
    handle:DWORD,                   ; console input buffer handle (in)
    lpBuffer:PTR BYTE,              ; ptr to buffer for data read (out)
    nNumberOfCharsToRead:DWORD,     ; charsRead * sizeof(TCHAR) (in)
    lpNumberOfCharsRead:PTR DWORD,  ; how many chars actually read (out)
    pInputControl:DWORD             ; unused

;https://learn.microsoft.com/en-us/cpp/assembler/masm/masm-bnf-grammar?view=msvc-170
.data
mesg1               BYTE        "Hello world!",0dh,0ah,0
BytesWritten        DWORD       0
ConsoleOutHandle    DWORD       0
buffer              BYTE        bufSize DUP(?),0,0 
userStrSize         DWORD       12
bytesRead           DWORD       ?
ConsoleInHandle     DWORD       0
answer              BYTE        bufSize DUP(?),0,0
charLength          DWORD       ?

.code
_convertChartoInt proc
    ; cl = 0
    ; inc cl
    ; mov answer, [buffer + 4 * cl]
    ; Stop if cl == buffer size., so cmp cl, buffer size

_convertCharToInt ENDP

main proc
    
    ; Get Standard Output Handle
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE  ; Get a handle to console SCREEN.
    mov ConsoleOutHandle, eax

    ; Get Standard Input Handle
    INVOKE GetStdHandle, STD_INPUT_HANDLE  ; Get a handle to console INPUT
    mov ConsoleInHandle, eax
    
    ; Write Message to the Handle => CONSOLE
    INVOKE WriteConsole, ConsoleOutHandle, ADDR mesg1, 
        (LENGTHOF mesg1)-1, ADDR BytesWritten, 0

    ; Read Input from Console
    INVOKE ReadConsole, ConsoleInHandle, ADDR buffer, 
        BufSize - 2, ADDR bytesRead, 0
    ;
    ; Each byte is currently a character, either lowercase or uppercase.
    ; Take each byte, convert to chr num.
    ; EXAMPLE: A -> 65, HEX is 41. Append to str char 6, 5. 
    ; So, make a for loop which goes through each char and converts. 



    ; Echo
    INVOKE WriteConsole, ConsoleOutHandle, ADDR buffer,
        (LENGTHOF buffer)-1, ADDR bytesRead, 0
    
    invoke ExitProcess,0
main endp

end main