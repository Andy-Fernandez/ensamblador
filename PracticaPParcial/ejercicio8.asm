;8. Realizar un programa que lea 2 dígitos e imprima la suma y resta de los mismos
; multi-segment executable file template.

data segment
    ; add your data here!
    num1 db ?
    num2 db ?
    sumaC db "La suma es: $" 
    restaC db "La resta es: $"
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
    
    ; salto de linea 
    mov ah, 2     
    mov dl, 13    
    int 21h       
    mov dl, 10    
    int 21h  
    
    ; leer el segundo digito
    mov ah, 1 ; función 1 de la interrupción 21h para leer un carácter
    int 21h
    sub al, '0' ; convertir el carácter a número
    mov num2, al ; guardar el número en la variable num2
    
    ; salto de linea
    mov ah, 2     
    mov dl, 13    
    int 21h       
    mov dl, 10    
    int 21h
    
    lea dx, sumaC
    mov ah, 9
    int 21h  
    
    ; SUMA
    mov ah, num1
    add ah, num2
    
    mov al, ah
    mov ah, 0
    
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
    
    ; salto de linea
    mov ah, 2     
    mov dl, 13    
    int 21h       
    mov dl, 10    
    int 21h
    
    lea dx, restaC
    mov ah, 9
    int 21h
    
    ; RESTA
    mov ah, num1
    sub ah, num2
    
    mov al, ah
    mov ah, 0
    
    mov bx, 10
    mov cx, 0

    digitoR:
        xor dx, dx
        div bx
        push dx
        inc cx
        test ax, ax
        jnz digitoR
    
    imprimirR:
        pop dx
        add dl, '0'
        mov ah, 2
        int 21h
        loop imprimirR
        
ends

end start ; set entry point and stop the assembler.
