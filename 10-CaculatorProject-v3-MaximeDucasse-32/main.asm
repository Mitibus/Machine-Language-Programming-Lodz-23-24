%include "system_functions.asm"

section .data
    menuMsg: db 10, "****** Calculator ******", 10, "Please choose which operation you wan to perform :", 10, "1) Addition", 10, "2) Subtraction", 10, "3) Multiplication", 10, "4) Division", 10, "5) Modulo", 10, "6) Incrementation", 10, "7) Decrementation", 10, "8) Exit Program", 10, "Your Choice: "
    lenMenuMsg: equ $ - menuMsg

    askFirstDigitMessage: db "Enter first number (max 5 digits): "
    lenAskFirstDigitMessage: equ $-askFirstDigitMessage
    askSecondDigitMessage: db "Enter the second number (max 5 digits): "
    lenAskSecondDigitMessage: equ $-askSecondDigitMessage

    resultMessage: db "The result is: "
    lenResultMessage: equ $-resultMessage

    additionMessage: db "***** Addition *****", 10
    lenAdditionMessage: equ $-additionMessage
    substractionMessage: db 10,"***** Subtraction *****", 10
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
    firstDigit: resb 6
    secondDigit: resb 6
    result: resb 10

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
    read firstDigit, 6

    ; Ask user for the secondDigit
    print askSecondDigitMessage, lenAskSecondDigitMessage
    
    ; Ask user to enter his digit
    read secondDigit, 6
%endmacro

%macro askForOneDigit 0
    ; Ask user for the firstDigit
    print askFirstDigitMessage, lenAskFirstDigitMessage
    
    ; Ask user to enter his digit
    read firstDigit, 6
%endmacro

%macro print_result 1
    ; Print the result message
    print resultMessage, lenResultMessage
        
    ; Print the result digit
    print result, %1
%endmacro

section .text
    global _start

_start:
    ; Reset all variables before any operations
    mov ecx, 10 ; Length of variables
    lea edi, [result] 
    mov al, 0 
    rep stosb 
    mov ecx, 6 ; Length of variables
    lea edi, [firstDigit] 
    rep stosb
    lea edi, [secondDigit] 
    rep stosb

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

start_add:
    ; Convert number_one from string to integer
    mov esi, firstDigit
    call atoi
    mov ebx, eax ; store the integer value of number_one in ebx

    ; Convert number_two from string to integer
    mov esi, secondDigit
    call atoi

    add ebx, eax ; ebx = ebx - eax (number_one - number_two)
    mov eax, ebx

    ; Convert the result (ebx) back to string
    lea ecx, [result + 9]
    call itoa

    print_result 9
    jmp _start

subtraction:
    ; Show the substraction message
    print substractionMessage, lenSubstractionMessage
    askForTwoDigit
start_sub:
    ; Convert number_one from string to integer
    mov esi, firstDigit
    call atoi
    mov ebx, eax ; store the integer value of number_one in ebx

    ; Convert number_two from string to integer
    mov esi, secondDigit
    call atoi

    ; Subtract: number_two from number_one
    sub ebx, eax ; ebx = ebx - eax (number_one - number_two)
    mov eax, ebx

    ; Convert the result (eax) back to string
    lea ecx, [result + 9]
    call itoa
        
    print_result 9

    jmp _start

multiplication:
    ; Show the product message
    print productMessage, lenProductMessage
    askForTwoDigit

    ; Convert number_one from string to integer
    mov esi, firstDigit
    call atoi
    mov ebx, eax ; store the integer value of number_one in ebx

    ; Convert number_two from string to integer
    mov esi, secondDigit
    call atoi

    ; Multiply digit in EAX by EBX
    mul ebx

    ; Convert the result (eax) back to string
    lea ecx, [result + 9]
    call itoa

    print_result 9
    
    jmp _start

division:
    ; Show the division message
    print divisionMessage, lenDivisionMessage
    askForTwoDigit

    ; Convert number_one from string to integer
    mov esi, firstDigit
    call atoi
    mov ebx, eax ; store the integer value of number_one in ebx

    ; Convert number_two from string to integer
    mov esi, secondDigit
    call atoi

    ; Multiply: number_two and number_one
    mov edx, eax
    mov eax, ebx
    mov ebx, edx
    mov edx, 0x0
    div ebx

    ; Convert the result (EAX) back to string
    lea ecx, [result + 9]
    call itoa

    print_result 9

    jmp _start

modulo:
    ; Show the modulo message
    print moduloMessage, lenModuloMessage
    askForTwoDigit

    ; Convert number_one from string to integer
    mov esi, firstDigit
    call atoi
    mov ebx, eax ; store the integer value of number_one in ebx

    ; Convert number_two from string to integer
    mov esi, secondDigit
    call atoi

    ; Multiply: number_two and number_one
    mov edx, eax
    mov eax, ebx
    mov ebx, edx
    mov edx, 0x0
    div ebx

    mov eax, edx 

    ; Convert the result (EAX) back to string
    lea ecx, [result + 9]
    call itoa

    print_result 9

    jmp _start

increment:
    ; Show the increment message
    print incrementMessage, lenIncrementMessage
    askForOneDigit    

    ; Set second digit as one
    mov byte [secondDigit], '0'
    mov byte [secondDigit + 1], '0'
    mov byte [secondDigit + 2], '0'
    mov byte [secondDigit + 3], '0'
    mov byte [secondDigit + 4], '1'
    mov byte [secondDigit + 5], 0  ; Null-terminator
    
    mov esi, 4 ; Pointing to the rightmost digit
    mov ecx, 5 ; Number of digits to add
    clc ; Clear the carry flag
    
    jmp start_add

    ;jmp _start

decrement:
    ; Show the decrement message
    print decrementMessage, lenDecrementMessage
    askForOneDigit

    ; Set second digit as one
    mov byte [secondDigit], '0'
    mov byte [secondDigit + 1], '0'
    mov byte [secondDigit + 2], '0'
    mov byte [secondDigit + 3], '0'
    mov byte [secondDigit + 4], '1'
    mov byte [secondDigit + 5], 0  ; Null-terminator  

    jmp start_sub

exit:
    ; Exit the program
    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL


; Function for converting ASCII to integer
atoi:
    xor eax, eax ; Clear eax to store the result
    xor ecx, ecx ; Clear ecx, will use it for counting digits
atoi_loop:
    cmp ecx, 5 ; Check if we've read 5 digits
    jae atoi_done ; If yes, we're done
    movzx edx, byte [esi+ecx] ; Load the next byte of the string into edx
    cmp edx, '0' ; Check if the character is below '0'
    jb atoi_done ; If it is, we are done
    cmp edx, '9' ; Check if the character is above '9'
    ja atoi_done ; If it is, we are done
    sub edx, '0' ; Convert from ASCII to integer
    imul eax, eax, 10 ; Multiply the current result by 10 (shift left in decimal)
    add eax, edx ; Add the new digit
    inc ecx ; Move to the next character
    jmp atoi_loop
atoi_done:
    ret

; Function for converting integer to ASCII
itoa:
    test eax, eax
    jz itoa_zero ; Handle zero case

    mov ebx, 10 ; Divider set to 10 for decimal conversion
    mov edx, 0 ; Clear edx for division
itoa_loop:
    xor edx, edx ; Clear any previous remainder
    div ebx ; Divide eax by 10, result in eax, remainder in edx
    add dl, '0' ; Convert the remainder to an ASCII character
    dec ecx ; Move back in the buffer
    mov [ecx], dl ; Store the ASCII character
    test eax, eax ; Check if eax is zero now
    jnz itoa_loop ; If not, continue loop
    ret

itoa_zero:
    mov byte [ecx-1], '0' ; Just set the buffer to '0'
    ret