data segment
    numero dw 0
    len dw 0  
    pila dw 100h dup(0)
    ocurrencias dw 10 dup(0) ; vector para contar las ocurrencias de cada número
ends

code segment
start:
    ; set segment registers:
    mov ax, data
    mov ds, ax
    
    ; 1) leer numero y longitud 
    call pideNumero
    
    ; 2) Contar ocurrencias de cada número
    loop_while:
        cmp len, 0 ; comparar len con 0
        je fin_while ; si len == 0, salir del loop
        
        ; Cargar el valor de ax
        pop ax
        
        ; Incrementar la ocurrencia del número correspondiente en el vector
        inc ocurrencias[ax]
        
        ; Decrementar len
        dec len
        
        ; Volver al inicio del loop
        jmp loop_while
    
    fin_while:
    
    ; 3) Encontrar el número con mayor ocurrencia
    mov mayor, 0
    
    loop_ocurrencias:
        cmp bx, 10 ; comparar bx con 10 (tamaño del vector)
        je fin_ocurrencias ; si bx == 10, salir del loop
        
        ; comparar la ocurrencia del número actual con la ocurrencia del número mayor
        mov ax, ocurrencias[bx]
        cmp ax, mayor
        jle siguiente_numero
        
        ; si la ocurrencia del número actual es mayor que la del número mayor, actualizar mayor y mayor_num
        mov mayor, ax
        mov mayor_num, bx
        
        siguiente_numero:
        ; Incrementar bx
        inc bx
        
        ; Volver al inicio del loop
        jmp loop_ocurrencias
    
    fin_ocurrencias:
    
    ; 4) Imprimir el número con mayor ocurrencia
    mov dx, mayor_num
    add dx, 48 
    mov ah, 2
    int 21h 
    
    ; 5) Salir del programa
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
        
        ; guardamos el numero en la pila
        mov ah, 0
        push ax

        mov ax, numero  ;ax=numero para multiplicarlo
        mul bx          ;multiplicamos por 10 (bx=10)
        add al, cl      ;al ressultado le añadimos el valor de cl
        mov numero, ax  ;resultado final a numero 
        jnz leerNumero  ;como al!=13 leemos otro digito
     finLectura:
        ret
    
ends

end start ; set entry point and stop the assembler.
