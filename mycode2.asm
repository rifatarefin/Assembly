
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.MODEL SMALL
.STACK 100H
.DATA

    CR  EQU 0DH
    LF  EQU 0AH

MSG1    DB  'LOWER: $'
MSG2    DB  0DH,0AH,'UPPER: '
CHAR    DB  ?,'$'
N       DW  0

.CODE
MAIN PROC
   
   
   mov ax,@data
    mov ds,ax          
    
loop1:     

    
       
    
    
    MOV AH,1
    INT 21H
    CMP AL,0DH
    JE endloop 
    SUB AL,'0'  
    mov ah,0  
    
    MOV CX,9
    MOV BX,N
    
TOP:

    ADD BX,N
    LOOP TOP                  ;MULTIPLY 10
    
    MOV N,BX
    ADD n,ax
    JMP loop1
    
endloop:  
       
       
    
    MOV AH,4CH
    INT 21H
MAIN ENDP
    END MAIN






