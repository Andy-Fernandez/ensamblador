data segment
    var1Digito db 6
ends

code segment
start:
    mov ax, data
    mov ds, ax

    mov dl, var1Digito
    add dl, '0'
    mov ah, 2
    int 21h

    mov ah, 4ch
    int 21h
end start
