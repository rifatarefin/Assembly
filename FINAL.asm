
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.MODEL SMALL
.STACK 100H
.DATA

    

RESULT     DB  ?,'$'
STR1    DW  0              ;main binary
TMP     DW  0              ;remainder
CHAR    DW  0              ;no of bits
N       DW  0              ;input
SIGN    DB  0
 


.CODE
MAIN PROC
   
   
    mov ax,@data
    mov ds,ax 
      
    MOV AH,1
    INT 21H
    CMP AL,'-'
    JNE Q2 
    MOV SIGN,1
      
loop1:     
   
    
    
    MOV AH,1             ;INPUT
    INT 21H

Q2:    
    
    CMP AL,0DH
    JE  TASK 
    SUB AL,'0'  
    mov ah,0  
    MOV BX,AX
    MOV AX,10
    IMUL N                 ;AX=N*AX
    MOV N,AX
    
    
    
    ADD n,BX
    JMP loop1            ;INPUT
   
   
   
   
TASK:   
    
    CMP N,0
    JE ZERO
    CMP SIGN,1              ;check sign
    JNE TASK2
    NEG N       
    
TASK2:

    CMP N,0
    JE endloop


    MOV AX,N
    CWD
    MOV BX,-2
    IDIV BX                ;AX HOLDS RESULT,DX REMAINDER


    MOV N,AX                ;N=N/-2
    MOV TMP,DX              ;TMP=N%-2
    
    CMP TMP,0
    JGE THEN
    INC N
    ADD TMP,2
    
THEN:    
    MOV AX,2
    IMUL STR1                ;AX=2*STR1
    ADD AX,TMP
    MOV STR1,AX
    INC CHAR        
    JMP TASK2
    
endloop:  
   
    MOV CX,CHAR
    MOV DL,0DH
    MOV AH,2
    INT 21H
    MOV DL,0AH
    MOV AH,2
    INT 21H
       
PRINT:
    
    MOV AX,STR1
    TEST AX,1
    JNZ SKIP
    MOV DL,'0'
    MOV AH,2
    INT 21H
    JMP FIN
    
SKIP:

    MOV DL,'1'
    MOV AH,2
    INT 21H
    
FIN:
     
    SHR str1,1
    LOOP PRINT
    jmp END 
    
ZERO:
    
    MOV DL,0DH
    MOV AH,2
    INT 21H
    MOV DL,0AH
    MOV AH,2
    INT 21H
    MOV DL,'0'
    MOV AH,2
    INT 21H
    
end:

    MOV AH,4CH
    INT 21H
MAIN ENDP
    END MAIN






