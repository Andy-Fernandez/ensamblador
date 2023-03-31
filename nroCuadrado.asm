; en este programa se busca dado un bx, que convirtiendolo a binario tenga 4 1's seguidos
; Ejemplo:
;   12 110 no es 
;   15 1111 si es
;   90 1011010 no es
;   1179 10010011011

; multi-segment executable file template.

data segment
    ; add your data here!
    num1 dw 0
    div2 dw 2
    cuadrado db "Es cuadradp$"
    noCuadrado db "No es cuadrado$" 
    
 
    
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
        div div2 ; ax/div2
        
        ; comparamos el resto osea dx
        cmp dx, 0
        jnz restoUno
        ;si el resto no es uno
        mov cx, 0
        continue:
        
        ; comparamos cx=4 para terminar el bucle
        cmp cx, 4
        jz fin  
        
        
        ; el bucle termina si:
        ; ax = 0
        cmp ax, 0
        jz fin
        ; ax = 1
        ; comparmparamos el ultimo divisor si ax=1 -> cx++
        cmp ax, 1
        jz restoUno
        ; si no vuelve a entrar  
        jmp divs
    
    restoUno:
        inc cx
        cmp ax, 1
        jz fin
        jmp continue  
        
    fin:
        ; comparamos cx=4
        cmp cx, 4
        jz siCuadrado
        jne noEsCuadrado
    
    
    siCuadrado:
        lea dx, cuadrado
        mov ah, 9
        int 21h
        jmp fin2
     
    noEsCuadrado:
        lea dx, noCuadrado
        mov ah, 9
        int 21h
        jmp fin2 
        
    fin2:     
        
    
                             
ends

end start ; set entry point and stop the assembler.