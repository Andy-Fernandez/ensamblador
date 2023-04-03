; en este ejercicio se busca un 'trio social'
; dados 3 numeros, la suma de los divisores del primero
; tienen que dar el segundo numero. 
; Haciendo la asignacion en BX, este programa
; asigna la suma los divisores de BX en una variable
; suma1
data segment
    suma1 dw 0
    num1 dw ?
    num2 dw ?
    num3 dw ?
    aux1 dw ? 
    noson db "No es un triosociable$"
    sison db "Es un triosociable$"
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
    
    mov bh, 18
    mov ax, 0
    mov al, bh
    mov num1,ax 
    mov bl, 25
    mov al, bl 
    mov num2,ax
    mov ch, 33
    mov al, ch
    mov num3, ax 

    ; Mostrar divisores de BX
    mov bx, num1 
    mov ax, bx   
    mov cx, 0

    divisores:
        inc cx
        cmp cx, bx       ; compara cx=bx, si es true salta a fin
        jge one          ; son iguales

        mov dx, 0        ; para hacer la operacion
        mov ax, bx 
        div cx
        cmp dx, 0        ; verifica si es exacta
        jne divisores
        add suma1, cx    ; como es exacta CX se suma al resultado
        jmp divisores
    
    one:
    mov ax, num2
    cmp suma1, ax
    jge continue
    jmp noSonF
    continue:
    
    mov suma1, 0
    mov bx, num2 
    mov ax, bx   
    mov cx, 0

    divisores2:
        inc cx
        cmp cx, bx       ; compara cx=bx, si es true salta a fin
        jge two          ; son iguales

        mov dx, 0        ; para hacer la operacion
        mov ax, bx 
        div cx
        cmp dx, 0        ; verifica si es exacta
        jne divisores2
        add suma1, cx    ; como es exacta CX se suma al resultado
        jmp divisores2
    
    two:
    mov ax, num3
    cmp suma1, ax
    jge siSonF
    jmp noSonF
    
    noSonF:
         lea dx, noson
         mov ah, 9
         int 21h
         jmp fin
         
    siSonF:
         lea dx, sison
         mov ah, 9
         int 21h
         jmp fin
         
    
    
    fin:
        ; Salida del programa
        mov dx, suma1
        mov ah, 4ch
        int 21h

end start
                                                     
