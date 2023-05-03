data segment 
    numero dw  0
    v db 3, 5, 8, 13, 0 
    u db 3, 5, 8, 13, 0
    t db 9
    enter db 10,13,'$'
    len dw 0
    contador dw 0
    ; Podemos definir varios vectores pero solo
    ; podemos acceder a dos ya que tenemos que 
    ; 'abrir' y 'cerrar' los vectores
    
    ; Otro aspecto es tener control sobre el ta
    ; mano del vectora ya que no da error al pa
    ; sarnos del tamano.       
    flag dw 0
    aux dw 0
ends

code segment
start:
    ; Cargar la dirección del primer elemento del vector en bx
    mov ax, data
    mov ds, ax
    
    ; Pedimos el tamaño del vector
    call pideNumero
    call return  
    mov ax,numero
    mov len, ax
    
    ;###LEER EL VECTOR###
    ; Hacemos un for que imrima la canditadad dada
    lea si, v 
    
    mov cx, 0
    loop_while0:
        cmp cx, len ; comparar cx con 11
        jge fin_while0 ; si cx >= 11, salir del loop
        
        add cx, 1 ; incrementar cx
        mov contador, cx
        
        call pideNumeroEsp
        call returnEsp
        mov bx,numero
        mov [si], bl
        inc si
        
        mov cx, contador
        jmp loop_while0 ; volver al inicio del loop
    
    fin_while0:
    ;### FIN ###
    lea dx, enter
    mov ah, 9
    int 21h 
    
    ;###Lee el segndo vector
    ; Hacemos un for que imrima la canditadad dada
    lea si, u 
    
    mov cx, 0
    loop_while3:
        cmp cx, len ; comparar cx con 11
        jge fin_while3 ; si cx >= 11, salir del loop
        
        add cx, 1 ; incrementar cx
        mov contador, cx
        
        call pideNumeroEsp
        call returnEsp
        mov bx,numero
        mov [si], bl
        inc si
        
        mov cx, contador
        jmp loop_while3 ; volver al inicio del loop
    
    fin_while3:
       
    lea dx, enter
    mov ah, 9
    int 21h   
    ;###RECORREMOS EL VECOTR Y MULTIPLICAMOS###
    ; Hacemos un for que imrima la canditadad dada
    lea si, u 
    
    mov cx, 0
    loop_while:
        cmp cx, len ; comparar cx con 11
        jge fin_while ; si cx >= 11, salir del loop
        
        add cx, 1 ; incrementar cx
        mov contador, cx
        
        mov bl, [si] ;3
        mov ax, bx
        call imprime
        call return
        inc si
        
        mov cx, contador
        jmp loop_while ; volver al inicio del loop
        
    fin_while:
    ;### FIN ###  

    ; Salida del programa
    mov ax, 4c00h
    int 21h
    
     pideNumero:
        mov numero,0
        mov bx,10
     leerNumero:
        mov ah,1
        int 21h
        cmp al,13
        jz finLectura
        sub al,48
        mov cx,0
        mov cl,al
        mov ax,numero
        mul bx
        add al,cl
        mov numero, ax
        jnz leerNumero
     finLectura:
        ret    
    
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
        ;loop mostrar  
        ;lea dx, enter
        ;mov ah, 9
        ;int 21h      
        ret
     
     ;LEER CON ESPACIOS
     pideNumeroEsp:
        mov numero,0
        mov bx,10
     leerNumeroEsp:
        mov ah,1
        int 21h
        cmp al,32
        jz finLecturaEsp
        sub al,48
        mov cx,0
        mov cl,al
        mov ax,numero
        mul bx
        add al,cl
        mov numero, ax
        jnz leerNumeroEsp
     finLecturaEsp:
        ret
     
     returnEsp:    
        ret       
    
     return:
        lea dx, enter
        mov ah, 9
        int 21h    
        ret    
end start
