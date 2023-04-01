; Loop while que imprime los números del 1 al 10
; usando el registro cx como contador

lea dx, mensaje
mov ah, 9
int 21h

mov cx, 1

loop_while:
    cmp cx, 11 ; comparar cx con 11
    jge fin_while ; si cx >= 11, salir del loop
    
    add cx, 1 ; incrementar cx
    mov dl, cx
    add dl, '0'
    mov ah, 2
    int 21h
    jmp loop_while ; volver al inicio del loop
    
fin_while:
