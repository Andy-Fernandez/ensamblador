data segment 
    numero dw  0 
    vector db 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5 
    enter db 10,13,'$'
    espacio db 32,'$'
    len dw 0
    contador dw 0
    aux dw 0
    caracter dw 0 
    rojo dw -1
    verde dw -1
    azul dw -1     
ends

code segment
start:
    mov ax, data
    mov ds, ax
                    
    call pideNumero
    call return
    mov ax, 0
    add ax, rojo
    add ax, verde
    add ax, azul
    call imprime
    
    
         
    mov ax, 4c00h
    int 21h
       
    
    ;)Pide numero
    pideNumero:
        push cx
        mov contador,0
        mov bx,10
        leerNumero:
            mov ah,1
            int 21h
            cmp al, 13   ; Terminar en al 13 (Enter)
            jz finLectura
            cmp al, 86   ; Terminar en al 86 (VERDE)
            jz GREEN
            cmp al, 82   ; Terminar en al 82 (ROJO)
            jz RED
            cmp al, 65   ; Terminar en al 65 (AZUL)
            jz BLUE
            ;cmp ax, caracter
            ;jz sumaContador
            ;mov caracter, ax 
            jnz leerNumero
        finLectura:
            pop cx
            ret
    
    sumaContador:
        ; Aumentar el contador
        inc contador
        ; Guardar el último carácter ingresado
        mov caracter, ax 
        jmp leerNumero
        
    RED:
        inc rojo
        jmp leerNumero
    GREEN:
        inc verde
        jmp leerNumero 
    
    BLUE:
        inc azul
        jmp leerNumero      
; R 82 
; V 86
; A 65
    
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

end start
