me ayudas a resolver este ejercicio usando vectores:
me puedes ayuda a resolver este ejercicio pero usando vectores:
; multi-segment executable file template.

data segment
    numero dw 0
    len dw 0  
    auxiliar dw 0
    contador dw 0
    numAComparar dw 0
    var0 dw 0
    var1 dw 0
    var2 dw 0
    var3 dw 0
    var4 dw 0
    var5 dw 0
    var6 dw 0
    var7 dw 0
    var8 dw 0
    var9 dw 0
    mayor dw 0
    mayor_num dw 0
ends

stack1 segment stack
    dw 100h dup(0)
ends

stack2 segment stack
    dw 100h dup(0)
ends

stack3 segment stack
    dw 100h dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    
    ; 1) leer numero y longitud 
    call pideNumero
    continue:
    mov bx, numero  ;asigna a BX el numero leído
    mov len, cx
  
    
    ; 2) Mostramos los valores de la pila:
    loop_while:
        cmp cx, 0 ; comparar cx con 0
        je fin_while ; si cx == 0, salir del loop
        
        
        ; Cargar el valor de ax
        pop ax
    
        ; Comparar con var1
        mov bx, 1
        cmp ax, bx
        je igual_var1
    
        ; Comparar con var2
        mov bx, 2
        cmp ax, bx
        je igual_var2
    
        ; Comparar con var3
        mov bx, 3
        cmp ax, bx
        je igual_var3
    
        ; Comparar con var4
        mov bx, 4
        cmp ax, bx
        je igual_var4
    
        ; Comparar con var5
        mov bx, 5
        cmp ax, bx
        je igual_var5
    
        ; Comparar con var6
        mov bx, 6
        cmp ax, bx
        je igual_var6
    
        ; Comparar con var7
        mov bx, 7
        cmp ax, bx
        je igual_var7
    
        ; Comparar con var8
        mov bx, 8
        cmp ax, bx
        je igual_var8
    
        ; Comparar con var9
        mov bx, 9
        cmp ax, bx
        je igual_var9
    
        ; Comparar con var0
        mov bx, 0
        cmp ax, bx
        je igual_var0
    
        ; Si no se encontró igualdad, salir del programa
        jmp fin
    
        ; Si se encontró igualdad, aumentar el valor de la variable correspondiente
        igual_var1:
            add var1, 1
            jmp fin
    
        igual_var2:
            add var2, 1
            jmp fin
    
        igual_var3:
            add var3, 1
            jmp fin
    
        igual_var4:
            add var4, 1
            jmp fin
    
        igual_var5:
            add var5, 1
            jmp fin
    
        igual_var6:
            add var6, 1
            jmp fin
    
        igual_var7:
            add var7, 1
            jmp fin
    
        igual_var8:
            add var8, 1
            jmp fin
    
        igual_var9:
            add var9, 1
            jmp fin
    
        igual_var0:
            add var0, 1
        
        fin:
        ; Decrementar cx
        dec cx
        
        ; Volver al inicio del loop
        jmp loop_while
    
    fin_while:
    
    ; si var0 es mayor que mayor, actualizar mayor
    mov mayor, 0
    
    comparar_var1:
        ; comparar var1 con mayor
        mov ax, var1
        cmp ax, mayor
        jle comparar_var2
    
        ; si var1 es mayor que mayor, actualizar mayor y mayor_num
        mov mayor, ax
        mov mayor_num, 1
    
    comparar_var2:
        ; comparar var2 con mayor
        mov ax, var2
        cmp ax, mayor
        jle comparar_var3
    
        ; si var2 es mayor que mayor, actualizar mayor y mayor_num
        mov mayor, ax
        mov mayor_num, 2
    
    comparar_var3:
        ; comparar var3 con mayor
        mov ax, var3
        cmp ax, mayor
        jle comparar_var4
    
        ; si var3 es mayor que mayor, actualizar mayor y mayor_num
        mov mayor, ax
        mov mayor_num, 3
    
    comparar_var4:
        ; comparar var4 con mayor
        mov ax, var4
        cmp ax, mayor
        jle comparar_var5
    
        ; si var4 es mayor que mayor, actualizar mayor y mayor_num
        mov mayor, ax
        mov mayor_num, 4
    
    comparar_var5:
        ; comparar var5 con mayor
        mov ax, var5
        cmp ax, mayor
        jle comparar_var6
    
        ; si var5 es mayor que mayor, actualizar mayor y mayor_num
        mov mayor, ax
        mov mayor_num, 5
    
    comparar_var6:
        ; comparar var6 con mayor
        mov ax, var6
        cmp ax, mayor
        jle comparar_var7
    
        ; si var6 es mayor que mayor, actualizar mayor y mayor_num
        mov mayor, ax
        mov mayor_num, 6
    
    comparar_var7:
        ; comparar var7 con mayor
        mov ax, var7
        cmp ax, mayor
        jle comparar_var8
    
        ; si var7 es mayor que mayor, actualizar mayor y mayor_num
        mov mayor, ax
        mov mayor_num, 7
    
    comparar_var8:
        ; comparar var8 con mayor
        mov ax, var8
        cmp ax, mayor
        jle comparar_var9
    
        ; si var8 es mayor que mayor, actualizar mayor y mayor_num
        mov mayor, ax
        mov mayor_num, 8
    
    comparar_var9:
        ; comparar var9 con mayor
        mov ax, var9
        cmp ax, mayor
        jle mostrarMayor
    
        ; si var9 es mayor que mayor, actualizar mayor
        mov mayor, 9
        
    
    mostrarMayor:
        ; imprimir el valor de mayor
        mov dx, mayor_num
        add dx, 48 
        mov ah, 2
        int 21h 
    
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
        jmp continue
    
ends

end start ; set entry point and stop the assembler.
