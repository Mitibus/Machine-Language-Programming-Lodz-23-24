%include "system_functions.asm"

section .data
    menuMsg: db 10, "****** Calculator ******", 10, "Please choose which operation you wan to perform :", 10, "1) Addition", 10, "2) Subtraction", 10, "3) Multiplication", 10, "4) Division", 10, "5) Modulo", 10, "6) Incrementation", 10, "7) Decrementation", 10, "8) Exit Program", 10, "Your Choice: "
    lenMenuMsg: equ $ - menuMsg

    askFirstDigitMessage: db "Enter first digit: "
    lenAskFirstDigitMessage: equ $-askFirstDigitMessage
    askSecondDigitMessage: db "Enter the second digit: "
    lenAskSecondDigitMessage: equ $-askSecondDigitMessage

    resultMessage: db "The result is: "
    lenResultMessage: equ $-resultMessage

    additionMessage: db "***** Addition *****", 10
    lenAdditionMessage: equ $-additionMessage
    substractionMessage: db 10,"***** Substraction *****", 10
    lenSubstractionMessage: equ $-substractionMessage
    productMessage: db 10, "***** Product *****", 10
    lenProductMessage: equ $-productMessage
    divisionMessage: db 10, "***** Division *****", 10
    lenDivisionMessage: equ $-divisionMessage
    moduloMessage: db 10, "***** Modulo *****", 10
    lenModuloMessage: equ $-moduloMessage
    incrementMessage: db 10, "***** Increment *****", 10
    lenIncrementMessage: equ $-incrementMessage
    decrementMessage: db 10, "***** Decrement *****", 10
    lenDecrementMessage: equ $-decrementMessage

section .bss
    menuChoice: resb 2
    firstDigit: resb 2
    secondDigit: resb 2
    result: resb 1

section .text
    global _start

_start:
    ; Display the menu
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, menuMsg
    mov edx, lenMenuMsg
    int SYS_CALL

    ; Ask user to make a choice
    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, menuChoice
    mov edx, 2
    int SYS_CALL

    ; Compare user input
    cmp byte [menuChoice], '1'
    je addition
    cmp byte [menuChoice], '2'
    je subtraction
    cmp byte [menuChoice], '3'
    je multiplication
    cmp byte [menuChoice], '4'
    je division
    cmp byte [menuChoice], '5'
    je modulo
    cmp byte [menuChoice], '6'
    je increment
    cmp byte [menuChoice], '7'
    je decrement
    cmp byte [menuChoice], '8'
    je exit

    jmp _start

addition:
    ; Show the addition message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, additionMessage
    mov edx, lenAdditionMessage
    int SYS_CALL

    ; Ask user for the firstDigit
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

    ; Ask user for the secondDigit
    ; Print first message
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

    ; Convert user input to int
    mov eax, [firstDigit]
    sub eax, '0'
    mov ebx, [secondDigit]
    sub ebx, '0'

    ; Sum the two digits
    add eax, ebx

    ; Convert the result to ASCII
    add eax, '0'
    mov [result], eax

    ; Print the result message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, resultMessage
    mov edx, lenResultMessage
    int SYS_CALL
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    jmp _start

subtraction:
    ; Show the substraction message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, substractionMessage
    mov edx, lenSubstractionMessage
    int SYS_CALL

    ; Ask user for the firstDigit
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

    ; Ask user for the secondDigit
    ; Print first message
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

    ; Convert user input to int
    mov eax, [firstDigit]
    sub eax, '0'
    mov ebx, [secondDigit]
    sub ebx, '0'

    ; Sub the two digits
    sub eax, ebx

    ; Convert the result to ASCII
    add eax, '0'
    mov [result], eax

    ; Print the result message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, resultMessage
    mov edx, lenResultMessage
    int SYS_CALL
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    jmp _start

multiplication:
    ; Show the product message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, productMessage
    mov edx, lenProductMessage
    int SYS_CALL

    ; Ask user for the firstDigit
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

    ; Ask user for the secondDigit
    ; Print first message
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

    ; Print the result message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, resultMessage
    mov edx, lenResultMessage
    int SYS_CALL
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL
    
    jmp _start

division:
    ; Show the division message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, divisionMessage
    mov edx, lenDivisionMessage
    int SYS_CALL

    ; Ask user for the firstDigit
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

    ; Ask user for the secondDigit
    ; Print first message
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

    ; Convert user input to int
    movzx eax, byte [firstDigit] ; Use movzx to complete size with zero as we take only one byte from firstDigit
    sub eax, '0'
    movzx ebx, byte [secondDigit]
    sub ebx, '0'

    ; Divide digit in EDX:EAX by EBX
    ; As we just want to divide EAX by EBX, we need to init EDX to ZERO
    mov edx, 0x0
    div ebx

    ; Convert the result to ASCII
    add eax, '0'
    mov [result], eax

    ; Print the result message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, resultMessage
    mov edx, lenResultMessage
    int SYS_CALL
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    jmp _start

modulo:
    ; Show the modulo message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, moduloMessage
    mov edx, lenModuloMessage
    int SYS_CALL

    ; Ask user for the firstDigit
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

    ; Ask user for the secondDigit
    ; Print first message
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
    ; Convert the result to ASCII
    add edx, '0'
    mov [result], edx 

    ; Print the result message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, resultMessage
    mov edx, lenResultMessage
    int SYS_CALL
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    jmp _start

increment:
    ; Show the increment message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, incrementMessage
    mov edx, lenIncrementMessage
    int SYS_CALL

    ; Ask user for the firstDigit
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

    ; Increment the value
    mov eax, [firstDigit]
    inc eax
    mov [result], eax  

    ; Print the result message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, resultMessage
    mov edx, lenResultMessage
    int SYS_CALL
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    jmp _start

decrement:
    ; Show the decrement message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, decrementMessage
    mov edx, lenDecrementMessage
    int SYS_CALL

    ; Ask user for the firstDigit
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

    ; Decrement value
    mov eax, [firstDigit]
    mov ebx, 0x01
    sub eax, ebx
    mov [result], eax   

    ; Print the result message
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, resultMessage
    mov edx, lenResultMessage
    int SYS_CALL
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    jmp _start

exit:
    ; Exit the program
    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL
