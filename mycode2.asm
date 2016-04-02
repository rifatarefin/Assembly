
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.MODEL SMALL
.STACK 100H
.DATA

STRING1 DB '$ASSEMBLY LANGUAGE'
LENGTH  DW  17

RESULT    DB   ?

CHAR    DB  ?,'$'
N       DW  0

.CODE
MAIN PROC
   
   
   mov ax,@data
    mov ds,ax
    mov es,ax 
    MOV SI, OFFSET STRING1   ;REVERSE
    MOV CX,LENGTH
    ADD SI,CX
    
BACK:

    MOV DL,[SI]
    MOV AH,02H
    INT 21H
    DEC SI
    LOOP BACK                 ;REVERSE
    
   
    
       
      
endloop:  
       
   LEA DI,RESULT
   CLD 
   MOV AL,'A'
   STOSB
   STOSB
   LEA DX,RESULT
   MOV AH,9
   INT 21H   
    
    MOV AH,4CH
    INT 21H
MAIN ENDP
    END MAIN






