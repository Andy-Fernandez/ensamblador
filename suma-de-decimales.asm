; En este ejericio dado un X entero buscamos la suma
; de los 15 primeros decimales de 1/15
; Ejemplo
; 1/19 = 0.052631578947368
; suma = 74 en BX = 4A 

MOV AX, 1
MOV CX, 19    
MOV NUM1, CX ;ALMACENAMOS EL NUESTRO DIVISOR

MOV CX, 4
INC CX
ciclo:
    CMP AX, NUM1 ; COMPROBAMOS QUE SE PUEDA DIVIDIR
    JC ESMENOR   ; POR NO AUMENTAMOS UN 0
    
    MOV DX, 0     ; ANTES DE DIVIDIR DX=0
    DIV NUM1
    MOV BX, CONT
    ADD CONT, AX
    MOV BX, CONT
    MOV AX, DX
    MOV BX, 10 
    PUSH DX
    MUL BX
    POP DX
    CMP DX, 0
    JZ FIN         
    loop ciclo
JMP FIN

ESMENOR:
    MOV BX, 10
    MUL BX
    DEC CX
    JMP ciclo ;salto a ciclo
FIN:
    MOV BX, CONT
    
    MOV DL, 2
    ADD DL, 48
    MOV AH, 2
    INT 21H
    
    MOV DL, 4
    ADD DL, 48
    MOV AH, 2
    INT 21H
    
    MOV DL, 32
    MOV AH, 2
    INT 21H
    
    MOV DL, 65
    MOV AH, 2
    INT 21H
ret

;VARIABLES 
NUM1 DW 0
CONT DW 0
