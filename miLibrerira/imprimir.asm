; en este programa no se una CX y BX
; los unicos que cambian son AX y DX

data segment
    ; add your data here!
    cadena db "ejemplo de cadena $"
    otraCadena db "otra cadena$"
    var1Digito dw 6
    var2Digitos dw 65535 ; este es su limite
    var2Negativo dw -32768 ; maximo negativo 
    signoNegativo db "-$" ; cadena a imprimir si el número es negativo 
 
ends
code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

; imprimir cadenaa              
    lea dx, cadena
    mov ah, 9
    int 21h        

; salto de linea    
    mov ah, 2     
    mov dl, 13    
    int 21h       
    mov dl, 10    
    int 21h       

; otra cadena   
    lea dx, otraCadena
    mov ah, 9
    int 21h

; salto de linea    
    mov ah, 2     
    mov dl, 13    
    int 21h       
    mov dl, 10    
    int 21h
 
; variable de 1 digito 
    mov dx, var1Digito; direccionamos 
    add dl, '0'       ; sumar el codigo ASCII de '0' al digito para convertirlo en caracteres
    mov ah, 2         
    int 21h

; salto de linea    
    mov ah, 2     
    mov dl, 13    
    int 21h       
    mov dl, 10    
    int 21h

; variable de 2 o mas
; en esta impresion ya se hace el uso del stack, bx y cx 
    mov ax, var2Digitos
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
 
; variable de 2 o mas NEGATIVO
; en esta impresion ya se hace el uso del stack, bx y cx 
    mov ax, var2Negativo
    mov bx, 10
    mov cx, 0
    
    ; determinar si el número es negativo
    test ax, 8000h ; verifica el bit de signo
    jz digitoN ; si no esta activo, el número es positivo
    neg ax ; si está activo, convierte el número en su complemento a 2
    
    push ax
    lea dx, signoNegativo
    mov ah, 9
    int 21h
    pop ax
    
    digitoN:
        xor dx, dx
        div bx
        push dx
        inc cx
        test ax, ax
        jnz digitoN
    
    imprimirN:
        pop dx
        add dl, '0'
        mov ah, 2
        int 21h
        loop imprimirN
        
    fin:
        ; aquí puedes colocar cualquier código adicional que necesites antes de terminar el programa
        ; retornar desde la función
                   
        

ends

end start ; set entry point and stop the assembler.
