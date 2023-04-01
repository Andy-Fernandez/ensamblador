; Loop for que imprime los números del 1 al 10
; usando el registro cx como contador

lea dx, mensaje
mov ah, 9
int 21h

mov cx, 10
mov dl, 1

loop_for:
    add dl, '0'
    mov ah, 2
    int 21h
    inc dl
    loop loop_for
    
