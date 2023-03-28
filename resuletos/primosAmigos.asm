; FUNCIONA
; En este ejercicio buscamos averiguar si la suma de todos los divisores de A
; es igual a B y resciprocamente, de esta forma podemos decir que son números amigos

; Definir las constantes
NUM DW 100

; Definir las variables
DIVISOR DW 0
I DW 0
SUM DW 0

; Configurar segmentos
ORG 100h

; Código
MAIN:
    ; Inicializar los registros
    MOV AX, 0
    MOV DS, AX
    MOV CX, NUM
    MOV WORD PTR [I], 1

loop1:
    ; Comprobar si n es divisible por el contador
    MOV AX, CX
    MOV BX, 0
    MOV DX, 0
    DIV WORD PTR [I]
    CMP BX, 0

    ; Si el contador es un divisor, agregarlo a la suma
    JE add_divisor

    ; Si el contador es mayor que n, salir del ciclo
    INC WORD PTR [I]
    MOV BX, CX
    CMP WORD PTR [I], BX
    JLE loop1

    ; Imprimir la suma de los divisores
    MOV AX, WORD PTR [SUM]
    CALL print_reg

exit:
    MOV AH, 4Ch
    INT 21h

add_divisor:
    MOV AX, WORD PTR [I]
    ADD WORD PTR [SUM], AX
    INC WORD PTR [I]
    MOV BX, CX
    CMP WORD PTR [I], BX
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
    CMP SP, BP
    JNE print_loop

    POP DX
    POP CX
    POP BX
    POP AX
    RET

; Fin del programa
