; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "Numero: $"  
    numero dw 0
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
    
    call pideNumero
    mov bx, numero  ;asigna a BX el numero leído 

    ; add your code here
            
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    
    ; imprime el numero
    mov ax, numero
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
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
    
    pideNumero:
        mov numero, 0
        mov bx, 10
        
    leerNumero:
        mov ah, 1
        int 21h     ;interrupcion 
        cmp al,13   ;13 es enter 
        jz finLectura
        sub al,48   ;le restamos 48 para imrprimir
        mov cx, 0
        mov cl, al
        mov ax, numero 
        mul bx
        add al, cl
        mov numero, ax
        jnz leerNumero
     finLectura:
        ret
    
      
    
ends

end start ; set entry point and stop the assembler.
