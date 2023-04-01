; Condicional if-else que imprime un mensaje
; si el número es mayor o igual a 10, y otro
; mensaje si no lo es

lea dx, mensaje
mov ah, 9
int 21h

mov ax, numero

cmp ax, 10 ; comparar ax con 10
jl else_condicional ; si ax < 10, saltar a else

lea dx, mensaje_mayor_igual
mov ah, 9
int 21h

jmp fin_condicional

else_condicional:
lea dx, mensaje_menor
mov ah, 9
int 21h

fin_condicional:
