%define SYS_CALL 0x80
%define STD_OUT 0x01
%define SYS_WRITE 0x4

section .data
    ; Constant section
    ask_no: db "Enter the first number (max 5 digits): ", 0
    len_no: equ $ - ask_no
    ask_nt: db "Enter the second number (max 5 digits): ", 0
    len_nt: equ $ - ask_nt
    msg_result: db "The result is: ", 0
    len_result: equ $ - msg_result
    
    number_one db "64567"
    number_two db "34265"

section .bss
    ; Variable section
    result resb 6

%macro print 2
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, %1
    mov edx, %2
    int SYS_CALL
%endmacro

section .text
    global main

main:
    mov ebp, esp; for correct debugging
    ; Convert number_one from string to integer
    mov esi, number_one
    call atoi
    mov ebx, eax ; store the integer value of number_one in ebx

    ; Convert number_two from string to integer
    mov esi, number_two
    call atoi

    ; Subtract: number_two from number_one
    sub ebx, eax ; ebx = ebx - eax (number_one - number_two)
    mov eax, ebx

    ; Convert the result (ebx) back to string
    lea ecx, [result + 5]
    call itoa
        
    print result, 5

    ; Exit the program
    mov	eax,1       ;system call number (sys_exit)
    mov ebx,0
    int	0x80        ;call kernel

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

