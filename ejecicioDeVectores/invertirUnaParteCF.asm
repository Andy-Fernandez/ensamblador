data segment 
    numero dw  0
    v db 3, 5, 8, 13, 0
    t db 9
    enter db 10,13,'$'
    len dw 0
    contador dw 0
    inicio dw 0
    final dw 0
ends

code segment
start:
    mov ax, data
    mov ds, ax
    
    ; Pedimos el tamaño del vector
    call pideNumero
    call return  
    mov ax,numero
    mov len, ax 
    
    call pideNumero
    call return  
    mov ax,numero
    mov inicio, ax
    
    call pideNumero
    call return  
    mov ax,numero
    mov final, ax
    
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
    ;### FIN ### 
    
    ;###IMPRIMIR EL VECTOR###
    ; Hacemos un for que imrima la canditadad dada
    lea si, v 
    
    mov cx, 0 
    ;add si, len
    ;dec si 
    loop_while:
        cmp cx, len ; comparar cx con 11
        jge fin_while ; si cx >= 11, salir del loop
        
        add cx, 1 ; incrementar cx
        mov contador, cx
        
        cmp inicio, cx;comparamos si el contador es igual al segudo parametro 
        je cambioApuntador; cambiamos apuntador
        seguir:
        
        
        sinCambio:       
        mov bl, [si] ;3
        mov ax, bx
        call imprime
        call return
        dec si
        
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
    
     return:
        lea dx, enter
        mov ah, 9
        int 21h    
        ret
        
     cambioApuntador:
        ;mov ax, final
        ;sub ax, inicio   
        inc si
        inc si
        inc si
        
        loop_while2:
            cmp cx, len ; comparar cx con 11
            jge seguir ; si cx >= 11, salir del loop
            
            add cx, 1 ; incrementar cx
            mov contador, cx
            
            mov bl, [si] ;3
            mov ax, bx
            call imprime
            call return
            dec si
            
            mov cx, contador
            jmp loop_while2 ; volver al inicio del loop    
end start
