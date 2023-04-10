; multi-segment executable file template.

data segment
    numero dw 0
    num1 dw 0
    num2 dw 0
    num3 dw 0
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    
    call pideNumero
    mov bx, numero  ;asigna a BX el numero leído 
    
    ; inicializar variables
    mov bx, 0 ; primer número 
    mov num1, bx
    mov cx, 1 ; segundo número
    mov num2, cx
    mov dx, 1 ; tercer número
    mov num3, dx
    
    ; imprimir primeros 3 números
    mov ah, 2
    mov dl, '0'
    add dl, bl
    int 21h
    mov dl, ' '
    int 21h
    mov dl, '1'
    int 21h
    mov dl, ' '
    int 21h
    mov dl, '1'
    int 21h
    mov dl, ' '
    int 21h
    
    mov cx, numero
    sub cx, 3
    loop1:
    
        mov ax, num3
        add ax, num2
        add ax, num1  
        mov bx, num2
        mov num1, bx
        mov bx, num3
        mov num2, bx
        mov num3, ax
        
        push cx
       
        mov bx, 10
        mov cx, 0
    
        digito:
            xor dx, dx
            div bx
            push dx
            inc cx
            test ax, ax
            jnz digito
        
        imprimir:
            pop dx
            add dl, '0'
            mov ah, 2
            int 21h
            loop imprimir
        
        pop cx    
        mov dl, ' '
        int 21h
        loop loop1
    
    
    
    
    
    
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
    
    pideNumero:
        mov numero, 0
        mov bx, 10
        
    leerNumero:
        mov ah, 1
        int 21h         ;interrupcion 
        cmp al,13       ;13 es enter 
        jz finLectura   
        sub al,48       ;le restamos 48 para imrprimir
        mov cx, 0
        mov cl, al      ;guardamos el numero leido en cl
        mov ax, numero  ;ax=numero para multiplicarlo
        mul bx          ;multiplicamos por 10 (bx=10)
        add al, cl      ;al ressultado le añadimos el valor de cl
        mov numero, ax  ;resultado final a numero 
        jnz leerNumero  ;como al!=13 leemos otro digito
     finLectura:
        ret
    
ends

end start ; set entry point and stop the assembler.
