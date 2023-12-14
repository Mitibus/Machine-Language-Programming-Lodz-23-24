; Functions
SYS_EXIT EQU 0x3c ; 60
SYS_WRITE EQU 0x01

; Standard Input / Output
STD_OUT EQU 0x01

section .data
    text: db "Hello World !", 0x0A ; Text to print, 0x0A represent Line Feed (\n)
    length: equ $ - text ; Length of the string we want to print

section .text

global _start

_start:
    mov rdx, length
    mov rsi, text
    mov rdi, STD_OUT ; std_out to screen
    mov rax, SYS_WRITE ; sys_write
    syscall

    mov rdi, 0 ; Exit code
    mov rax, SYS_EXIT ; sys_exit
    syscall