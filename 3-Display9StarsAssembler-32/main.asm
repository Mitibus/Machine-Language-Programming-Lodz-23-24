; Functions
SYS_EXIT EQU 0x01
SYS_WRITE EQU 0x04
SYS_CALL EQU 0x80

; Standard Output
STD_OUT EQU 0x01

section	.data
    msg: db 'Displaying 9 stars',0xa ;a message
    len_msg: equ $ - msg  ;length of message

    name: db 0xa,0x4d,0x61,0x78,0x69,0x6d,0x65,0xa ; Name message
    len_name: equ $ - name ; length of name

    randomMessage: db 'Hello World again!', 0xa
    len_randomMessage: equ $ - randomMessage ; length of randomMessage

    s2: times 9 db '*'
    len_s2: equ $ - s2

section	.text
    global _start	 ;must be declared for linker (gcc)
	
_start:                 ;tell linker entry point
    mov	edx, len_msg    ;message length
    mov	ecx, msg        ;message to write
    mov	ebx, STD_OUT    ;file descriptor (stdout)
    mov	eax, SYS_WRITE  ;system call number (sys_write)
    int	SYS_CALL        ;call kernel
	
    mov	edx, len_s2     ;message length
    mov	ecx, s2         ;message to write
    mov	ebx, STD_OUT    ;file descriptor (stdout)
    mov	eax, SYS_WRITE  ;system call number (sys_write)
    int	0x80            ;call kernel

    mov edx, len_name   ; message length
    mov ecx, name       ; Name
    mov ebx, STD_OUT    ; stdout
    mov eax, SYS_WRITE  ; sys_write
    int SYS_CALL        ; syscall 

    mov edx, len_randomMessage ; message length
    mov ecx, randomMessage ; Name
    mov ebx, STD_OUT    ; stdout
    mov eax, SYS_WRITE  ; sys_write
    int SYS_CALL        ; syscall 
	
    mov	eax, SYS_EXIT   ;system call number (sys_exit)
    mov ebx, 0          ; Exit code
    int	SYS_CALL        ;call kernel