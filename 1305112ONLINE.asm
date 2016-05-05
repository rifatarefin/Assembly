

.MODEL SMALL

.STACK 100H

.DATA
RES	DW	?        ;MAIN FIBO
RES2	DW	?        ;DIV    
PRIME	DW	?        ;FLAG
N	DW	0
I	DW	1
NUM	DW	3
CHAR 	DW	0
TEMP    dw	?  
cnt     dw  0 
TEL DW  ?

.CODE

MAIN PROC
    MOV  AX,@DATA
    MOV DS,AX

loop1:     
   
    
    
    MOV AH,1             ;INPUT
    INT 21H    
    
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
    
    MOV AH,1             ;INPUT
    INT 21H 
    MOV AH,0
    MOV TEL,AX
    
    MOV BX,N
    CMP I,BX
    JG END3
    
    MOV DL,0DH
    MOV AH,2
    INT 21H
    MOV DL,0AH
    MOV AH,2
    INT 21H

    MOV AX,NUM            ;N=5
    PUSH AX
    
    CALL FIBO       ;AX=RESULT  
    MOV RES,AX

    CALL ISPRIME

    CMP PRIME,1
    JNE UNDO
    INC I
    call dprint
    
   
    

    
    
 
UNDO:
    INC NUM
    JMP TASK   
    
END3:    
    MOV AH,4CH
    INT 21H             ;DOS EXIT
    
    MAIN ENDP

FIBO PROC NEAR
    PUSH BP
    MOV BP,SP
    MOV AX,[BP+4]       ;GET N
    
    CMP AX,3       
    JLE THEN             ;YES NON RECURSIVE CASE
    JMP ELSE_            
    	                ;NO, RECURSIVE CASE
    
  THEN:
    
    CMP AX,3
    JL  AAB
    MOV AX,2
    JMP RETURN
  
  AAB:
    MOV AX,1
    
    JMP RETURN
  
  
    
    ELSE_: 
    
    ;COMPUTE FIBO(N-1)             
    
    MOV CX,[BP+4]       ; GET N
    DEC CX              ;N-1
    PUSH CX             ;SAVE N-1
    CALL FIBO       ;RESULT1 IN AX
    PUSH AX             ;SAVE RESULT1
        
        
    ;COMPUTE FIBO(N-2)    
    MOV CX,[BP+4]      ;SAVE K
    DEC CX             ;K-1
    DEC CX
    PUSH CX            ;SAVE K-1
    CALL FIBO      ;RESULT2 IN AX  
    PUSH AX 
    
    ;COMPUTE FIBO(N-3) 
    
    MOV CX,[BP+4]      ;SAVE K
    DEC CX             ;K-1
    DEC CX
    DEC CX
    PUSH CX            ;SAVE K-1 
    CALL FIBO
    
    ;;;;;;;;;
   
    POP BX             ;GET RESULT1
    ADD AX,BX          ;RESULT = RESULT1+RESULT2 
    POP BX
    ADD AX,BX
    
    RETURN:
    POP BP             ;RESTORE BP
    RET 2              ; RETURN AND DISCARD N AND K       
    
FIBO ENDP

ISPRIME PROC NEAR

    MOV RES2,AX
    MOV CX,2
    CMP AX,2
    JL END1
    MOV PRIME,1
DIV:

    MOV AX,CX
    MUL CX
    CMP AX,RES2
    JG END2
    MOV AX,RES2
    CWD 
    DIV CX
    CMP DX,0
    JE END1
    INC CX
    JMP DIV

END1:

    MOV PRIME,0

END2:
    RET    
	     
ISPRIME ENDP

DPRINT PROC NEAR
    MOV DL,0AH
    MOV AH,2                 ;SPACE
    INT 21H 
    MOV BX,10                ;DIVIDE BY 10
    MOV AX,res                 ;L=NUMBER TO BE DISPLAYED
    MOV  CNT,0               ;CNT=DIGIT NUMBER
CYCLE:       
  MOV  DX,0 
  DIV  BX 
  PUSH DX 
  INC CNT                    ;AX=QUO,DX=REM
  CMP  AX,0 
  JE PRINT 
  JMP CYCLE
       
PRINT:
  POP DX
  ADD DL,48                  ;POP FROM STACK AND MAKE IT A DIGIT
  MOV AH,2
  INT 21H
  DEC CNT
  CMP CNT,0
  JLE PRINT_SPACE
  JMP PRINT 
PRINT_SPACE: 
  RET
  
DPRINT ENDP
	     

END MAIN