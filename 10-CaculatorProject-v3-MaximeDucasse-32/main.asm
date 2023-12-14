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

%macro print 2
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, %1
    mov edx, %2
    int SYS_CALL
%endmacro

%macro read 2
    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, %1
    mov edx, %2
    int SYS_CALL
%endmacro

%macro askForTwoDigit 0
    ; Ask user for the firstDigit
    print askFirstDigitMessage, lenAskFirstDigitMessage
    
    ; Ask user to enter his digit
    read firstDigit, 2

    ; Ask user for the secondDigit
    print askSecondDigitMessage, lenAskSecondDigitMessage
    
    ; Ask user to enter his digit
    read secondDigit, 2
%endmacro

%macro askForOneDigit 0
    ; Ask user for the firstDigit
    print askFirstDigitMessage, lenAskFirstDigitMessage
    
    ; Ask user to enter his digit
    read firstDigit, 2
%endmacro

%macro print_result 0
    ; Print the result message
    print resultMessage, lenResultMessage
        
    ; Print the result digit
    print result, 1
%endmacro

section .text
    global _start

_start:
    ; Display the menu
    print menuMsg, lenMenuMsg

    ; Ask user to make a choice
    read menuChoice, 2

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
    print additionMessage, lenAdditionMessage
    askForTwoDigit

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

    print_result

    jmp _start

subtraction:
    ; Show the substraction message
    print substractionMessage, lenSubstractionMessage
    askForTwoDigit

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

    print_result

    jmp _start

multiplication:
    ; Show the product message
    print productMessage, lenProductMessage
    askForTwoDigit

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

    print_result
    
    jmp _start

division:
    ; Show the division message
    print divisionMessage, lenDivisionMessage
    askForTwoDigit

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

    print_result

    jmp _start

modulo:
    ; Show the modulo message
    print moduloMessage, lenModuloMessage
    askForTwoDigit

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

    print_result

    jmp _start

increment:
    ; Show the increment message
    print incrementMessage, lenIncrementMessage
    askForOneDigit    

    ; Increment the value
    mov eax, [firstDigit]
    inc eax
    mov [result], eax  

    print_result

    jmp _start

decrement:
    ; Show the decrement message
    print decrementMessage, lenDecrementMessage
    askForOneDigit

    ; Decrement value
    mov eax, [firstDigit]
    mov ebx, 0x01
    sub eax, ebx
    mov [result], eax   

    print_result

    jmp _start

exit:
    ; Exit the program
    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL
