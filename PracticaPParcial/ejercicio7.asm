; multi-segment executable file template.

data segment
    ; add your data here!
    mensaje1 db "Factorial: $"
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

    ; add your code here
    
    mov bx, 5
    mov ax, bx ; en ax se almacenara el producto
    
    factorial:
        dec bx
        mul bx
        
        cmp bx, 1
        je mostrar
        jne factorial 
     
     mostrar:
        push ax
        lea dx, mensaje1
        mov ah, 9
        int 21h        ; output string at ds:dx 
        pop ax
        
        mov bx, 10     
        mov cx, 0      
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
        
        
           
ends

end start ; set entry point and stop the assembler.
