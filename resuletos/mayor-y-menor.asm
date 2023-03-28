; FUNCIONA
; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$" 
    hello db "Hello world$"
    esmenor db "es menor$"
    soniguales db "son iguales$"
    esmayor db "es mayor$"
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
    mov ax, 20
    mov bx, 30
    cmp ax,bx
    jc esmen
    jz esig
    jnz esmay
    esmen:
    lea dx, esmenor
    mov ah, 9
    int 21h
    jmp fin
    esig:
    lea dx, soniguales
    mov ah, 9
    int 21h
    jmp fin
    esmay:
    lea dx, esmayor
    mov ah, 9
    int 21h
    jmp fin
    
    fin:
    mov bx,cx
    ;
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler