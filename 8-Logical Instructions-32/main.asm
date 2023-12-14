%include "system_functions.asm"

section .data
    ; Constant section
    even_msg:  db  'Even Number!' ;message showing even number
    len1:  equ  $ - even_msg 

    odd_msg: db  'Odd Number!'    ;message showing odd number
    len2:  equ  $ - odd_msg

    ask_msg: db 'Please enter a number: '
    len3: equ $ - ask_msg

section .bss
    ; Variable section
    user_number: resb 2

section .text
    global _start

_start:
    ; Instructions here
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, ask_msg
    mov edx, len3
    int SYS_CALL

    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, user_number
    mov edx, 2
    int SYS_CALL

    ; Convert user input to number
    mov eax, [user_number]
    sub eax, '0'

    mov eax, eax      ; getting 8 in the ax
    and eax, 1       ; and ax with 1
    jz evnn
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, odd_msg
    mov edx, len2
    int SYS_CALL
    jmp outprog

evnn:
    mov ah, 09h
    mov eax, SYS_WRITE
    mov ebx, 1
    mov ecx, even_msg
    mov edx, len1
    int SYS_CALL
    

outprog:
    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL
