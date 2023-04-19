data segment
    v db 3, 5, 8, 13
    t db 9
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

    lea si, v 
    mov bl, [si] ;3
    mov ax, bx
    call imprime
    call return
 
    inc si
    mov bl, [si] ;5
    mov ax, bx
    call imprime
    call return
 
    inc si
    mov bl, [si] ;8
    mov ax, bx
    call imprime
    call return 
    

    inc si
    mov bl, [si] ;13
    mov ax, bx
    call imprime
    call return

    inc si
    mov bl, [si] ;9 que es el valor de la siguiente variable
    mov ax, bx
    call imprime
    call return


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
