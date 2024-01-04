%include "system_functions.asm"

section .data
    ; Constant section
    ask_no: db "Enter the first number (max 5 digits): ", 0
    len_no: equ $ - ask_no
    ask_nt: db "Enter the second number (max 5 digits): ", 0
    len_nt: equ $ - ask_nt
    msg_result: db "The result is: ", 0
    len_result: equ $ - msg_result

section .bss
    ; Variable section
    number_one resb 6
    number_two resb 6
    result resb 6

section .text
    global _start

_start:
    ; Read first number
    print ask_no, len_no
    read number_one, 6

    ; Read second number
    print ask_nt, len_nt
    read number_two, 6    

    ; Convert number_one from string to integer
    mov esi, number_one
    call atoi
    mov ebx, eax ; store the integer value of number_one in ebx

    ; Convert number_two from string to integer
    mov esi, number_two
    call atoi

    ; Subtract: number_two from number_one
    sub ebx, eax ; ebx = ebx - eax (number_one - number_two)

    ; Convert the result (ebx) back to string
    mov ecx, result ; buffer to store the string result
    call itoa

    ; Print the result
    print msg_result, len_result
    print result, 6

    ; Exit the program
    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL

atoi:
    xor eax, eax ; Clear eax to store the result
    xor ecx, ecx ; Clear ecx, will use it for the multiplication factor (decimal place value)
atoi_loop:
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


itoa:
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
