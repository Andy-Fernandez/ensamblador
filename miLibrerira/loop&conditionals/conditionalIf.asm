; Condicional if que imprime un mensaje
; si el número es mayor o igual a 10

lea dx, mensaje
mov ah, 9
int 21h

mov ax, numero

cmp ax, 10 ; comparar ax con 10
jl no_imprimir ; si ax < 10, saltar a no_imprimir

lea dx, mensaje_mayor_igual
mov ah, 9
int 21h

jmp fin_if

no_imprimir:
fin_if:
