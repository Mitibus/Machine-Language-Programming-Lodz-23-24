; Functions
SYS_EXIT EQU 0x01
SYS_READ EQU 0x03
SYS_WRITE EQU 0x04
SYS_CALL EQU 0x80
SYS_CHDIR EQU 0x0c
SYS_GETCWD EQU 0xb7

; Standard Input / Output
STD_OUT EQU 0x01
STD_INP EQU 0X02

section .data
    msg: db "Current folder : "
    lenMsg: equ $-msg
    askMsg: db 10, "Enter the new directory path: "
    lenAskMsg: equ $-askMsg

section .bss
    dir: resb 256

section .text
    global _start

_start:
    call    printCurrentDir

    ; Ask the user for the new directory
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, askMsg
    mov edx, lenAskMsg
    int SYS_CALL

    mov eax, SYS_READ
    mov ebx, STD_INP
    mov ecx, dir
    mov edx, 256
    int SYS_CALL

    sub eax, 1
    mov byte [dir+eax], 0

    ; Change directory
    mov eax, SYS_CHDIR
    mov ebx, dir
    int SYS_CALL

    call    printCurrentDir

    mov eax, SYS_EXIT
    mov ebx, 0
    int SYS_CALL

printCurrentDir:
    mov edi, dir  ; Address of the buffer
    mov ecx, 256 ; Length of the buffer
    xor eax, eax       ; Zero out EAX because STOSB uses AL
    rep stosb          ; Repeat STOSB ECX times, setting each byte to AL (0)

    mov eax, SYS_GETCWD
    mov ebx, dir
    mov ecx, 256
    int SYS_CALL

    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg
    mov edx, lenMsg
    int SYS_CALL

    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, dir
    mov edx, 256
    int SYS_CALL

    ret