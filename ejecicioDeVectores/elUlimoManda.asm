data segment 
    numero dw  0
    v db 3, 5, 8, 13, 0
    t db 9
    enter db 10,13,'$'
    len dw 0
    contador dw 0
    ultimo dw 0
    contador2 dw 0
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
        
        call pideNumero
        call return  
        mov bx,numero
        mov [si], bl
        inc si
        
        mov cx, contador
        jmp loop_while0 ; volver al inicio del loop
        
    fin_while0:
    ;### FIN ###ç
    
    
    ;camturamos el valor del ultimo
    mov ax, numero
    mov ultimo, ax
    
    ;loop mostrar  
    ;lea dx, enter
    ;mov ah, 9
    ;int 21h   
    
    ;mov ax, ultimo
    ;call imprime
    ;call return
    
    ;lea dx, enter
    ;mov ah, 9
    ;int 21h
    
      
    
    ;###IMPRIMIR EL VECTOR###
    ; Hacemos un for que imrima la canditadad dada
    lea si, v 
    
    mov cx, 0
    loop_while:
        cmp cx, len ; comparar cx con 11
        jge fin_while ; si cx >= 11, salir del loop
        
        add cx, 1 ; incrementar cx
        mov contador, cx
        
        mov bl, [si] ;3
        inc si
        mov ax, ultimo 
        cmp bx, ax ; comparar ax con 10
        je iguales
        jmp continuar
         
        iguales:
        add contador2, 1 
        lea dx, enter
        mov ah, 9
        int 21h
        
        continuar:
        mov cx, contador
        jmp loop_while ; volver al inicio del loop
        
    fin_while:
    ;### FIN ###
    
    
    lea dx, enter
    mov ah, 9
    int 21h
    
    mov ax, contador2
    call imprime
    call return  

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
    
     return:
        lea dx, enter
        mov ah, 9
        int 21h    
        ret    
end start
