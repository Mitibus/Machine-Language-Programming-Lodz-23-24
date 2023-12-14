%include "system_functions.asm"

section .data
    ; Constant section
    menuMessage: db "Welcome ! Please choose an option", 10, "  1. Condition", 10, "  2. Loops", 10, "  3. Exit", 10, "Your choice: "
    lenMenuMessage: equ $ - menuMessage
    conditionMessage: db 10, "You choose condition", 10
    lenConditionMessage: equ $ - conditionMessage
    loopMessage: db 10, "You choose loop", 10
    lenLoopMessage: equ $ - loopMessage

section .bss
    userInput: resb 2

section .text
    global _start

_start:
    ; Instructions here
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, menuMessage
    mov edx, lenMenuMessage
    int SYS_CALL

    ; Read user input
    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, userInput
    mov edx, 2
    int SYS_CALL

    ; Compare input
    cmp byte [userInput], '1'
    je option1
    cmp byte [userInput], '2'
    je option2
    jmp exit

option1:
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, conditionMessage
    mov edx, lenConditionMessage
    int SYS_CALL
    jmp _start

option2:
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, loopMessage
    mov edx, lenLoopMessage
    int SYS_CALL
    jmp _start

exit:
    ; Exit the program
    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL

