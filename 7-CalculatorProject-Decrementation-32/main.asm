%include "system_functions.asm"

section .data
    firstMessage: db "Enter the digit you want to decrement: "
    lenFirstMessage: equ $-firstMessage
    secondMessage: db "The decremented digit is equal to: "
    lenSecondMessage: equ $-secondMessage

section .bss
    digit: resb 2

section .text
    global _start

_start:
    ; Print first message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, firstMessage
    mov edx, lenFirstMessage
    int SYS_CALL

    ; Ask user to enter his digit
    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, digit
    mov edx, 2
    int SYS_CALL

    ; Decrement value
    mov eax, [digit]
    mov ebx, 0x01
    sub eax, ebx
    mov [digit], eax   
    
    ; Print the second message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, secondMessage
    mov edx, lenSecondMessage
    int SYS_CALL
    
    ; Print the incremented digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, digit
    mov edx, 2
    int SYS_CALL

    ; Exit the program
    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL
