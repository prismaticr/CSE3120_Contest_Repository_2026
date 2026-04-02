INCLUDE Irvine32.inc
.386
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
balance DWORD 100 ; how much the player starts with

; message to explain game and rules
greet BYTE "Welcome to the Casino! Where money is pratically free! ", 0Dh, 0Ah
   BYTE "We'll give you 100 dollars to start for free (*^_^*)", 0Dh, 0Ah, 0
balStatement BYTE "You're current balance is: ", 0
greet2 BYTE 0Dh, 0Ah, "Type g to gamble or l to leave if you're a coward! ", 0
buffer BYTE 2 DUP(?), 0 ; has to one bigger than expected size

betMessage1 BYTE "Your bet is placed!", 0Dh, 0Ah, 0
rand DWORD ?

betMessageW BYTE "YOU WON!!! \(@^0^@)/", 0Dh, 0Ah, 0

betMessageL BYTE "Ermmm... You lost it all lol", 0Dh, 0Ah
   BYTE "Anyway, come back when you ain't broke", 0Dh, 0Ah, 0

exitMessage BYTE "Don't forget to come back!! :)", 0Dh, 0Ah, 0

.code
main PROC

; greeting message
MOV EDX, OFFSET greet
call WriteString

betLoop:
   ; output balance
   MOV EDX, OFFSET balStatement
   call WriteString
   
   MOV EAX, balance
   call WriteDec

   ; start game options (start with 2: gamble or leave)
   MOV EDX, OFFSET greet2
   call WriteString

   ; take input
   MOV EDX, OFFSET buffer ; point to buffer
   MOV ECX, LENGTHOF buffer - 1
   CALL Readstring

   MOV esi, 0 ; 

   cmp buffer[ESI], 0
   je endloop
   cmp buffer[ESI], 'g' ;
   JNE endloop

   jmp workLoop

; work
workLoop:
   
   ; notify player
   MOV EDX, OFFSET betMessage1
   CALL WriteString ; Maybe also print new balance
   
   ; run calculation
   ; placeholder
   MOV rand, 0
   
   ; win lose branch
   PUSH ESI
   MOV ESI, 0
   CMP ESI, rand
   POP ESI
   
   JZ  winBet
   JMP loseBet
winBet:
   ; balance is updated
   PUSH EAX
   MOV EAX, balance
   SHL EAX, 1 ; multiply by 2
   ADD EAX, EAX ; double amount
   MOV balance, EAX
   POP EAX
   
   MOV EDX, OFFSET betMessageW
   CALL WriteString
   ; change color of screen on win
   
   ; sent back to bet loop
   JMP betLoop

loseBet:
   MOV balance, 0 ; remove balance
   
   MOV EDX, OFFSET betMessageL
   CALL WriteString
   
   ; JMP betLoop
   JMP endloop

; exit 
endloop:
   ; exit statement
   MOV EDX, OFFSET exitMessage
   call WriteString
   exit

INVOKE ExitProcess,0
main ENDP
END main