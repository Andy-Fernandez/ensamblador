data segment
    v db 3, 5, 8, 13
    t db 9            
    msj db "Hola MUNDO!!$"
    enter db 10,13,'$'
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
    
    lea dx, msj
    mov ah, 9
    int 21h
    
    lea dx, enter
    mov ah, 9
    int 21h
    
    mov msj[5], 32
    mov msj[7], 77
    mov msj[8], 83
    mov msj[9], 65 
    
    lea dx, msj
    mov ah, 9
    int 21h


    ; Salida del programa
    mov ax, 4c00h
    int 21h
    
     imprime:
        mov bx,10
        mov cx,0
     reducir:
        mov dx,0
        div bx
        push dx
        inc cx
        cmp ax,0
        jz mostrar
        jmp reducir 
     mostrar:
        pop dx
        add dl, 48
        mov ah,2
        int 21h
        loop mostrar  
        lea dx, enter
        mov ah, 9
        int 21h      
        ret       
    
     return:
        lea dx, enter
        mov ah, 9
        int 21h    
        ret    
end start
