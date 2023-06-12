data segment 
    numero dw  0 
    vector db 13, 15, 18, 13, 10
    espacio db 32,'$'
    enter db 10,13,'$'
    len dw 0
    contador dw 0
    aux dw 0      
ends

code segment
start:
    mov ax, data
    mov ds, ax
    
    ;call pideNumero         ; pedimos un numero
    ;call return  
    ;mov ax,numero
    ;mov len, ax             ; lo guarmamos en "len"
                    
    call leerVector 
    call ordenarVector
    call return
    call imprimirVector
         
    mov ax, 4c00h
    int 21h
    
    ;FUNCIONES 
    ;)Leer un vector:
    leerVector:
        mov si, offset vector
        ;mov cx, len
        mov cx, 0
    loop_while0:
        ;call pideNumero
        ;call return ;leer vector con 'enter'
        mov ah,1
        int 21h
        cmp al, 13   ; Terminar en al 13 (Enter)
        jz finLV
        sub al,48
        mov [si], al
        inc si
        inc cx
        jmp loop_while0
        ;loop loop_while0
    finLV:
        mov len, cx
        ret
    
    ordenarVector:
        mov cx, len
        dec cx 
        loop_whileOVT:
            push cx
            call ordenarVectorP1 
            pop cx
            loop loop_whileOVT
    
    ordenarVectorP1:
        mov si, offset vector
        mov cx, len
        xor bx, bx    
        mov bl, [si]
        inc si
        dec cx
    	loop_whileOV1:
        	xor ax, ax    
        	mov al, [si]
        	cmp bx,ax   
        	jle cambia       ; si bx < ax
        	jmp noCambia
        	cambia:
        	  mov [si], bl  ; vector[si] = bl
        	  dec si        ; si--
        	  mov [si], al  ; vector[si] = al
        	  inc si        ; si++
        	  mov bl, [si]  ; bl = vector[si]
        	noCambia:
        	mov bl, [si]  ; bl = vector[si]
        	;call imprime
        	inc si          ; si++ para la sig interacion
        	loop loop_whileOV1
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
            ;jnz leerNumero
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
              
            ;lea dx, espacio ;mostrar con espacio
            ;lea dx, enter   ;mostrar con enter
            ;mov ah, 9
            ;int 21h      
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
