data segment 
    numero dw  0 
    vector db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    enter db 10,13,'$'
    espacio db 32,'$'
    len dw 10
    contador dw 0
    
    aux dw 0 
    ini dw 5
    fin dw 9    
ends

code segment
start:
    mov ax, data
    mov ds, ax
    
    ;call pideNumero         ; pedimos un numero
    ;call return  
    ;mov ax,numero
    ;mov len, ax             ; lo guarmamos en "len"
                    
    ;call leerVector 
    ;call return
    mov ax, fin
    mov aux, ax
    mov ax, ini
    mov fin, ax
    mov ini, 1
    call imprimirVectorIF
    
    mov ax, fin
    mov ini, ax
    mov ax, aux
    mov fin, ax
    call imprimirVectorIFAlReves
    
    mov ax, fin
    mov ini, ax
    mov ax, len
    mov fin, ax
    call imprimirVectorIF
         
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
    
    ;)Imprime vector con espacios, dado inicio y fin
    imprimirVectorIF:
        mov si, offset vector
        mov ax, fin             ; ax = fin
        sub ax, ini             ; ax = fin - ini
        mov cx, ax              ; cx = len = ax
        ;inc cx                  ; cx++
        add si, ini             ; si += ini
        dec si                  ; si--
    	loop_whileIF:
        	xor ax, ax    
        	mov al, [si]
        	call imprime
        	inc si 
        	loop loop_whileIF
 	    ret
 	
 	;)Imprime vector con espacios, dado inicio y fin
    imprimirVectorIFAlReves:
        mov si, offset vector
        mov ax, fin             ; ax = fin      
        sub ax, ini             ; ax = fin - ini
        mov cx, ax              ; cx = len = ax 
        inc cx                  ; cx++          
        add si, fin             ; si += fin
        loop_whileIFAR:
            xor ax, ax
            dec si     
            mov al, [si]
            call imprime
            loop loop_whileIFAR
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
