data segment 
    numero dw  0 
    x dw 30 dup(0)
    pares dw 30 dup(0)
    impares dw 30 dup(0)
    enter db 10,13,'$'
    espacio db 32,'$'
    len dw 0 
    len2 dw 0 
    contador dw 0
    aux dw 0  
    inter db "* $"    
ends

code segment
start:
    mov ax, data
    mov ds, ax
    
    call pideNumero         ; pedimos un numero 
    mov ax,numero
    mov len, ax             ; lo guarmamos en "len"  
    
    mov cx, len 
 	shr cx, 1
 	mov len2, cx
    
    mov si, offset x
    mov cx, len                
    call leerVector 
    call return
 
    
    
     paresImpares:
        mov cx, len
        lea si,x
        lea di, pares
        lea bx, impares
    
    
    ; Podemos a pares en un lado e impares en otro
     paresImparesW:
    	xor ax, ax    
    	mov al, [si] 
    	mov numero, ax
        and ax, 1      ; Realiza la operación AND con 1
        jz esPar 
        jmp esImpar 
        esPar:
            mov ax, numero
            mov [di],ax
            inc di  
            jmp siguiente
        esImpar:
            mov ax, numero 
            mov [bx],ax
            inc bx    
            jmp siguiente
        siguiente:
        inc si
        loop paresImparesW
        
    
     
                
 	mov si, offset pares
 	mov cx, len2
 	call ordenar
 	mov si, offset pares
 	mov cx, len2 
 	call imprimirVector  
 	
    lea dx, inter
    mov ah, 9
    int 21h
    
 	
 	mov si, offset impares
 	mov cx, len2
 	call ordenar
 	mov si, offset impares
 	mov cx, len2
 	call imprimirVector    
         
    mov ax, 4c00h
    int 21h
    
    ;FUNCIONES 
    ;)Leer un vector:
    leerVector:
        ;mov si, offset vector
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
        ;mov si, offset vector
        ;mov cx, len
    	loop_while:
        	xor ax, ax    
        	mov al, [si]
        	call imprime
        	inc si 
        	loop loop_while
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
   
   ordenar:
        iterar0: 
            cmp cx,1
            jz pantalla 
            lea si,x
            mov dx,1
            mov ax,[si]
            inc si
            inc si  
            ;add si,2
            iterar:
                cmp dx,len2
                jz volver
                mov bx,[si]
                menor:
                    cmp ax,bx
                    jnl cambiar
                    jmp actualizar
                    cambiar:   
                        dec si
                        dec si
                        mov [si],bx
                        inc si
                        inc si
                        mov [si],ax
                        
                        mov bx,ax 
                        inc si
                        inc si
                        inc dx
                        jmp iterar
                        
                    actualizar:  
                        mov ax,bx
                        inc si
                        inc si
                        inc dx
                        jmp iterar
                volver:  
                    dec cx
                    jmp iterar0
    pantalla:                    
        ret 

end start
