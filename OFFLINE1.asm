

.MODEL SMALL
.STACK 100H
.DATA
VAR1    DB  ?
VAR2    DB  ? 
VAR3    DB  ?  
MSG1    DB  'ENTER YOUR MARK: $'
R_MSG   DB  'YOU OBTAINED: $'  
GRD4    DB  '4.00 $'
GRD3_5  DB  '3.50 $'
GRD3   DB  '3.00 $'
GRD2_5  DB  '2.50 $'
GRD2    DB  '2.00 $'
GRD0    DB  '0.00 $'
.CODE
MAIN PROC  
     MOV AX,@DATA
     MOV DS,AX
     
     MOV AH,9
     LEA DX,MSG1
     INT 21H  
     
     MOV AH,1
     INT 21H
     MOV VAR1,AL  
     
     MOV AH,1
     INT 21H
     MOV VAR2,AL
     
     MOV AH,1
     INT 21H
     MOV VAR3,AL  
     
     MOV AH, 2
     MOV DL,0DH
     INT 21H
     MOV DL,0AH
     INT 21H  
     
     MOV AH,9          ;U OBTAINED
     LEA DX,R_MSG
     INT 21H
     
     CMP VAR1,'1'
     JE CASE4  
     
     CMP VAR2,'9'
     JE CASE4 
     
     CMP VAR2,'8'
     JE CASE3_5
     
     CMP VAR2,'7'
     JE CASE3
     
     CMP VAR2,'6'
     JE CASE2_5
     
     CMP VAR2,'5'
     JE CASE2
     
     CMP VAR2,'4'
     JLE CASE0
     
  CASE4:
     LEA DX,GRD4 
     INT 21H
     JMP CASE_N
  CASE3_5:
     LEA DX,GRD3_5 
     INT 21H
     JMP CASE_N
  CASE3:
     LEA DX,GRD3 
     INT 21H
     JMP CASE_N
  CASE2_5:
     LEA DX,GRD2_5 
     INT 21H
     JMP CASE_N
  CASE2:          
     LEA DX,GRD2 
     INT 21H
     JMP CASE_N
  CASE0:        
     LEA DX,GRD0 
     INT 21H
     JMP CASE_N
  CASE_N:      
        
     MOV AH,4CH
     INT 21H

MAIN ENDP
    END MAIN

