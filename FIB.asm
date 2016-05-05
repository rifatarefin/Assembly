

.MODEL SMALL

.STACK 100H

.CODE

MAIN PROC
    MOV AX,6            ;N=5
    PUSH AX
    
    CALL FIBO       ;AX=RESULT
    MOV AH,4CH
    INT 21H             ;DOS EXIT
    
    MAIN ENDP

FIBO PROC NEAR
    PUSH BP
    MOV BP,SP
    MOV AX,[BP+4]       ;GET N
    
    CMP AX,1       
    JLE THEN             ;YES NON RECURSIVE CASE
    JMP ELSE_            
    	                ;NO, RECURSIVE CASE
    
    THEN:
    
    JMP RETURN
  
  
    
    ELSE_: 
    
    ;COMPUTE FIBO(N-1)             
    
    MOV CX,[BP+4]       ; GET N
    DEC CX              ;N-1
    PUSH CX             ;SAVE N-1
    CALL FIBO       ;RESULT1 IN AX
    PUSH AX             ;SAVE RESULT1
        
        
    ;COMPUTE C(N-1,K-1)    
    MOV CX,[BP+4]      ;SAVE K
    DEC CX             ;K-1
    DEC CX
    PUSH CX            ;SAVE K-1
    CALL FIBO      ;RESULT2 IN AX
    
    ;COMPUTE C(N,K)
    POP BX             ;GET RESULT1
    ADD AX,BX          ;RESULT = RESULT1+RESULT2
    
    RETURN:
    POP BP             ;RESTORE BP
    RET 2              ; RETURN AND DISCARD N AND K
    FIBO ENDP
END MAIN