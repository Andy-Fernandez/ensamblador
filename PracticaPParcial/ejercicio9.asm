; multi-segment executable file template.

data segment
    ; add your data here!
    num1 db ?  ; solo podemos usar asignacion de 8bits 
    nMensaje db "n: $"
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
    
    ; mensaje
    lea dx, nMensaje
    mov ah, 9
    int 21h
    
    ; leer el primer digito
    mov ah, 1 
    int 21h
    sub al, '0' 
    mov num1, al 
    
    ; salto de linea    
    mov ah, 2     
    mov dl, 13    
    int 21h       
    mov dl, 10    
    int 21h
    
    ; IMPRIMIMOS LA SERIE:  
    
    ;mostramos la secuencia
    mov cx, 0
    mov cl, num1
    mov bx, 50
    mostrar:
        mov ah, 2 
        mov dl, bl
        add bl, 2 
        int 21h
        loop mostrar
        
    mov ah, 4ch 
    int 21h        
ends

end start ; set entry point and stop the assembler.
