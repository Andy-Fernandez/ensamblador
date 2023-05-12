data segment
    vector db 13, 15, 18, 13, 10
    len dw 5
    enter db 10,13,'$'
    espacio db 32,'$'
    aux dw 0
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax
    
    call imprimirVector
    
    mov ax, 4c00h ; exit to operating system.
    int 21h
    
    imprimirVector:
        mov si, offset vector   ; Carga la dirección base del vector en SI
        mov cx, len             ; Carga la longitud del vector en CX

    loop_while:
        xor ax, ax 
        mov al, [si]            ; Lee el valor actual del vector en AL
        mov aux, cx
        call imprime            ; Llama a la función imprime para imprimir el valor
        mov cx, aux
           
        inc si                  ; Incrementa SI para apuntar al siguiente elemento
        loop loop_while         ; Repite el ciclo hasta que CX sea cero
    
    fin:
        ret
    
    ;) Imprimimos un numero
    imprime:
        push ax         ; Guarda el valor original de AX
        push bx         ; Guarda el valor original de BX
        mov bx, 10      ; Divisor
        mov cx, 0       ; Contador de dígitos
    
        reducir:
            xor dx, dx  ; Limpia el registro DX
            div bx      ; Divide AX entre BX, el cociente queda en AL y el residuo en AH
            push dx     ; Guarda el dígito en la pila
            inc cx      ; Incrementa el contador de dígitos
            test ax, ax ; Verifica si AX es cero
            jnz reducir ; Si no es cero, repite el ciclo
    
        mostrar:
            pop dx      ; Toma el dígito de la pila
            add dl, 48  ; Convierte el dígito en un carácter ASCII
            mov ah, 2   ; Servicio de impresión en pantalla
            int 21h     ; Imprime el carácter
            loop mostrar ; Repite el ciclo hasta que CX sea cero
        
        lea dx, espacio  ;mostrar con espacio
        ;lea dx, enter   ;mostrar con enter
        mov ah, 9
        int 21h
        pop bx          ; Restaura el valor original de BX
        pop ax          ; Restaura el valor original de AX
        ret   
ends

end start
