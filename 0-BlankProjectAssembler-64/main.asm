; Functions
SYS_EXIT EQU 0x3c ; 60
SYS_WRITE EQU 0x01

; Standard Input / Output
STD_OUT EQU 0x01

section .data
    ; Constant

section .bss
    ; Variables

section .text
    global _start

_start:
    ; Instructions Here

    ; Exit the program
    mov rdi, 0
    mov rax, SYS_EXIT
    syscall