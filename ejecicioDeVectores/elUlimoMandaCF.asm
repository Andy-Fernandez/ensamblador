data segment 
    numero dw  0
    vector db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
    enter db 10,13,'$'
    espacio db 32,'$' 
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
    
    call leerVector 
    call return

    mov di, offset vector     ;lea di, v 
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
         
        mov si, offset vector  ;lea si, v
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
    
    fin_programa:
    
    ;FUNCIONES 
    ;)Leer un vector:
    leerVector:
        mov si, offset vector
        mov cx, len
    loop_while0:
        call pideNumero
        ;call return ;leer vector con 'enter'
        mov bx,numero
        mov [si], bl
        inc si
        loop loop_while0
        ret 
    
    ;)Imprime vector con espacios:
    imprimirVector:
        mov si, offset vector
        mov cx, len
    loop_whileI:
        xor ax, ax    
        mov al, [si]
        push cx
        call imprime
        pop cx
        inc si 
        loop loop_whileI
        ret     
    
    ;)Pide numero
    pideNumero:
        push cx
        mov numero,0
        mov bx,10
        leerNumero:
            mov ah,1
            int 21h
            cmp al, 13   ; Terminar en al 13 (Enter)
            jz finLectura
            cmp al, 32   ; Terminar en al 32 (espacio)
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
            pop cx
            ret
            
    ;) Imprimimos un numero
    imprime:
        push cx
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
        lea dx, espacio  ;mostrar con espacio
        ;lea dx, enter   ;mostrar con enter
        mov ah, 9
        int 21h
        pop cx      
        ret   
    
    return:
        lea dx, enter
        mov ah, 9
        int 21h    
        ret
    
end start
