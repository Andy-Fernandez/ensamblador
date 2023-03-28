; en este programa se busca dado un bx, que convirtiendolo a binario tenga 4 1's seguidos
; Ejemplo:
;   12 110 no es 
;   15 1111 si es
;   90 1011010 no es

; multi-segment executable file template.

data segment
    ; add your data here!
    num1 dw 0
    div2 dw 2 
    
 
    
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
    
    ; guardamos nuestra variable y declaramos otras 
    mov bx, 15
    mov num1, bx
    mov ax, bx ; ax = bx porque en ax se hacen las operaciones 
    mov cx, 0 ;nuestro contador
    
    ; comemzamos las divsiones hasta un bx = 0/1
    divs:
        mov dx, 0 ; para dividir ponemos dx en 0
        div ax, div2 ; ax/div2
        
        ; comparamos el resto osea dx
        cmp dx, 0
        jnz restoUno
        ;si el resto no es uno
        mov cx = 0
        continue: 
        
        
        ; el bucle termina si:
        ; ax = 0
        cmp ax, 0
        jz fin
        ; ax = 1
        cmp ax, 1
        jz fin
        ; si no vuelve a entrar  
        jmp divs
    
    restoUno:
        inc cx
        jmp continue  
        
    fin:
         
        
    
                             
ends

end start ; set entry point and stop the assembler.
