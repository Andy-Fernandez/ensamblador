;2. Realizar un programa que imprima su nombre 
;   completo, edad y semestre
; multi-segment executable file template.

data segment
    ; add your data here!
    name_ db "Nombre: Pablo Andres Fernandez Cari$"
    age db "Edad: 22$"
    semester db "Semestre: 5to$" 
ends
code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
            
    lea dx, name_
    mov ah, 9
    int 21h        
    
    mov ah, 2     
    mov dl, 13    
    int 21h       
    mov dl, 10    
    int 21h       
    
    lea dx, age
    mov ah, 9
    int 21h        
    
    mov ah, 2     
    mov dl, 13    
    int 21h       
    mov dl, 10    
    int 21h       
        
    
    lea dx, semester
    mov ah, 9
    int 21h        
      
ends

end start ; set entry point and stop the assembler.
