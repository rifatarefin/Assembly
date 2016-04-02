
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.MODEL SMALL
.STACK 100H
.DATA

    

RESULT     DB  ?,'$'
CHAR    DB  '$'
N       DW  0   

STRING1 DB '$ASSEMBLY LANGUAGE'
LENGTH  DW  17

.CODE
MAIN PROC
   
   
   mov ax,@data
    mov ds,ax 
    MOV ES,AX  
    
    
   ;MOV SI, OFFSET STRING1   ;REVERSE
;    MOV CX,LENGTH
;    ADD SI,CX
;    
;BACK:
;
;    MOV DL,[SI]
;    MOV AH,02H
;    INT 21H
;    DEC SI
;    LOOP BACK                 ;REVERSE
;    
;    
;    
;   LEA DI,RESULT            ;STRCOPY
;   CLD 
;   MOV AL,'A'
;   STOSB
;   MOV AL,'V'
;   STOSB
;   LEA DX,RESULT
;   MOV AH,9
;   INT 21H                   ;STRCPY
    
loop1:     

    
       
    
    
    MOV AH,1             ;INPUT
    INT 21H
    CMP AL,0DH
    JE endloop 
    SUB AL,'0'  
    mov ah,0  
    MOV BX,AX
    MOV AX,10
    IMUL N 
    MOV N,AX
    
    
    
    ADD n,BX
    JMP loop1            ;INPUT
    
endloop:  
    
    
       
       
    
    MOV AH,4CH
    INT 21H
MAIN ENDP
    END MAIN






