data segment
    v db 3, 5, 8, 13
    t db 9
    ; Podemos definir varios vectores pero solo
    ; podemos acceder a dos ya que tenemos que 
    ; 'abrir' y 'cerrar' los vectores
    
    ; Otro aspecto es tener control sobre el ta
    ; mano del vectora ya que no da error al pa
    ; sarnos del tamano.
ends

code segment
start:
    ; Cargar la dirección del primer elemento del vector en bx
    mov ax, data
    mov ds, ax

    lea si, v 
    mov bl, [si] ;3
    inc si
    mov bl, [si] ;5
    inc si
    mov bl, [si] ;8
    inc si
    mov bl, [si] ;13
    inc si
    mov bl, [si] ;9 que es el valor de la siguiente variable
    inc si
    mov bl, [si]


    ; Salida del programa
    mov ax, 4c00h
    int 21h
end start
