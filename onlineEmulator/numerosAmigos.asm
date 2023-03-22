; En este ejercicio buscamos averiguar si la suma de todos los divisores de A
; es igual a B y resciprocamente, de esta forma podemos decir que son números amigos
; Definir las constantes
NUM: DW 100

; Definir los registros
DIVISOR: DW 0
I: DW 0
SUM: DW 0

.CODE
MAIN PROC
    ; Inicializar los registros
    MOV AX, @DATA
    MOV DS, AX
    MOV CX, NUM
    MOV I, 1

loop1:
    ; Comprobar si n es divisible por el contador
    MOV AX, CX
    MOV BX, 0
    MOV DX, 0
    DIV I
    CMP BX, 0

    ; Si el contador es un divisor, agregarlo a la suma
    JE add_divisor

    ; Si el contador es mayor que n, salir del ciclo
    INC I
    MOV BX, CX
    CMP I, BX
    JLE loop1

    ; Imprimir la suma de los divisores
    MOV AX, SUM
    CALL print_reg

exit:
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

add_divisor:
    ADD SUM, I
    INC I
    MOV BX, CX
    CMP I, BX
    JLE loop1
    JMP exit

print_reg:
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    ; Convertir el registro a una cadena
    MOV BX, 10
    XOR CX, CX
    MOV DX, 0
digit_loop:
    XOR DX, DX
    DIV BX
    ADD DL, '0'
    PUSH DX
    CMP AX, 0
    JNE digit_loop

    ; Imprimir la cadena
print_loop:
    POP DX
    MOV AH, 02h
    INT 21h
    CMP SP, 0
    JNE print_loop

    POP DX
    POP CX
    POP BX
    POP AX
    RET

END MAIN
