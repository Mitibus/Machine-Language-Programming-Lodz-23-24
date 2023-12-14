%include "system_functions.asm"

section .data
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
    firstDigit: resb 2
    secondDigit: resb 2
    result: resb 1

section .text
    global _start

print_message:
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, [esp+4]
    mov edx, [esp+8]
    int SYS_CALL
    ret

ask_digit:
    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, [esp+4]
    mov edx, 2
    int SYS_CALL
    ret

_start:
    ; Show the addition message
    push lenAdditionMessage
    push additionMessage
    call print_message
    add esp, 8

    ; Ask user for the firstDigit
    ; Print first message
    push lenAskFirstDigitMessage
    push askFirstDigitMessage
    call print_message
    add esp, 8

    ; Ask user to enter his digit
    push firstDigit
    call ask_digit
    add esp, 4

    ; Ask user for the secondDigit
    ; Print first message
    push lenAskSecondDigitMessage
    push askSecondDigitMessage
    call print_message
    add esp, 8    

    ; Ask user to enter his digit
    push secondDigit
    call ask_digit
    add esp, 4

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
    push lenResultMessage
    push resultMessage
    call print_message
    add esp, 8
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    ; Show the substraction message
    push lenSubstractionMessage
    push substractionMessage
    call print_message  
    add esp, 8

    ; Ask user for the firstDigit
    ; Print first message
    push lenAskFirstDigitMessage
    push askFirstDigitMessage
    call print_message
    add esp, 8

    ; Ask user to enter his digit
    push firstDigit
    call ask_digit
    add esp, 4

    ; Ask user for the secondDigit
    ; Print first message
    push lenAskSecondDigitMessage
    push askSecondDigitMessage
    call print_message
    add esp, 8    

    ; Ask user to enter his digit
    push secondDigit
    call ask_digit
    add esp, 4

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
    push lenResultMessage
    push resultMessage
    call print_message
    add esp, 8
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    ; Show the product message
    push lenProductMessage
    push productMessage
    call print_message
    add esp, 8

    ; Ask user for the firstDigit
    ; Print first message
    push lenAskFirstDigitMessage
    push askFirstDigitMessage
    call print_message
    add esp, 8

    ; Ask user to enter his digit
    push firstDigit
    call ask_digit
    add esp, 4

    ; Ask user for the secondDigit
    ; Print first message
    push lenAskSecondDigitMessage
    push askSecondDigitMessage
    call print_message
    add esp, 8    

    ; Ask user to enter his digit
    push secondDigit
    call ask_digit
    add esp, 4

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
    push lenResultMessage
    push resultMessage
    call print_message
    add esp, 8
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL
    
    ; Show the division message
    push lenDivisionMessage
    push divisionMessage
    call print_message
    add esp, 8

    ; Ask user for the firstDigit
    ; Print first message
    push lenAskFirstDigitMessage
    push askFirstDigitMessage
    call print_message
    add esp, 8

    ; Ask user to enter his digit
    push firstDigit
    call ask_digit
    add esp, 4

    ; Ask user for the secondDigit
    ; Print first message
    push lenAskSecondDigitMessage
    push askSecondDigitMessage
    call print_message
    add esp, 8    

    ; Ask user to enter his digit
    push secondDigit
    call ask_digit
    add esp, 4

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
    push lenResultMessage
    push resultMessage
    call print_message
    add esp, 8
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    ; Show the modulo message
    push lenModuloMessage
    push moduloMessage
    call print_message
    add esp, 8

    ; Ask user for the firstDigit
    ; Print first message
    push lenAskFirstDigitMessage
    push askFirstDigitMessage
    call print_message
    add esp, 8

    ; Ask user to enter his digit
    push firstDigit
    call ask_digit
    add esp, 4

    ; Ask user for the secondDigit
    ; Print first message
    push lenAskSecondDigitMessage
    push askSecondDigitMessage
    call print_message
    add esp, 8    

    ; Ask user to enter his digit
    push secondDigit
    call ask_digit
    add esp, 4

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
    push lenResultMessage
    push resultMessage
    call print_message
    add esp, 8
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    ; Show the increment message
    push lenIncrementMessage
    push incrementMessage
    call print_message
    add esp, 8

    ; Ask user for the firstDigit
    ; Print first message
    push lenAskFirstDigitMessage
    push askFirstDigitMessage
    call print_message
    add esp, 8

    ; Ask user to enter his digit
    push firstDigit
    call ask_digit
    add esp, 4

    ; Increment the value
    mov eax, [firstDigit]
    inc eax
    mov [result], eax  

    ; Print the result message
    push lenResultMessage
    push resultMessage
    call print_message
    add esp, 8
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    ; Show the decrement message
    push lenDecrementMessage
    push decrementMessage
    call print_message
    add esp, 8

    ; Ask user for the firstDigit
    ; Print first message
    push lenAskFirstDigitMessage
    push askFirstDigitMessage
    call print_message
    add esp, 8

    ; Ask user to enter his digit
    push firstDigit
    call ask_digit
    add esp, 4

    ; Decrement value
    mov eax, [firstDigit]
    mov ebx, 0x01
    sub eax, ebx
    mov [result], eax   

    ; Print the result message
    push lenResultMessage
    push resultMessage
    call print_message
    add esp, 8
    
    ; Print the result digit
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, result
    mov edx, 1
    int SYS_CALL

    ; Exit the program
    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL
