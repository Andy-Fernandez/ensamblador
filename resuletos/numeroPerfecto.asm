; Este es un programa en lenguaje ensamblador que determina si un número entero positivo 
; es un número perfecto o no. Un número perfecto es aquel que es igual a la suma de sus 
; divisores propios, es decir, aquellos divisores que son menores que el número en cuestión.

; El programa utiliza un algoritmo que divide el número entre los valores de n que van desde 
; num1/2 hasta 1, y almacena los divisores que encuentra en una pila. Después, suma los valores 
; almacenados en la pila para verificar si la suma es igual al número original. Si la suma es 
; igual, el programa indica que el número es perfecto. De lo contrario, indica que el número 
; no es perfecto.

; multi-segment executable file template.

data segment
    ; add your data here!
    num1 dw 28
    perfecto db "Es perfecto$"
    noEsPerfecto db "No es perfecto$"
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
    
    ; guardamos nuestra variable
    mov bx, 497
    mov num1, bx


    ; Definimos el n=bx/2 que sera el inicio del loop 
    mov dx, 0   ;ponemos dx en 0 para dividir 
    mov ax, bx  ;copinamos bx en ax 
    mov bx, 2   ;bx = 2
    div bx      ;ax/bx
    mov cx, ax  ;cx sera el inicio para el loop
 
    ;con bx contaresmo divisores anadidos al stack    
    mov bx, 0   ;bx = 0 para contar los push
    
    loop1:
        mov dx, 0
        mov ax, num1
        div cx
        cmp dx, 0 ; comparamos si es igual a 0
        jz aumentar ; en caso de ser igual a 0, lo agragamos a la cola de divisores 
        continuar:
        
        ; para evitar cilcos infitos comparamos CX==0
        cmp cx, 1
        jz mostrarDivisores
               
        loop loop1
    
    aumentar:
        inc bx
        push cx
        ;### tenemos ERROR, llega un un loop infinito ### 
        jmp continuar
    
    ; Sacamos los elementos del stack y mostramos
    mostrarDivisores:
        mov cx, bx  ; cx=bx es nuestro contador 
        mov ax, 0   ; aqui sumaremos todos los divisores
        loop2: 
            pop bx
            add ax, bx  ; sumamos cada divisor 
            loop loop2
    
    ;tenemos que verificar si la suma ax=num1
    cmp ax, num1
    jz esPerfecto
    jne noPerfecto
    
    esPerfecto:
        lea dx, perfecto
        mov ah, 9
        int 21h
        jmp fin
    
    noPerfecto:
        lea dx, noEsPerfecto
        mov ah, 9
        int 21h
        jmp fin
     
     fin: 
          
ends

end start ; set entry point and stop the assembler.
