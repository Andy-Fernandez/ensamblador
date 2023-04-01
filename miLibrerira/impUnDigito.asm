data segment
    cadena db "ejemplo de cadena $"
ends

code segment
start:
    mov ax, data
    mov ds, ax

    lea dx, cadena
    mov ah, 9
    int 21h

    mov ah, 4ch
    int 21h
end start
