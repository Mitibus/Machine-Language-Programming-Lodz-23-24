section .data                           ;Data segment
    path: db '/home/students/mxmduc33/test.txt',0 ;Ask the user to enter a number
    lenPath: equ $-path             ;The length of the message
    
    ; Functions
    sys_call: equ 0x80
    sys_exit: equ 0x01
    sys_open: equ 0x05
    sys_read: equ 0x03
    sys_write: equ 0x04


section .bss
    data: resb 200
    lenData: resb 60

section .text          ;Code Segment
    global _start

_start:                ;User prompt
    mov eax, sys_read
    mov ebx, path
    mov ecx, 0
    int sys_call

    mov ebx, eax
    mov eax, sys_read
    mov ecx, data
    mov edx, lenData
    int sys_call

    mov esi, ebx
    mov eax, sys_write
    mov ebx, 1
    mov ecx, data
    mov edx, lenData
    int sys_call

    mov ebx, esi
    mov eax, sys_read
    mov ecx, data
    mov edx, lenData
    int sys_call

    mov esi, ebx
    mov eax, sys_write
    mov ebx, 1
    mov ecx, data
    mov edx, lenData
    int sys_call

    ; Exit code
    mov eax, sys_exit
    mov ebx, 0
    int sys_call