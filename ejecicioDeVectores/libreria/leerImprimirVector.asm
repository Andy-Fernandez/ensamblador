data segment 
    numero dw  0 
    vector db 13, 15, 18, 13, 10
    enter db 10,13,'$'
    espacio db 32,'$'
    len dw 0
    contador dw 0      
ends

code segment
start:
    mov ax, data
    mov ds, ax
    
    call pideNumero         ; pedimos un numero
    call return  
    mov ax,numero
    mov len, ax             ; lo guarmamos en len
    
    lea si, vector                
    call leerVector 
    
    call return
    
    lea si, vector 
    call imprimirVector
      
    mov ax, 4c00h
    int 21h
    
    ;FUNCIONES 
    
    ;)Leer un vector:
    leerVector:
        mov cx, 0
    loop_while0:
        cmp cx, len
        jge fin
        add cx, 1
        mov contador, cx
        call pideNumero
        ;call return ;leer vector con 'enter'
        mov bx,numero
        mov [si], bl
        inc si
        mov cx, contador
        jmp loop_while0  
    
    ;)Imprime vector con espacios:
    imprimirVector:
    mov cx, 0
    loop_while:
        cmp cx, len
        jge fin    
        add cx, 1
        mov contador, cx    
        mov bl, [si]
        mov ax, bx
        call imprime
        inc si 
        mov cx, contador
        jmp loop_while
    fin:
        ret     
    
    ;)Pide numero
    pideNumero:
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
        ret
            
    ;) Imprimimos un numero
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
        loop mostrar  
        lea dx, espacio ;mostrar con espacio
        ;lea dx, enter   ;mostrar con enter
        mov ah, 9
        int 21h      
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
