data segment 
    numero dw  0
    v db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
    enter db 10,13,'$'
    len dw 0
    contador dw 0
    contador2 dw 0
    
    maxCont dw 0 
    comparador dw 0
ends

code segment
start:
    mov ax, data
    mov ds, ax
       
    call pideNumero      ; Pedimos la longitud del vector
    call return  
    mov ax,numero
    mov len, ax          ; Guardamos la longitud en "len"
    
        
    mov si, offset v     ; lea si, v     ; Asignamos la vase el vector "v"
    mov cx, len
    loop_while0:
        cmp cx, 0        ; CX == 0?
        jz fin_while0    ; True   
                         ; False (continue)
        push cx
        call pideNumero
        call return
        
        xor ax, ax  
        mov ax,numero
        mov [si], al
        inc si
        
        pop cx
        loop loop_while0 ; volver al inicio del loop
        
    fin_while0:


    mov di, offset v     ;lea di, v 
    mov cx, len
    mov maxCont, 0
     
    while_externo:
        cmp cx, 0
        jz fin_while_externo
        
        xor ax, ax
        mov al, [di] 
        inc di
        mov comparador, ax
        push cx
         
        mov si, offset v  ;lea si, v
        mov contador2, 0
        mov cx, len         
        loop_while:
            cmp cx, 0 
            jz fin_while 
            
            xor ax, ax
            mov al, [si] 
            inc si
            
            cmp ax, comparador
            jne no_son_iguales
            inc contador2 
            no_son_iguales:
            
            loop loop_while     
        fin_while:
        mov ax, contador2
        cmp ax, maxCont
        jle no_es_mayor   ; Salta si ax <= maxCont
        mov maxCont, ax
        no_es_mayor:
        call imprime
        pop cx 
        loop while_externo
    fin_while_externo:       
    
    call return
    
    mov ax, maxCont
    call imprime  
    mov ax, 4c00h         ; Fin del progrma
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
            ret       
    return:
        lea dx, enter
        mov ah, 9
        int 21h    
        ret    
end start
