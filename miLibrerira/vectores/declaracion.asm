data segment
    mi_vector db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
ends

code segment
start:
    ; Cargar la dirección del primer elemento del vector en bx
    mov bx, offset mi_vector

    ; Acceder al primer elemento del vector (índice 0)
    mov al, [bx]

    ; Acceder al quinto elemento del vector (índice 4)
    mov al, [bx + 4]

    ; Acceder al último elemento del vector (índice 9)
    mov al, [bx + 9]

    ; Salida del programa
    mov ax, 4c00h
    int 21h
end start
