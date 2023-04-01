; multi-segment executable file template.

data segment
    ; add your data here!
    num1 db ?
    num2 db ?
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
 
    ; leer el primer digito
    mov ah, 1 ; función 1 de la interrupción 21h para leer un carácter
    int 21h
    sub al, '0' ; convertir el carácter a número
    mov num1, al ; guardar el número en la variable num1

    ; leer el segundo digito
    mov ah, 1 ; función 1 de la interrupción 21h para leer un carácter
    int 21h
    sub al, '0' ; convertir el carácter a número
    mov num2, al ; guardar el número en la variable num2

    ; imprimir los números leídos para verificar
    mov ah, 2 ; función 2 de la interrupción 21h para imprimir un carácter
    add num1, '0' ; convertir el número a carácter
    mov dl, num1 ; cargar el carácter en dl
    int 21h
    add num2, '0' ; convertir el número a carácter
    mov dl, num2 ; cargar el carácter en dl
    int 21h

    mov ah, 4ch ; función 4Ch de la interrupción 21h para salir del programa
    int 21h    
ends

end start ; set entry point and stop the assembler.
