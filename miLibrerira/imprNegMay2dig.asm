; este programa usa tanto ax, bx, cx y dx
; tambien usa el stack 
data segment
    var2Negativo dw -32768 ;este es el limite en negativo
    signoNegativo db "-$"
ends

code segment
start:
    mov ax, data
    mov ds, ax
    
    mov ax, var2Negativo 
    mov bx, 10
    mov cx, 0
    
    ; determinar si el número es negativo
    test ax, 8000h ; verifica el bit de signo
    jz digitoN ; si no está activo, el número es positivo
    neg ax ; si está activo, convierte el número en su complemento a 2
    
    push ax
    lea dx, signoNegativo
    mov ah, 9
    int 21h
    pop ax
    
    digitoN:
        xor dx, dx
        div bx
        push dx
        inc cx
        test ax, ax
        jnz digitoN
    
    imprimirN:
        pop dx
        add dl, '0'
        mov ah, 2
        int 21h
        loop imprimirN
        
    mov ah, 4ch
    int 21h
end start
