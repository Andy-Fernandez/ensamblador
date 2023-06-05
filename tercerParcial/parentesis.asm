data segment
    err db "ERROR$"  
    ok db "OK$"
    enter db 10,13,'$'
    espacio db 32,'$'
    len dw 0
    contador dw 0
    aux dw 0
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax  

    
    mov ax, 0
    push ax 
    jmp conPila

    leerCadena:
        pop ax
        cmp ax, 0
        jz conti
        push ax
        conPila:
        mov ah,1
        int 21h
        cmp al, 13   ; Terminar en al 13 (Enter)
        jz conti
        cmp al, 32   ; Terminar en al 32 (espacio)
        jz conti
        cmp al, 40     ; 40 ( 
        jz anadir
        cmp al, 41     ; 41 ) 
        jz elim       
        cmp al, 91     ; 91 [ 
        jz anadir
        cmp al, 93     ; 93 ]
        jz elim                
        cmp al, 123    ; 123 { 
        jz anadir
        cmp al, 125    ; 125
        jz elim
        jnz leerCadena
        
    conti:
        call return
        pop ax
        cmp ax, 0
        jnz error 
        mov ax, aux
        cmp ax, 1
        jz error 
        mov ah, 0
        lea dx, ok
        mov ah, 9
        int 21h    
        jmp terminado 
       
    anadir:
        mov ah, 0
        push ax
        jmp leerCadena
        
    elim: 
        mov ah, 0
        pop ax
        cmp ax, 40
        jz leerCadena
        cmp ax, 91
        jz leerCadena
        cmp ax, 123
        jz leerCadena
        jmp error1
    
    error1:
        mov aux, 1
        jmp leerCadena       
    
    error: 
        call return
        lea dx, err
        mov ah, 9
        int 21h    
        jmp terminado
    
    return:
        lea dx, enter
        mov ah, 9
        int 21h    
        ret
        
    terminado:
        mov ax, 4c00h
        int 21h

end start ; set entry point and stop the assembler.


