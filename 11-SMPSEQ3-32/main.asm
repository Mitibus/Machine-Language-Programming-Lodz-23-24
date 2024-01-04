section .data
    S db 2, 1, 10, 11, 14   ; Example array S
    n equ 5                ; Length of array S
    Q db 2, 3, 10, 14, 20, 30 ; Example array Q
    m equ 6                ; Length of array Q
    space db ' ', 0        ; Space character for separation

section .bss
    num resb 12            ; Reserve 12 bytes for number string (including sign and null)

section .text
global main

main:
    xor esi, esi           ; Index for array S
    xor edi, edi           ; Index for array Q

    ; Loop through each element in S
    loop_S:
        cmp esi, n
        jge end_loop       ; End loop if we've processed all elements of S

        ; Compare elements of S and Q
        movzx eax, byte [S + esi]
        movsx eax, al       ; Sign-extend the byte to a dword
        movzx ebx, byte [Q + edi]
        movsx ebx, bl       ; Sign-extend the byte to a dword
        cmp eax, ebx
        je equal            ; If elements are equal, jump to 'equal' label
        jl not_in_Q         ; If element in S is less, it's not in Q

        ; Increment Q index and loop
        inc edi
        cmp edi, m
        jl loop_S           ; Loop if there are more elements in Q

        ; If all elements in Q are processed, print remaining in S
        jmp print_remaining_S

    not_in_Q:
        ; Print the element as it's not in Q
        push eax            ; Save EAX
        lea ecx, [num]      ; Load address of num buffer
        call int_to_string

        ; Write the number string
        mov eax, 4          ; sys_write
        mov ebx, 1          ; File descriptor (stdout)
        pop ecx             ; Restore EAX into ECX
        lea ecx, [num]      ; Load address of num buffer
        call str_len
        mov edx, eax        ; Number of bytes to write
        int 0x80

        ; Write a space
        mov eax, 4          ; sys_write
        mov ebx, 1          ; File descriptor (stdout)
        mov ecx, space      ; Address of space character
        mov edx, 1          ; Number of bytes to write
        int 0x80

        ; Increment S index and loop
        inc esi
        jmp loop_S

    equal:
        ; Increment both indexes and loop
        inc esi
        inc edi
        jmp loop_S

    print_remaining_S:
        ; Print elements in S that are left
        movzx eax, byte [S + esi]
        movsx eax, al       ; Sign-extend the byte to a dword
        push eax            ; Save EAX
        lea ecx, [num]      ; Load address of num buffer
        call int_to_string

        ; Write the number string
        mov eax, 4          ; sys_write
        mov ebx, 1          ; File descriptor (stdout)
        pop ecx             ; Restore EAX into ECX
        lea ecx, [num]      ; Load address of num buffer
        call str_len
        mov edx, eax        ; Number of bytes to write
        int 0x80

        ; Write a space
        mov eax, 4          ; sys_write
        mov ebx, 1          ; File descriptor (stdout)
        mov ecx, space      ; Address of space character
        mov edx, 1          ; Number of bytes to write
        int 0x80

        inc esi
        cmp esi, n
        jl print_remaining_S

    end_loop:
        ; Exit program
        mov eax, 1          ; syscall number for sys_exit
        xor ebx, ebx        ; Return 0 status
        int 0x80

; Convert integer to string
; Input: EAX = integer
; Output: string in [num]
int_to_string:
    push ebx
    push edx

    mov ebx, ecx          ; EBX = Pointer to output buffer
    mov edx, 10           ; EDX = Decimal base

    ; Handle negative numbers
    test eax, eax
    jns skip_neg          ; Jump if number is non-negative
    neg eax
    mov byte [ebx], '-'
    inc ebx

    skip_neg:
    ; Convert integer to string
    call reverse_convert
    add ebx, eax
    mov byte [ebx], 0     ; Null-terminate the string

    pop edx
    pop ebx
    ret

; Helper function to convert integer to string in reverse
reverse_convert:
    push eax
    xor ecx, ecx          ; ECX = Counter for number of digits

    convert_loop:
        xor edx, edx      ; Clear EDX for 'div'
        div edx           ; EAX = EAX / 10, EDX = EAX % 10
        add dl, '0'       ; Convert to ASCII
        dec ebx
        mov [ebx], dl
        inc ecx
        test eax, eax
        jnz convert_loop  ; Repeat if EAX is not zero

    pop eax
    mov eax, ecx         ; Return the length of the number string
    ret

; Calculate length of null-terminated string
; Input: ECX = address of string
; Output: EAX = length of string (excluding null)
str_len:
    push ecx
    xor eax, eax         ; EAX = 0 (length counter)

    count_loop:
        cmp byte [ecx], 0
        je end_count      ; End loop if null terminator is found
        inc ecx
        inc eax
        jmp count_loop

    end_count:
    pop ecx
    ret
