.Model Small
.Stack 100h
.DATA
A DW ?
B Dw 80        ;b,c hor highlight
c dw 76
P DB 13        ;P,Q FOR TEXT COORDINATE
Q DB 6
X DW 80
Y DW 76
GRID DB 9 DUP(0)
ID DW 0
TURN DB 1
STEP DB 0
PLAYER1 DB 'PLAYER 1 WINS$'
PLAYER2 DB 'PLAYER 2 WINS$'
DRAW DB 'GAME DRAW$'

draw_row Macro            ;DRAWS BOX ON (B,C)
    Local l1,l2,L3,L4
    ; draws a line in row y from col x to col 300
    MOV AH, 0CH
    MOV CX, x
    MOV DX, y
    MOV A,CX
    ADD A,50
L1: INT 10h
    INC CX
    CMP CX, a
    JL L1
    ;;;;;;;;
    SUB DX,47
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
    SUB A,47
L3: 
    INT 10h
    DEC DX
    CMP DX, A
    JG L3
    ;;;;;
    ADD CX,50
    MOV DX, Y
    MOV A,DX
    SUB A,47
L4: 
    INT 10h
    DEC DX
    CMP DX, A
    JG L4
    
    
    EndM
    
RESULT MACRO
    LOCAL D1,D2,D3,D4,D5,D6,D7,E0,E1,E2,E3,E4,E5,E6,E7
    MOV BX,0
    CMP GRID[BX],1
    JNE D1
    INC BX
    CMP GRID[BX],1
    JNE D1
    INC BX
    CMP GRID[BX],1
    JNE D1
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER2
    MOV AH,9
    INT 21H
    JMP OVER
    
D1:
    MOV BX,3
    CMP GRID[BX],1
    JNE D2
    INC BX
    CMP GRID[BX],1
    JNE D2
    INC BX
    CMP GRID[BX],1
    JNE D2
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER2
    MOV AH,9
    INT 21H 
    JMP OVER
    
    
d2:
    MOV BX,6
    CMP GRID[BX],1
    JNE D3
    INC BX
    CMP GRID[BX],1
    JNE D3
    INC BX
    CMP GRID[BX],1
    JNE D3
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER2
    MOV AH,9
    INT 21H 
    JMP OVER
    
D3:
    MOV BX,0
    CMP GRID[BX],1
    JNE D4
    ADD BX,3
    CMP GRID[BX],1
    JNE D4
    ADD BX,3
    CMP GRID[BX],1
    JNE D4
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER2
    MOV AH,9
    INT 21H 
    JMP OVER
D4:
    MOV BX,1
    CMP GRID[BX],1
    JNE D5
    ADD BX,3
    CMP GRID[BX],1
    JNE D5
    ADD BX,3
    CMP GRID[BX],1
    JNE D5
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER2
    MOV AH,9
    INT 21H 
    JMP OVER
D5:
    MOV BX,2
    CMP GRID[BX],1
    JNE D6
    ADD BX,3
    CMP GRID[BX],1
    JNE D6
    ADD BX,3
    CMP GRID[BX],1
    JNE D6
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER2
    MOV AH,9
    INT 21H 
    JMP OVER
D6:
    MOV BX,2
    CMP GRID[BX],1
    JNE D7
    ADD BX,2
    CMP GRID[BX],1
    JNE D7
    ADD BX,2
    CMP GRID[BX],1
    JNE D7
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER2
    MOV AH,9
    INT 21H 
    JMP OVER
D7:
    MOV BX,0
    CMP GRID[BX],1
    JNE E0
    ADD BX,4
    CMP GRID[BX],1
    JNE E0
    ADD BX,4
    CMP GRID[BX],1
    JNE E0
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER2
    MOV AH,9
    INT 21H 
    JMP OVER
E0:

    MOV BX,0
    CMP GRID[BX],2
    JNE E1
    INC BX
    CMP GRID[BX],2
    JNE E1
    INC BX
    CMP GRID[BX],2
    JNE E1
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER1
    MOV AH,9
    INT 21H
    JMP OVER
    
E1:
    MOV BX,3
    CMP GRID[BX],2
    JNE E2
    INC BX
    CMP GRID[BX],2
    JNE E2
    INC BX
    CMP GRID[BX],2
    JNE E2
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER1
    MOV AH,9
    INT 21H 
    JMP OVER
    
    
E2:
    MOV BX,6
    CMP GRID[BX],2
    JNE E3
    INC BX
    CMP GRID[BX],2
    JNE E3
    INC BX
    CMP GRID[BX],2
    JNE E3
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER1
    MOV AH,9
    INT 21H 
    JMP OVER
    
E3:
    MOV BX,0
    CMP GRID[BX],2
    JNE E4
    ADD BX,3
    CMP GRID[BX],2
    JNE E4
    ADD BX,3
    CMP GRID[BX],2
    JNE E4
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER1
    MOV AH,9
    INT 21H 
    JMP OVER
E4:
    MOV BX,1
    CMP GRID[BX],2
    JNE E5
    ADD BX,3
    CMP GRID[BX],2
    JNE E5
    ADD BX,3
    CMP GRID[BX],2
    JNE E5
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER1
    MOV AH,9
    INT 21H 
    JMP OVER
E5:
    MOV BX,2
    CMP GRID[BX],2
    JNE E6
    ADD BX,3
    CMP GRID[BX],2
    JNE E6
    ADD BX,3
    CMP GRID[BX],2
    JNE E6
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER1
    MOV AH,9
    INT 21H 
    JMP OVER
E6:
    MOV BX,2
    CMP GRID[BX],2
    JNE E7
    ADD BX,2
    CMP GRID[BX],2
    JNE E7
    ADD BX,2
    CMP GRID[BX],2
    JNE E7
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER1
    MOV AH,9
    INT 21H 
    JMP OVER
E7:
    MOV BX,0
    CMP GRID[BX],2
    JNE E8
    ADD BX,4
    CMP GRID[BX],2
    JNE E8
    ADD BX,4
    CMP GRID[BX],2
    JNE E8
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,13
    MOV BH,0
    INT 10h
    LEA DX,PLAYER1
    MOV AH,9
    INT 21H 
    JMP OVER
E8:

    ENDM

    
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
    MOV Y,123
    draw_row 
    ADD X,50
    draw_row 
    ADD X,50
    draw_row 
    ;row 1
    MOV X,80
    MOV Y,76
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
    RESULT
    CMP STEP,9
    JL FFG
    MOV Ah,2            ;MOVE CURSOR
    MOV DH,2
    MOV DL,15
    MOV BH,0
    INT 10h
    LEA DX,DRAW
    MOV AH,9
    INT 21H
    JMP OVER
    ;B=ROW,C=COLUMN
    ;DRAW HIGHLIGHTED BOX
FFG:    
    DRAW_BOX
    
    MOV BX,B
    MOV X,BX
    
    MOV BX,C
    MOV Y,BX
    
    MOV AL,15       ;WHITE       
    
    
    DRAW_ROW
    
    CMP TURN,1
    JNE GDJ
    MOV DH,12
    MOV DL,6
    MOV AL,'X'
    MOV BL,15     ;COLOR
    CHAR_SHOW
    MOV DH,12
    MOV DL,72
    MOV AL,'O'
    MOV BL,0     ;COLOR
    CHAR_SHOW
    JMP GGH
GDJ:
    MOV DH,12
    MOV DL,6
    MOV AL,'X'
    MOV BL,0     ;COLOR
    CHAR_SHOW
    MOV DH,12
    MOV DL,72
    MOV AL,'O'
    MOV BL,15     ;COLOR
    CHAR_SHOW
    
GGH:    
        
    ;INPUT COMMAND   
    MOV AH, 0
    INT 16h
    
    CMP AH,77
    JE RIGHT
    
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
    

    
UP:
    cmp C,80
    JLE DDD
    SUB C,47
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
    ADD C,47
    ADD Q,6
    ADD ID,3
    JMP KKK
DDD2:
    MOV C,76
    MOV Q,6
    SUB ID,6
    JMP KKK 

GOL:
    
    CMP AH,72
    JE UP
    CMP AH,80
    JE DOWN
    CMP AH,18H
    JE OOP
    CMP AH,2DH
    JE AXE
    JMP PKP
DEMO:
    JMP KKK    

OOP:
    
    MOV BX,ID
    CMP GRID[BX],0
    JE OOP2
    JMP KKK
OOP2:
    CMP TURN,2
    JNE DEMO
    MOV TURN,1
    MOV GRID[BX],1
    MOV DH,Q
    MOV DL,P
    MOV AL,'O'
    MOV BL,14
    CHAR_SHOW
    INC STEP
    JMP KKK
   
AXE: 
    MOV BX,ID
    CMP GRID[BX],0
    JE AXE2
    JMP KKK
AXE2:
    CMP TURN,1
    JNE DEMO
    MOV TURN,2
    MOV GRID[BX],2
    MOV DH,Q
    MOV DL,P
    MOV AL,'X'
    MOV BL,1     ;COLOR
    CHAR_SHOW
    INC STEP
    JMP KKK   
    
PKP:
    CMP AH,75
    JE LEFT
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

    
OVER:   
    MOV DH,12
    MOV DL,6
    MOV AL,'X'
    MOV BL,0     ;COLOR
    CHAR_SHOW
    MOV DH,12
    MOV DL,72
    MOV AL,'O'
    MOV BL,0     ;COLOR
    CHAR_SHOW
    ;GETCH
    MOV AH, 0        
    INT 16h
    ;TEXT MODE
    MOV AX, 3
    INT 10h
    MOV AH, 4CH
    INT 21h
main EndP
     End main
     
     
     
;       row    col
;1,3    6,12,18       13,19,25,
