%include "system_functions.asm"

section .data
    ; Constant section
    msg: db "The largest digit is: ", 0xA,0xD 
    len: equ $- msg 
    ask_msg: db "Please enter a digit: "
    len2: equ $ - ask_msg

section .bss
    ; Variable section
    largest: resb 3
    num1: resb 3
    num2: resb 3
    num3: resb 3

section .text
    global _start

_start:
    ; Instructions here
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, ask_msg
    mov edx, len2
    int SYS_CALL

    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, num1
    mov edx, 3
    int SYS_CALL

    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, ask_msg
    mov edx, len2
    int SYS_CALL

    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, num2
    mov edx, 3
    int SYS_CALL

    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, ask_msg
    mov edx, len2
    int SYS_CALL

    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, num3
    mov edx, 3
    int SYS_CALL

    ; Transform user inputs to digit
    mov eax, [num1]
    sub eax, '0'
    mov [num1], eax
    mov eax, [num2]
    sub eax, '0'
    mov [num2], eax
    mov eax, [num3]
    sub eax, '0'
    mov [num3], eax

    mov ecx, [num1]
    cmp ecx, [num2]
    jg check_third_num ; JG for Jump Greater
    mov ecx, [num2]
    
check_third_num:
    cmp ecx, [num3]
    jg _exit ; JG for Jump Greater
    mov ecx, [num3]

_exit:
    mov [largest], ecx
    mov ecx, msg
    mov edx, len
    mov ebx, STD_OUT
    mov eax, SYS_WRITE
    int SYS_CALL

    ; Convert the result to ASCII
    mov eax, [largest]
    add eax, '0'
    mov [largest], eax   

    mov ecx, largest
    mov edx, 3
    mov ebx, STD_OUT
    mov eax, SYS_WRITE
    int SYS_CALL

    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL