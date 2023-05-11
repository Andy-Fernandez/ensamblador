; multi-segment executable file template.

data segment
    ; add your data here!
    vector db 13, 15, 18, 13, 10
    len dw 9
    enter db 10,13,'$'
    espacio db 32,'$'
    aux dw 0
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
        call imprime           ; Llama a la función imprime para imprimir el valor
        mov cx, aux
           
        inc si                  ; Incrementa SI para apuntar al siguiente elemento
        loop loop_while         ; Repite el ciclo hasta que CX sea cero
    
    fin:
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
ends

end start ; set entry point and stop the assembler.
