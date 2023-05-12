data segment 
    numero dw  0
    v db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
    enter db 10,13,'$'
    len dw 0
    contador dw 0
    ultimo dw 0
    contador2 dw 0
ends

; Nue
code segment
start:
    mov ax, data
    mov ds, ax
    
    call pideNumero      ; Pedimos la longitud del vector
    call return  
    mov ax,numero
    mov len, ax          ; Guardamos la longitud en "len"
    
    lea si, v            ; Asignamos la vase el vector "v"
    
    mov cx, len
    loop_while0:
        cmp cx, 0        ; CX == 0?
        jz fin_while0    ; True   
                         ; False (continue)
        mov contador, cx ; Guardamos CX
        call pideNumero
        call return
        
        xor ax, ax  
        mov ax,numero
        mov [si], al
        inc si
        
        mov cx, contador
        loop loop_while0 ; volver al inicio del loop
        
    fin_while0:

    mov ax, numero
    mov ultimo, ax       ; Guardamos ultimo <- numero
    
    ; El siguente codigo solo cuenta cuantas veces se repite
    ;   el ultimo. 
    lea si, v
    mov cx, len          
    loop_while:
        cmp cx, 0 
        jz fin_while 
        mov contador, cx
        
        xor bx, bx
        mov bl, [si] 
        inc si
        mov ax, ultimo 
        cmp bx, ax 
        je iguales
        jmp continuar
         
        iguales:
        add contador2, 1 

        continuar:
        mov cx, contador
        loop loop_while     
    fin_while:   
    
    call return
    
    mov ax, contador2
    call imprime  

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
