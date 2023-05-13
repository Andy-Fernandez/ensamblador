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
    mov dl, bl
    add dl, '0'
    mov ah, 2
    int 21h
    
    mov dl, 32
    mov ah, 2
    int 21h
    
    inc si
    mov bl, [si] ;5
    mov dl, bl
    add dl, '0'
    mov ah, 2
    int 21h
    
    mov dl, 32
    mov ah, 2
    int 21h
    
    inc si
    mov bl, [si] ;8
    mov dl, bl
    add dl, '0'
    mov ah, 2
    int 21h 
    
    
    mov dl, 32
    mov ah, 2
    int 21h
    
    inc si
    mov bl, [si] ;13
    mov al, bl
    mov ah, 0
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
        
    
    mov dl, 32
    mov ah, 2
    int 21h
    
    inc si
    mov bl, [si] ;9 que es el valor de la siguiente variable
    mov dl, bl
    add dl, '0'
    mov ah, 2
    int 21h


    ; Salida del programa
    mov ax, 4c00h
    int 21h
end start
