%include "system_functions.asm"

section .data
    askFirstDigitMessage: db "Enter your first digit: "
    lenAskFirstDigitMessage: equ $-askFirstDigitMessage
    askSecondDigitMessage: db "Enter your second digit: "
    lenAskSecondDigitMessage: equ $-askSecondDigitMessage
    
    additionMessage: db "The result of addition is: "
    lenAdditionMessage: equ $-additionMessage
    substractionMessage: db "The result of substraction is: "
    lenSubstractionMessage: equ $-substractionMessage
    divisionMessage: db "The result of the division is: "
    lenDivisionMessage: equ $-divisionMessage
    productMessage: db "The result of the product is: "
    lenProductMessage: equ $-productMessage
    decrementMessage: db "The decremented digit is equal to: "
    lenDecrementMessage: equ $-decrementMessage
    incrementMessage: db "The incremented digit is equal to: "
    lenIncrementMessage: equ $-incrementMessage
    moduloMessage: db "The modulo result is: "
    lenModuloMessage: equ $-moduloMessage

section .bss
    firstDigit: resb 2
    secondDigit: resb 2
    result: resb 1

section .text
    global _start

_start:
    ; Start with the addition
    call askUserForFirstDigit
    call askUserForSecondDigit
    call addition
    mov ecx, additionMessage
    mov edx, lenAdditionMessage
    call showResult
    
    
    ; Exit the program
    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL

askUserForFirstDigit:
    ; Print first message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, askFirstDigitMessage
    mov edx, lenAskFirstDigitMessage
    int SYS_CALL

    ; Ask user to enter his digit
    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, firstDigit
    mov edx, 2
    int SYS_CALL

askUserForSecondDigit:
    ; Print second message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, askSecondDigitMessage
    mov edx, lenAskSecondDigitMessage
    int SYS_CALL

    ; Ask user to enter his digit
    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, secondDigit
    mov edx, 2
    int SYS_CALL

showResult:
    ; Print the result message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    int SYS_CALL

    ; Print the result
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

addition:
    ; Convert user input to int
    mov eax, [firstDigit]
    sub eax, '0'
    mov ebx, [secondDigit]
    sub ebx, '0'

    ; Sum the two digits
    add eax, ebx

    ; Convert the firstDigit to ASCII
    add eax, '0'
    mov [result], eax   

substraction:
    ; Convert user input to int
    mov eax, [firstDigit]
    sub eax, '0'
    mov ebx, [secondDigit]
    sub ebx, '0'

    ; Substract the two digits
    sub eax, ebx

    ; Convert the firstDigit to ASCII
    add eax, '0'
    mov [result], eax   

product:
    ; Convert user input to int
    mov eax, [firstDigit]
    sub eax, '0'
    mov ebx, [secondDigit]
    sub ebx, '0'

    ; Multiply digit in EAX by EBX
    mul ebx

    ; Convert the firstDigit to ASCII
    add eax, '0'
    mov [result], eax  

division:
    ; Convert user input to int
    movzx eax, byte [firstDigit] ; Use movzx to complete size with zero as we take only one byte from firstDigit
    sub eax, '0'
    movzx ebx, byte [secondDigit]
    sub ebx, '0'

    ; Divide digit in EDX:EAX by EBX
    ; As we just want to divide EAX by EBX, we need to init EDX to ZERO
    mov edx, 0x0
    div ebx

    ; Convert the firstDigit to ASCII
    add eax, '0'
    mov [result], eax

modulo:
    ; Convert user input to int
    movzx eax, byte [firstDigit] ; Use movzx to complete size with zero as we take only one byte from firstDigit
    sub eax, '0'
    movzx ebx, byte [secondDigit]
    sub ebx, '0'

    ; Divide digit in EDX:EAX by EBX
    ; As we just want to divide EAX by EBX, we need to init EDX to ZERO
    mov edx, 0x0
    div ebx

    ; Remainder is stored in the edx register
    ; Convert the firstDigit to ASCII
    add edx, '0'
    mov [result], edx

increment:
    ; Increment the value
    mov eax, [firstDigit]
    inc eax
    mov [result], eax   

decrement:
    ; Decrement value
    mov eax, [firstDigit]
    mov ebx, 0x01
    sub eax, ebx
    mov [result], eax  