; multi-segment executable file template.

data segment
    ; add your data here!
    num1 dw 28
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov bx, 28
    mov num1, bx

; set segment registers: 
; 
    mov dx, 0   ;ponemos dx en 0 para dividir 
    mov ax, bx  ;copinamos bx en ax 
    mov bx, 2   ;bx = 2
    div bx      ;ax/bx
    mov cx, ax  ;cx sera el inicio para el loop
    
    mov bx, 0   ;bx = 0 para contar los push
    
    loop:
        mov dx, 0
        mov ax, num1
        div cx
        cmp dx, 0
        jz aumentar
        continuar:       
        loop loop
    
    aumentar:
        inc bx
        push cx
        ;### tenemos ERROR, llega un un loop infinito ### 
        jmp continuar
    
    ;sumamos los numeros
    mov cx, bx ;bx = cx
    mov ax, 0  ;ax = 0 para contar la suma
    
    loop1:
        pop bx
        add ax, bx
        loop loop1
        
    
 
    
     
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
