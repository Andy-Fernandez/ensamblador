; multi-segment executable file template.

data segment
    numero dw 0
    len dw 0  
    auxiliar dw 0
    contador dw 0
    numAComparar dw 0
    var dw 10 dup(0)
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
    
        ; Comparar con var[0]
        mov bx, 0
        cmp ax, bx
        je igual_var0

        ; Comparar con var[1]
        mov bx, 1
        cmp ax, bx
        je igual_var1
    
        ; Comparar con var[2]
        mov bx, 2
        cmp ax, bx
        je igual_var2
    
        ; Comparar con var[3]
        mov bx, 3
        cmp ax, bx
        je igual_var3
    
        ; Comparar con var[4]
        mov bx, 4
        cmp ax, bx
        je igual_var4
    
        ; Comparar con var[5]
        mov bx, 5
        cmp ax, bx
        je igual_var5
    
        ; Comparar con var[6]
        mov bx, 6
        cmp ax, bx
        je igual_var6
    
        ; Comparar con var[7]
        mov bx, 7
        cmp ax, bx
        je igual_var7
    
        ; Comparar con var[8]
        mov bx, 8
        cmp ax, bx
        je igual_var8
    
        ; Comparar con var[9]
        mov bx, 9
        cmp ax, bx
        je igual_var9
    
        ; Si no se encontró igualdad, salir del programa
        jmp fin
    
        ; Si se encontró igualdad, aumentar el valor de la variable correspondiente
        igual_var0:
            add var[bx], 1
            jmp fin
    
        igual_var1:
            add var[bx], 1
            jmp fin
    
        igual_var2:
            add var[bx], 1
            jmp fin
    
        igual_var3:
            add var[bx], 1
            jmp fin
    
        igual_var4:
            add var[bx], 1
            jmp fin
    
        igual_var5:
            add var[bx], 1
            jmp fin
    
        igual_var6:
            add var[bx], 1
            jmp fin
    
        igual_var7:
            add var[bx], 1
            jmp fin
    
        igual_var8:
            add var[bx], 1
            jmp fin
    
        igual_var9:
            add var[bx], 1
        
        fin:
        ; Decrementar
