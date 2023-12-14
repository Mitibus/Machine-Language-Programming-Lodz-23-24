%include "system_functions.asm"

section .data
    ; Constant section

section .bss
    ; Variable section

section .text
    global _start

_start:
    ; Instructions here
    
    
    ; Exit the program
    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL
