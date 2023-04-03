; Haciendo la asignacion en BX, este programa
; asigna la suma los divisores de BX en una variable
; suma1
data segment
    suma1 dw 0
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

    ; Mostrar divisores de BX
    mov bx, 22
    mov ax, bx   
    mov cx, 0

    divisores:
        inc cx
        cmp cx, bx       ; compara cx=bx, si es true salta a fin
        jge fin          ; son iguales

        mov dx, 0        ; para hacer la operacion
        mov ax, bx 
        div cx
        cmp dx, 0        ; verifica si es exacta
        jne divisores
        add suma1, cx    ; como es exacta CX se suma al resultado
        jmp divisores

    fin:
        ; Salida del programa
        mov dx, suma1
        mov ah, 4ch
        int 21h

end start
