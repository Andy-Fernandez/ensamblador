; en este ejercicio se busca un 'trio social'
; dados 3 numeros, la suma de los divisores del primero
; tienen que dar el segundo numero. 
data segment
    ; add your data here!
    num1 db ?
    num2 db ?
    num3 db ?
    aux1 db ? 
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
; asignamos y guadando variables
    mov bh, 20
    mov num1,bh 
    mov bl, 22 
    mov num2,bl
    mov ch, 14
    mov num3, ch 

; sacamos el divisor del primero  
; inicializar la suma en 0
    mov aux1, 0
    
    ; dividir entre cada posible divisor y sumar si la division es exacta
    mov cx, 0
    mov cl, num1
    
        push ax
        push dx
        mov dl, cl
        add dl, '0'
        mov ah, 2
        int 21h
        pop dx
        pop ax
    
    mov bx, 1
    
    div_loop:
        inc bx      ; siguiente divisor
        cmp bx, cx  ; se han probado todos los posibles divisores?
        jg end_loop
        mov ax, cx  ; dividendo = divisor
        mov dx, 0
        div bx      ; división entera
        cmp dx, 0   ; la division es exacta?
        jne div_loop
        add aux1, bl ; sumar el divisor a la suma
        
        
        push ax
        push dx
        mov dl, bl
        add dl, '0'
        mov ah, 2
        int 21h
        pop dx
        pop ax
        
        jmp div_loop
    


;    loop_while:
;        cmp cx, 11 ; comparar cx con 11
;        jge fin_while ; si cx >= 11, salir del loop
;        
;        add cx, 1 ; incrementar cx
;        mov dl, cx
;        add dl, '0'
;        mov ah, 2
;        int 21h
;        jmp loop_while ; volver al inicio del loop

    end_loop:
    mov ax, 0
    mov al, aux1     
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
                                                     
                                                     
