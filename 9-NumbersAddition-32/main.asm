%include "system_functions.asm"

section .data
    ; Constant section
    msg: db 'The Sum is:', 0xa
    len: equ $ - msg
    askMsg: db 'Enter a number (max 5 digits): '
    lenAsk: equ $ - askMsg

    sum: db '      '

section .bss
    ; Variable section
    num1: resb 6
    num2: resb 6

section .text
    global _start

_start:
    ; Instructions here
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov edx, lenAsk
    mov ecx, askMsg
    int SYS_CALL

    ; Read User input
    mov eax, SYS_READ
    mov ebx, STD_INP
    mov edx, 6
    mov ecx, num1
    int SYS_CALL

    ; Instructions here
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov edx, lenAsk
    mov ecx, askMsg
    int SYS_CALL

    ; Read User input
    mov eax, SYS_READ
    mov ebx, STD_INP
    mov edx, 6
    mov ecx, num2
    int SYS_CALL


    mov esi, 4  ; pointing to the rightmost digit
    mov ecx, 5  ; num of digits
    clc

add_loop:
    mov al, [num1 + esi]
    adc al, [num2 + esi]
    aaa
    pushf
    or al, 30h
    popf

    mov [sum + esi], al
    dec esi
    loop add_loop

    ; Handle final carry
    jnc no_final_carry
    
    ; Shift the entire result to the right by one position
    mov esi, 4     ; Reset ESI to point to the rightmost digit
    mov ecx, 5     ; Reset ECX to the number of digits
    add ecx, 1     ; Increment the count to account for the extra digit
    std            ; Set the direction flag to enable reverse string operations

shift_loop:
    mov al, [sum + esi - 1] ; Load the digit from one position to the right
    mov [sum + esi], al     ; Store it one position to the left
    dec esi
    loop shift_loop

    ; Set the leftmost digit to '1'
    mov byte [sum], '1'
    clc

no_final_carry:   
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov edx, len
    mov ecx, msg
    int SYS_CALL

    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov edx, 6
    mov ecx, sum
    int SYS_CALL
    
    ; Exit the program
    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL
