%include "system_functions.asm"

section .data
    ; Constant section
    
section .bss
    ; Variable section
    num: resb 1

section .text
    global _start

_start:
    ; Instructions here
    mov ecx, 126-33
    mov eax, 33

l1:
    mov [num], eax
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    push ecx

    mov ecx, num
    mov edx, 1
    int SYS_CALL

    mov eax, [num]
    sub eax, '0' ; Convert to number from ASCII
    inc eax
    add eax, '0' ; Convert to ASCII from number
    pop ecx
    loop l1

    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL
