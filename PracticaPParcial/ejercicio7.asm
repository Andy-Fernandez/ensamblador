; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
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
    
    factoria:
           
ends

end start ; set entry point and stop the assembler.
