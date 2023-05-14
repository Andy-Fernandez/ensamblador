data segment 
    numero dw  0 
    vector db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
    enter db 10,13,'$'
    espacio db 32,'$'
    len dw 0
    contador dw 0
    aux dw 0      
ends

code segment
start:
    mov ax, data
    mov ds, ax
    
    call pideNumero         ; pedimos un numero
    call return  
    mov ax,numero
    mov len, ax             ; lo guarmamos en "len"
                    
    call leerVector 
    call return
    call imprimirVectorAlReves
         
    mov ax, 4c00h
    int 21h
    
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
    	loop_while:
        	xor ax, ax    
        	mov al, [si]
        	call imprime
        	inc si 
        	loop loop_while
 	    ret     
    
    imprimirVectorAlReves:
        mov si, offset vector
        mov cx, len
        add si, cx
        loop_whileAR:
            xor ax, ax
            dec si     
            mov al, [si]
            call imprime
            loop loop_whileAR
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
              
            lea dx, espacio ;mostrar con espacio
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
    
    returnEs:
        lea dx, espacio
        mov ah, 9
        int 21h    
        ret

end start
