; 3. Realizar un programa que imprima todo el abecedario ya
;    se en mayúsculas o minúsculas por pantalla


code segment
start:
    
    ; usaremos un loop, el abecesario en minuscula
    ; en ascii va desde el 97 al 122
    
    mov bh, 96 ;iniciamos ax en 96
    loop1:
        
        inc bh   
        mov dl, bh  
        mov ah, 2
        int 21h        
        
        cmp bh, 122
        jz bh, fin
        jmp loop1      
   
    fin:        
      
ends

end start ; set entry point and stop the assembler.
