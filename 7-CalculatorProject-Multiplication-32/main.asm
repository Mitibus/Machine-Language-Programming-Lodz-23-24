%include "system_functions.asm"

section .data
    firstMessage: db "Enter first digit: "
    lenFirstMessage: equ $-firstMessage

    secondMessage: db "Enter the second digit: "
    lenSecondMessage: equ $-secondMessage

    thirdMessage: db "The result of mulitplication is: "
    lenThirdMessage: equ $-thirdMessage

section .bss
    firstDigit: resb 2
    secondDigit: resb 2
    result: resb 1

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
    mov ecx, firstDigit
    mov edx, 2
    int SYS_CALL

    ; Print second message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, secondMessage
    mov edx, lenSecondMessage
    int SYS_CALL

    ; Ask user to enter his digit
    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, secondDigit
    mov edx, 2
    int SYS_CALL

    ; Convert user input to int
    mov eax, [firstDigit]
    sub eax, '0'
    mov ebx, [secondDigit]
    sub ebx, '0'

    ; Multiply digit in EAX by EBX
    mul ebx

    ; Convert the result to ASCII
    add eax, '0'
    mov [result], eax   
    
    ; Print the second message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, thirdMessage
    mov edx, lenThirdMessage
    int SYS_CALL
    
    ; Print the incremented digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    ; Exit the program
    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL
