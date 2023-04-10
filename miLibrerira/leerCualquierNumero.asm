; multi-segment executable file template.

data segment
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

    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
    
    pideNumero:
        mov numero, 0
        mov bx, 10
        
    leerNumero:
        mov ah, 1
        int 21h         ;interrupcion 
        cmp al,13       ;13 es enter 
        jz finLectura   
        sub al,48       ;le restamos 48 para imrprimir
        mov cx, 0
        mov cl, al      ;guardamos el numero leido en cl
        mov ax, numero  ;ax=numero para multiplicarlo
        mul bx          ;multiplicamos por 10 (bx=10)
        add al, cl      ;al ressultado le añadimos el valor de cl
        mov numero, ax  ;resultado final a numero 
        jnz leerNumero  ;como al!=13 leemos otro digito
     finLectura:
        ret
    
ends

end start ; set entry point and stop the assembler.
