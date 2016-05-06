
.MODEL SMALL
.STACK 100H
.DATA


A   DB  50 DUP(10) 
N   DB  0    
SIZE    DW  ? 
D   DW  ?
SIGN    DB  0
PIVOT   dB  ?
I   DW  ?
HIGH    DW  ?
LOW     DW  ? 
J       DB  ?
TEMP    DW  ?        

.CODE  


OUTDEC PROC                ;PRINT FUNCTION
    ;INPUT AX
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
OUTDEC ENDP                 ;PRINT FUNCTION
  
  
PARTITION PROC
    
    MOV BX,HIGH 
    MOV AL,A[BX]
    MOV PIVOT,AL
    DEC I
    MOV BX,LOW


AAA:
    
    CMP BX,HIGH
    JGE LAST
    MOV AL,A[BX]
    CMP AL,PIVOT
    JG A2 
    
    INC I                               ;IF A[J]<PIVOT
    MOV AL,A[BX]                        ;I++
    MOV J,AL           ;J=A[J]          ;SWAP a[I]<>A[J]
    MOV TEMP,BX        ;TEMP=J
    MOV BX,I
    MOV AL,A[BX]       ;AX=A[I]
    MOV BX,TEMP
    MOV A[BX],AL       ;A[J]=A[I]
    MOV BX,I            


    MOV AL, J
    MOV A[BX],AL
A2:
    INC BX
    JMP AAA
    

LAST: 
    INC I                ;I++
    MOV BX,I             ;SWAP A[I]<>A[HIGH]
    MOV AL,A[BX]
    MOV BX,HIGH
    MOV A[BX],AL         ;A[HIGH]=A[I]
    MOV BX,I
    MOV AL,PIVOT
    MOV A[BX],AL          ;A[I]=A[HIGH]
    RET
    



PARTITION ENDP

QUICKSORT PROC

    PUSH BP
    MOV BP,SP
    MOV AX,[BP+6]       ;GET HIGH
    MOV HIGH,AX
    MOV AX,[BP+4]       ;GET LOW
    MOV LOW, AX
    MOV I,AX           ;PARTITION
    CMP AX,HIGH       ;K=N?
    JGE RETURN             ;YES NON RECURSIVE CASE
    

     
    CALL PARTITION

    MOV AX,I
    DEC AX
    PUSH AX
    PUSH LOW
    CALL QUICKSORT 
    
    
    MOV AX,[BP+6]
    MOV HIGH,AX
    MOV AX,I
    INC AX
    PUSH HIGH
    PUSH AX
    CALL QUICKSORT



RETURN:
    POP BP
    RET 4  
    RET
QUICKSORT ENDP

MAIN PROC
   
   
    mov ax,@data
    mov ds,ax


loop1:     
   
    
    
    MOV AH,1             ;INPUT N
    INT 21H    
    
    CMP AL,0DH
    JE  TASK 
    SUB AL,'0'  
   
    MOV BL,AL
    MOV AX,10
    IMUL N                 ;AX=N*AX
    MOV N,AL
    
    
    
    ADD n,BL
    JMP loop1            ;INPUT N

TASK:

    MOV DL,0DH             ;NEW LINE
    MOV AH,2
    INT 21H
    MOV DL,0AH
    MOV AH,2
    INT 21H    
    MOV CL,N 
    MOV CH,0  
    MOV SIZE,CX
    XOR BX,BX
    
    
TOP:    
    MOV N,0
    MOV SIGN,0
               

loop2:     
   
    
    
    MOV AH,1             ;INPUT NUMBERS
    INT 21H    
    
    CMP AL,' '
    JE  TASK2
    CMP AL,'-' 
    JE NEGA
    SUB AL,'0'  
    mov ah,0  
    MOV D,AX
    MOV AX,10
    IMUL N                 ;AX=N*AX
    MOV N,AL
    
    
    MOV DX,D
    ADD n,DL
    JMP loop2            ;INPUT NUMBERS
NEGA:
    MOV SIGN,1
    JMP LOOP2
TASK2:
    CMP SIGN,0
    JE NOW
    NEG N

NOW:
    MOV AL,N
    MOV A[BX],AL
    ADD BX,1
    LOOP TOP
    MOV CX,SIZE
    DEC SIZE
    PUSH SIZE
    PUSH 0
    CALL QUICKSORT
    MOV DL,0DH             ;NEW LINE
    MOV AH,2
    INT 21H
    MOV DL,0AH
    MOV AH,2
    INT 21H
    XOR BX,BX
PRINT:
    
    
    
    MOV AL,A[BX]
    MOV AH,0
    CALL OUTDEC
    INC BX
    MOV AH,2
    MOV DL,' '
    INT 21H
    LOOP PRINT
    
    MOV AH,4CH
    INT 21H
    
MAIN ENDP
    END MAIN         
    
                         
                         
                         
                         
                         
                         
                         
