.MODEL SMALL
.STACK 100h

.DATA
n DW 100
sum DW 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Inicializar el contador en 1
    MOV CX, 1

loop:
    ; Comprobar si n es divisible por el contador
    MOV AX, n
    MOV DX, 0
    DIV CX
    CMP DX, 0

    ; Si el contador es un divisor, agregarlo a la suma
    JE add_divisor

    ; Si el contador es mayor que n, mostrar la suma y salir
    INC CX
    MOV BX, n
    CMP CX, BX
    JLE loop
    MOV AX, sum
    CALL print_sum
    JMP exit

add_divisor:
    ADD sum, CX
    INC CX
    MOV BX, n
    CMP CX, BX
    JLE loop

print_sum:
    MOV BX, AX
    MOV CX, 10
    MOV DX, 0
digit_loop:
    XOR DX, DX
    DIV CX
    ADD DL, '0'
    PUSH DX
    CMP AX, 0
    JNE digit_loop

print_loop:
    POP DX
    MOV AH, 02h
    INT 21h
    CMP SP, 0
    JNE print_loop
    RET

exit:
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN