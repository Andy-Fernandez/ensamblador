;6. Realizar un direccionamiento inmediato en cx mostrar el valor por pantalla y además
;mostrar el numero invertido

;Caso de entrada
;CX = 123
;Caso de salida
;Numero: 123
;Invertido: 321

; imprimir la cadena "Numero: "
lea dx, mensaje1  ; cargar la cadena "Numero: " en dx
mov ah, 9        ; establecer la función 9 de la interrupción 21h para imprimir una cadena
int 21h          ; llamar a la interrupción 21h para imprimir la cadena

mov cx, 123
mov variable1, cx
mov ax, cx     ; copiar el valor de cx en ax
mov bx, 10     ; establecer bx en 10 para realizar la división
mov cx, 0      ; establecer cx en 0 para contar el número de dígitos
digito:
    xor dx, dx        ; establecer dx en 0 para realizar la división
    div bx            ; dividir ax entre bx
    push dx           ; almacenar el residuo en la pila
    inc cx            ; aumentar el contador de dígitos
    test ax, ax       ; comprobar si ax es cero
    jnz digito        ; si no es cero, repetir para el siguiente dígito

imprimir:
    pop dx            ; extraer el dígito de la pila
    add dl, '0'       ; sumar el código ASCII de '0' al dígito para convertirlo en caracteres
    mov ah, 2         ; establecer la función 2 de la interrupción 21h para imprimir un carácter
    int 21h           ; llamar a la interrupción 21h para imprimir el dígito actual
    loop imprimir     ; repetir hasta que se hayan impreso todos los dígitos

; salt de linea
mov ah, 2        ; establecer la función 2 de la interrupción 21h para imprimir un carácter
mov dl, 0Dh      ; cargar el carácter de retorno de carro en dl
int 21h          ; llamar a la interrupción 21h para imprimir el retorno de carro
mov dl, 0Ah      ; cargar el carácter de salto de línea en dl
int 21h          ; llamar a la interrupción 21h para imprimir el salto de línea


; imprimir la cadena "Invertido: "
lea dx, mensaje2  ; cargar la cadena "Invertido: " en dx
mov ah, 9         ; establecer la función 9 de la interrupción 21h para imprimir una cadena
int 21h           ; llamar a la interrupción 21h para imprimir la cadena

mov ax, variable1     ; copiar el valor de cx en ax
mov bx, 10            ; establecer bx en 10 para realizar la división
mov cx, 0             ; establecer cx en 0 para contar el número de dígitos
invertir:
    xor dx, dx        ; establecer dx en 0 para realizar la división
    div bx            ; dividir ax entre bx
    push ax
    push bx
    push dx
    
    ; imrpirmir:
    add dl, '0'       ; sumar el código ASCII de '0' al dígito para convertirlo en caracteres
    mov ah, 2         ; establecer la función 2 de la interrupción 21h para imprimir un carácter
    int 21h           ; llamar a la interrupción 21h para imprimir el dígito actual
    
    pop dx
    pop bx
    pop ax

    test ax, ax       ; comprobar si ax es cero
    jnz invertir        ; si no es cero, repetir para el siguiente dígito


salir:
    ; aquí puedes colocar cualquier código adicional que necesites antes de terminar el programa
    ret              ; retornar desde la función

mensaje1 db "Numero: $"    ; cadena a imprimir antes del número decimal
mensaje2 db "Invertido: $" ; cadena a imprimir antes del número invertido
variable1 dw 0
