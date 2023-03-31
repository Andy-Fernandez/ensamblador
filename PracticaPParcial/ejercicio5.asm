;5. Realizar la serie de Fibonacci y mostrar por pantalla de siguiente forma
;1 1 2 3 5 8 = E R g ....

data segment
    num1 dw 0;
ends 
code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; declaracion
    mov ax, 0; a = 0 
    mov bx, 1; b = 1
    
    loop1:
        ; interaciones
        mov cx, ax
        add cx, bx  ; x = a + b
        
        mov bx, ax; b = a
        mov ax, cx; a = x
        push bx ; guardamos bx
        push ax ; guardamos ax
        
        mov bh, cl
        add bh, 48
        mov dl, bh  
        mov ah, 2
        int 21h
        
        pop ax ; recuperamos ax
        pop bx ; recuperamos bx        
        
        cmp bh, 122
        jz fin
        jmp loop1
    fin:        
      
ends

end start ; set entry point and stop the assembler.
