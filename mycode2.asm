
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.MODEL SMALL
.STACK 100H
.DATA

    CR  EQU 0DH
    LF  EQU 0AH

RESULT    DB    ?,'$'
MSG2    DB  0DH,0AH,'UPPER: '
CHAR    DB  ?,'$'
N       DW  0

.CODE
MAIN PROC
   
   
   mov ax,@data
    mov ds,ax
    mov es,ax          
    
   
    
       
      
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






