.Model Small
.Stack 100h
.DATA
A DW ?
B Dw 80        ;b,c hor highlight
c dw 80
P DB 13
Q DB 7
X DW 80
Y DW 80
GRID DB 9 DUP(0)
ID DW 0
draw_row Macro 
    Local l1,l2,L3,L4
    ; draws a line in row y from col x to col 300
    
    MOV CX, x
    MOV DX, y
    MOV A,CX
    ADD A,50
L1: INT 10h
    INC CX
    CMP CX, a
    JL L1
    ;;;;;;;;
    SUB DX,45
    MOV CX, x
L2:

    INT 10h
    INC CX
    CMP CX, a
    JL L2
    
; draws a line col X from row X to row 189
    MOV CX, X
    MOV DX, Y
    MOV A,DX
    SUB A,45
L3: 
    INT 10h
    DEC DX
    CMP DX, A
    JG L3
    ;;;;;
    ADD CX,50
    MOV DX, Y
    MOV A,DX
    SUB A,45
L4: 
    INT 10h
    DEC DX
    CMP DX, A
    JG L4
    
    
    EndM
    
DRAW_BOX MACRO


    
    
; draw line pixel by pixel 
     
    MOV AH, 0CH
    MOV AL,4         ;white
    ;row 3
    MOV X,80
    MOV Y,170
    draw_row 
    ADD X,50
    draw_row 
    ADD X,50
    draw_row 
    ;row 2
    MOV X,80
    MOV Y,125
    draw_row 
    ADD X,50
    draw_row 
    ADD X,50
    draw_row 
    ;row 1
    MOV X,80
    MOV Y,80
    draw_row 
    ADD X,50
    draw_row 
    ADD X,50
    draw_row 
    EndM
    
    
CHAR_SHOW MACRO

    ; move cursor to page 0, row 7, col 25
        MOV AH, 02
        MOV BH, 0
        ;MOV DH, 7
        ;MOV DL, 13
        INT 10h
; write char        
        MOV AH, 9
        ;MOV AL, 'O'
        ;MOV BL, 0 ; color value from palette
        MOV CX, 1
        INT 10h
        
   ENDM
.Code
main Proc 

    MOV AX,@DATA
    MOV DS,AX
 
; set CGA 320x200 high res mode
    MOV AX,13
    INT 10h
    
    
    
    
    
kkk:                          ;GAME LOOP
    ;B=ROW,C=COLUMN
    ;DRAW HIGHLIGHTED BOX
    
    DRAW_BOX
    
    
    
    MOV AL,15              
    MOV BX,B
    MOV X,BX
    ;INC X
    MOV BX,C
    MOV Y,BX
    ;INC Y
    DRAW_ROW
    
        
    ;INPUT COMMAND   
    MOV AH, 0
    INT 16h
    CMP AH,77
    JE RIGHT
    CMP AH,75
    JE LEFT
    CMP AH,72
    JE UP
    JMP GOL
    
 
RIGHT:
    cmp B,180
    JGE TT
    ADD P,6
    ADD B,50
    INC ID
    JMP KKK
TT:
    MOV B,80
    MOV P,13
    SUB ID,2
    JMP KKK
    
LEFT:
    cmp B,80
    JLE TT2
    SUB B,50
    SUB P,6
    DEC ID
    JMP KKK
TT2:
    MOV B,180
    MOV P,25
    ADD ID,2
    JMP KKK
    
UP:
    cmp C,80
    JLE DDD
    SUB C,45
    SUB Q,6
    SUB ID,3
    JMP KKK
DDD:
    MOV C,170
    MOV Q,18
    ADD ID,6
    JMP KKK

DOWN:
    cmp C,170
    JGE DDD2
    ADD C,45
    ADD Q,6
    ADD ID,3
    JMP KKK
DDD2:
    MOV C,80
    MOV Q,7
    SUB ID,6
    JMP KKK 

GOL:
    CMP AH,80
    JE DOWN
    CMP AH,18H
    JE OOP
    CMP AH,2DH
    JE AXE
    JMP KKK
    

OOP:
    
    MOV BX,ID
    CMP GRID[BX],0
    JE OOP2
    JMP KKK
OOP2:
    MOV GRID[BX],1
    MOV DH,Q
    MOV DL,P
    MOV AL,'O'
    MOV BL,14
    CHAR_SHOW
    JMP KKK
   
AXE: 
    MOV BX,ID
    CMP GRID[BX],0
    JE AXE2
    JMP KKK
AXE2:
    MOV GRID[BX],2
    MOV DH,Q
    MOV DL,P
    MOV AL,'X'
    MOV BL,1
    CHAR_SHOW
    JMP KKK   

    
        MOV AX, 3
        INT 10h
        
        MOV AH, 4CH
        INT 21h
main EndP
     End main
     
     
     
;       row    col
;1,3    7,12,18       13,19,25,
