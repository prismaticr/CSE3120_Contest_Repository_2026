INCLUDE Irvine32.inc
.386
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
balance DWORD 100 ; how much the player starts with

; message to explain game and rules
greet BYTE "Welcome to the Casino! Where money is pratically free! ", 0Dh, 0Ah
   BYTE "You're current balance is: ", 0
greet2 BYTE 0Dh, 0Ah, "Type g to gamble or l to leave if you're a coward! "
buffer BYTE 1 DUP(?), 0

.code
main PROC

; greeting message
MOV EDX, OFFSET greet
call WriteString

; output balance
MOV EAX, balance
call WriteDec

; start game options (start with 2: gamble or leave)
MOV EDX, OFFSET greet2
call WriteString

INVOKE ExitProcess,0
main ENDP
END main