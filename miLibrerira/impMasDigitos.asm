data segment
    var2Digitos dw 65535
ends

code segment
start:
    mov ax, data
    mov ds, ax
    
    mov ax, var2Digitos
    mov bx, 10
    mov cx, 0

    digito:
        xor dx, dx
        div bx
        push dx
        inc cx
        test ax, ax
        jnz digito
    
    imprimir:
        pop dx
        add dl, '0'
        mov ah, 2
        int 21h
        loop imprimir

    mov ah, 4ch
    int 21h
end start
