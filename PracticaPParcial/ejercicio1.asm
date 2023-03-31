;1. Realizar un direccionamiento inmediato en el 
;   registro BX con el valor de 100 luego realizar
;   un direccionamiento de registro de BX en AX y 
;   multiplicarlo por 10.

code segment
  
start:
    mov bx, 100
    mov ax, bx
    mov bx, 10
    mul bx    
ends

end start ; set entry point and stop the assembler.