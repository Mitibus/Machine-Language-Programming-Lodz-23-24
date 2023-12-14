; Functions
SYS_EXIT EQU 0x01
SYS_READ EQU 0x03
SYS_WRITE EQU 0x04
SYS_CALL EQU 0x80

; Standard Input / Output
STD_OUT EQU 0x01
STD_INP EQU 0X02

section .data                           ;Data segment
   userMsg: db 'Please enter a number: ' ;Ask the user to enter a number
   lenUserMsg: equ $-userMsg             ;The length of the message
   dispMsg: db 'You have entered: '
   lenDispMsg: equ $-dispMsg
   userMsg2: db 'Please enter a second number: '
   lenUserMsg2: equ $-userMsg2
   dispMsg2: db 'You have entered as second number: '
   lenDispMsg2: equ $-dispMsg2

section .bss           ;Uninitialized data
   num: resb 5
   num2: resb 5
	
section .text          ;Code Segment
   global _start
	
_start:                ;User prompt
   mov eax, SYS_WRITE
   mov ebx, STD_OUT
   mov ecx, userMsg
   mov edx, lenUserMsg
   int SYS_CALL

   ;Read and store the user input
   mov eax, SYS_READ
   mov ebx, STD_INP
   mov ecx, num  
   mov edx, 5          ;5 bytes (numeric, 1 for sign) of that information
   int SYS_CALL
	
   mov eax, SYS_WRITE
   mov ebx, STD_OUT
   mov ecx, userMsg2
   mov edx, lenUserMsg2
   int SYS_CALL

   ; Ask for the second number
   mov eax, SYS_READ
   mov ebx, STD_INP
   mov ecx, num2
   mov edx, 5
   int SYS_CALL

   ;Output the message 'The entered number is: '
   mov eax, SYS_WRITE
   mov ebx, STD_OUT
   mov ecx, dispMsg
   mov edx, lenDispMsg
   int SYS_CALL 

   ;Output the number entered
   mov eax, SYS_WRITE
   mov ebx, STD_OUT
   mov ecx, num
   mov edx, 5
   int SYS_CALL  

   mov eax, SYS_WRITE
   mov ebx, STD_OUT
   mov ecx, dispMsg2
   mov edx, lenDispMsg2
   int SYS_CALL 

   mov eax, SYS_WRITE
   mov ebx, STD_OUT
   mov ecx, num2
   mov edx, 5
   int SYS_CALL 
    
   ; Exit code
   mov eax, SYS_EXIT
   mov ebx, 0
   int SYS_CALL