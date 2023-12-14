; Functions
SYS_EXIT EQU 0x01
SYS_WRITE EQU 0x04
SYS_CALL EQU 0x80

; Standard Output
STD_OUT EQU 0x01

section .data              ; Data section
    text:   db "Hello World!", 10  ; The string to print, 10=LF
    len:    equ $-text         ; "$" means "here"
                           ; len is a value, not an address
 
section .text              ; Code section
    global  _start         ; Make label available to linker
                           ; We must export the entry point to the ELF linker or
                           ; loader. They conventionally recognize _start as their
                           ; entry point. Use ld -e foo to override the default.
 
_start:                    ; Standard  ld  entry point
    mov edx, len           ; arg3: length of string to print
    mov ecx, text          ; arg2: pointer to string
    mov ebx, STD_OUT       ; arg1: where to write, so called file handler
                           ; in this case stdout (screen)
    mov eax, SYS_WRITE     ; System call number (sys_write)
    int SYS_CALL           ; Interrupt 80 hex, call kernel
 
    ; Exit
    mov     ebx, 0         ; Exit code, 0=normal
    mov     eax, SYS_EXIT  ; System call number (sys_exit)
    int     SYS_CALL       ; Interrupt 80 hex, call kernel
    ; End of the code