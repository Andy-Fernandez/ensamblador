;NUMERO APOCALIPTICO

; multi-segment executable file template.
data segment
; add your data here!
t1 db "es apocaliptico$"
t2 db "no es apocaliptico$"
numerador dw 1
denominador dw 52
suma dw 0
ends
stack segment
dw 128 dup(0)
ends
code segment
start:
; set segment registers:
mov ax, data
mov ds, ax
mov es, ax
; add your code here
mov cx,denominador
mov ax,1
mov bx,cx
div bx
mov cx,66

ciclo:
mov ax,dx
mov bx,10
mul bx
mov bx,denominador
div bx
push ax
loop ciclo

mov cx,66
mov ax, 0
        ciclo2:
           pop dx
           cmp dx, 6
           jz contador
           jnz posible
        posible:
            mov ax, 0 
            cmp cx, 0
            jz salta2  
            loop ciclo2
        
        contador: 
           inc ax
           cmp ax, 3
           jz imprime
           cmp cx, 0
           jz salta2
           loop ciclo2 
           
        salta2:   
           lea dx, t2
           mov ah, 9
           int 21h
           
           jmp fin
        
        imprime:
            lea dx, t1
            mov ah, 9
            int 21h
            jmp fin
        
            
        fin:  
    


; wait for any key....
.exit
end start ; set entry point and stop the assembler.