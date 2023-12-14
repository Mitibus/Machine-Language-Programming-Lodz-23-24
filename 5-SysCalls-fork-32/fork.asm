; Functions
SYS_EXIT EQU 0x01
SYS_READ EQU 0x03
SYS_CALL EQU 0x80
SYS_FORK EQU 0x02

; Standard Input / Output
STD_INP EQU 0X02

section .bss
    null_buffer: resb 2

section .text
    global _start

_start:
    mov eax, SYS_FORK
    int SYS_CALL
    
    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, null_buffer
    mov edx, 2
    int SYS_CALL    

    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL

; Check process for a user with PID
; pstree -u mxmduc33 -pu 