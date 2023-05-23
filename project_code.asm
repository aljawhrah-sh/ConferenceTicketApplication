.model small
.stack 100h
.data
msg1 db 0ah,"WELCOME To Health Conference Ticket Application$"     ;welcome 

msg2 db 0ah,0dh,"Choose the service you want",0ah,0dh,"  1-Book a ticket",0ah,0dh,"  2-Calculate the price",0ah,0dh,"  3-Exit the application ",0ah,0ah,0dh,"            $",  ;menu
     
      speaker_conference db 0AH,0DH, "Are you a A Speaker In The Conference, If Yes Please Enter 1 || if not enter 2 : $"      
            
            
 MSG3 db 0ah,0dh," The Ticket:             Price:",0ah,0dh,"1-Medical Student             300 SR",0ah,0dh,"2-Resident Doctor             500 SR",0ah,0dh,"3-Specialist Doctor            1300SR $" ; the menu 
MSG4 db 0ah,0dh,"Please Select a Ticket:$" ;
MSG5 db 0ah,0dh,"How many Tickets :$" ; 
MSG6 db 0ah,0dh,"Price of your ticket is $" ; 
MSG9 db 0ah,0dh,"Thanks for using our Application :)$" ; 



a DW 300
b DW 500
C DW 1300
Tatal_number dd ?

.code  
main proc
MOV AX,@DATA
MOV DS,AX 

 start: 
 
 ; here main menu print
 
              
mov ah, 9            ;display welcome
lea dx, msg1
int 21h
         
repeat:        
mov ah, 9            ;display mune
lea dx, msg2
int 21h  

mov ah, 1            ;scanner
int 21h

cmp al, "1"          ;swich
 
je ticket 
 
cmp al, "2"          

je choice2
 
cmp al, "3"          
je exit



ticket:

;----------------------------------------
choice1: 
MOV ah,9    ;display a menu
LEA DX,MSG3
INT 21H

MOV ah,9    ;display a choice
LEA DX,MSG4
INT 21H

MOV AH,1; The uesr choice The Ticket 
INT 21H      
;------------------------------------------      
      
 
CMP AL,"1"              ;Swich
je Medical_Student

CMP AL,"2"
je Resident_Doctor

CMP AL,"3"
je Specialist_Doctor

;-------------------------------------------
Medical_Student: 

MOV ah,9    ;display count 
LEA DX,MSG5
INT 21h

MOV ah,1; number of Ticket
INT 21H

SUB AL,30H
MOV AH,0

MUL a
ADD Tatal_number,AX 
mov bx, ax
 MOV ah,9    ;display count 
LEA DX,MSG6
INT 21h

MOV AX,bx
CALL OUTDEC  
 jmp  choice2
 
 ;-----------------------------------------

Resident_Doctor:

MOV ah,9    ;display count 
LEA DX,MSG5
INT 21h

MOV ah,1; number of Ticket
INT 21H

SUB AL,30H
MOV AH,0

MUL b
ADD Tatal_number,AX 
mov bx, ax
 MOV ah,9    ;display count 
LEA DX,MSG6
INT 21h

MOV AX,bx
CALL OUTDEC  
 jmp  choice2 
 ;----------------------------------------------
Specialist_Doctor:

MOV ah,9    ;display count 
LEA DX,MSG5
INT 21h

MOV ah,1; number of Ticket
INT 21H

SUB AL,30H
MOV AH,0

MUL c
ADD Tatal_number,AX 
mov bx, ax
 MOV ah,9    ;display count 
LEA DX,MSG6
INT 21h

MOV AX,bx
CALL OUTDEC 
exit:
MOV ah,9    ;display count 
LEA DX,MSG9
INT 21h
   mov ah, 4ch 
   int 21h 
        




 choice2:
MOV AH,9    ;display if she/he speaker is in the conference 
LEA DX,speaker_conference
INT 21h

mov AH ,1
int 21h  
cmp al,"1"
je discount 
cmp al ,"2"
je exit


  
 discount :      ;display the bill after discount
mov ax , Tatal_number
mov cl ,2h
div cl
mov Tatal_number , ax 
mov ah,9
lea dx,MSG6
int 21h   
mov AX,Tatal_number
CALL OUTDEC 
 

jmp start 
  ;--------------------------------------------------------
   exit2:
    MOV ah,9    ;display count 
LEA DX,MSG9
INT 21h
   mov ah, 4ch 
   int 21h
jmp  repeat 
MAIN ENDP

 
 


  
 
 ;----------------------------------------------------------                
 
 


 


OUTDEC PROC    ; Display the decimal number in registrs AX to output screen
PUSH AX
PUSH BX
PUSH CX
PUSH DX
OR AX,AX
JGE @END_IF1
PUSH AX
MOV DL,'-'
MOV AH,2
INT 21H
POP AX
NEG AX
@END_IF1:
XOR CX,CX
MOV BX,10D
@REPEAT1:
XOR DX,DX
DIV BX
PUSH DX
INC CX
OR AX,AX
JNE @REPEAT1
MOV AH,2
@PRINT_LOOP:
POP DX
OR DL,30H
INT 21H
LOOP @PRINT_LOOP
POP DX
POP CX
POP BX
POP AX

RET
OUTDEC ENDP


END MAIN