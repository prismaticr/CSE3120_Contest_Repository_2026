INCLUDE Irvine32.inc
.386
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
balance DWORD 100 ; how much the player starts with

; message to explain game and rules
greet BYTE "Welcome to the Casino! Where money is pratically free! ", 0Dh, 0Ah, 0
balStatement BYTE "You're current balance is: ", 0
greet2 BYTE 0Dh, 0Ah, "Type g to gamble or l to leave if you're a coward! "
buffer BYTE 2 DUP(?), 0 ; has to one bigger than expected size

betMessage1 BYTE "Your bet is placed!", 0Dh, 0Ah, 0
rand DWORD ?

exitMessage BYTE "I hope you come back again!", 0Dh, 0Ah, 0

.code
main PROC

; greeting message
MOV EDX, OFFSET greet
call WriteString

betLoop:
   ; output balance
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
   ; take balance and use as bet
   MOV EAX, balance
   
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
loseBet:

; exit 
endloop:
   ; exit statment
   exit

INVOKE ExitProcess,0
main ENDP
END main