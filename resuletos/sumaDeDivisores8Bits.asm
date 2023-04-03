; Este programa suma los divisores del valor en BL y los guarda en la variable suma1
data segment
    suma1 db 0
ends

stack segment
    dw 128 dup(0)
ends

code segment
start:
    ; Configurar segmentos
    mov ax, data
    mov ds, ax
    mov es, ax

    ; Inicializar variables
    mov bl, 22
    mov cl, 0

    divisores:
        inc cl
        cmp cl, bl   ; comparar cx=bl, si es true salta a fin
        jge fin

        mov al, bl
        mov ah, 0    ; esto para hacer la division
        div cl       ; dividir AL entre CL
        cmp ah, 0    ; verificar si la división es exacta
        jne divisores
        add suma1, cl ; como la división es exacta, sumar CX al resultado
        jmp divisores

    fin:
        ; Salida del programa
        mov dl, suma1
        mov ah, 4ch
        int 21h

end start
