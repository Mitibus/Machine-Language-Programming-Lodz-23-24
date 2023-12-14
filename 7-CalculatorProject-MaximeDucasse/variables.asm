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