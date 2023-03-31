
code segment
start:
    
    ; usaremos un loop, el abecesario en minuscula
    ; en ascii va desde el 97 al 122
    ; y las mayusculas del 65 al 90 
    
    ; hay una diferencia de 32 entre minusculas y 
    ; mayusculas
        
    mov bh, 96 ;iniciamos ax en 96
    mov ch, 1  ;ch = 1 para mayusculas y 0 para min 
    
    loop1:
    
        ;nuestro ch ser la flag
        cmp ch, 0
        jz aumentar
        jne disminuir
        continue: 

        inc bh   
        mov dl, bh  
        mov ah, 2
        int 21h        
        
        cmp bh, 122
        jz fin
        jmp loop1
    
    aumentar:
        mov cl, 32
        add bh, cl
        mov ch, 1
        jmp continue
    
    disminuir:
        mov cl, -32
        add bh, cl
        mov ch, 0
        jmp continue  
   
    fin:        
      
ends

end start ; set entry point and stop the assembler.
