data segment
    var1Digito db -6
    signoNegativo db "-$"
ends

code segment
start:
    mov ax, data
    mov ds, ax

    ; determinar si el número es negativo
    cmp var1Digito, 0
    jge positivo
    lea dx, signoNegativo
    mov ah, 9
    int 21h
    neg var1Digito ; convierte el número en su complemento a 2
    positivo:

    mov dl, var1Digito
    add dl, '0'
    mov ah, 2
    int 21h

    mov ah, 4ch
    int 21h
end start
