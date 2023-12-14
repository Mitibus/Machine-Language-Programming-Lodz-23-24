; Functions
SYS_EXIT EQU 0x01
SYS_READ EQU 0x03
SYS_WRITE EQU 0x04
SYS_CALL EQU 0x80

; Standard Input / Output
STD_OUT EQU 0x01
STD_INP EQU 0X02

section	.data
    name: db 'Zara   Ali '

section	.text
   global _start        ;must be declared for linker (ld)

_start:                 ;tell linker entry point	
   ;writing the name 'Zara Ali'
    mov edx, 11         ;message length
    mov ecx, name       ;message to write
    mov ebx, STD_OUT    ;file descriptor (stdout)
    mov eax, SYS_WRITE  ;system call number (sys_write)
    int SYS_CALL        ;call kernel
	
    mov [name], dword 'Maxi'    ; Changed the name to Nuha Ali
    mov [name+4], dword 'me'
	
   ;writing the name 'Maxime Ali'
    mov edx, 10         ;message length
    mov ecx, name       ;message to write
    mov ebx, STD_OUT    ;file descriptor (stdout)
    mov eax, SYS_WRITE  ;system call number (sys_write)
    int SYS_CALL        ;call kernel
	
    mov eax, SYS_EXIT   ;system call number (sys_exit)
    mov ebx, 0
    int SYS_CALL        ;call kernel