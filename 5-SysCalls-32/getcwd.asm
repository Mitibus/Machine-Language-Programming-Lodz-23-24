%include "system_functions.asm"

section .data
    msg: db 'Your current directory is: '
    lenMsg: equ $-msg

section .bss
    dir: resb 256

section .text
    global _start

_start:
    mov eax, SYS_GETCWD
    mov ebx, dir
    mov ecx, 256
    int SYS_CALL

    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg
    mov edx, lenMsg
    int SYS_CALL

    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, dir
    mov edx, 256
    int SYS_CALL

    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL

    