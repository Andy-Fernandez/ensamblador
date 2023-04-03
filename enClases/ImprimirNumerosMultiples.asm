; Procedimientos
; Plantilla de archivo ejecutable de varios segmentos.

; Segmento de datos donde se almacenan las variables y constantes
data segment
    ; Agrega tus datos aquí!
    numero db "nro: $" ; Cadena que se imprimirá antes del número
    enter db 10,13,"$" ; Caracteres de nueva línea (10) y retorno de carro (13) para formatear la salida
ends

; Segmento de pila para almacenar datos temporales y direcciones de retorno
stack segment
    dw   128  dup(0) ; Pila de 128 palabras (256 bytes) inicializadas a cero
ends

; Segmento de código donde se almacena el código del programa
code segment
start: ; Punto de entrada del programa
; Establecer registros de segmento:
    mov ax, data ; Cargar la dirección base del segmento de datos en ax
    mov ds, ax   ; Establecer el registro de segmento de datos (ds) igual a ax
    mov es, ax   ; Establecer el registro de segmento extra (es) igual a ax

    ; Agrega tu código aquí
    ; Se muestran 3 números diferentes en pantalla, utilizando el procedimiento "imprime"
    mov ax,123
    call imprime
    
    mov ax,2345
    call imprime
    
    mov ax,6544
    call imprime
    
    ; Salir del programa y volver al sistema operativo
    mov ax, 4c00h ; Cargar el valor 4c00h en el registro ax
    int 21h ; Realizar la interrupción 21h, que finaliza el programa
    
    ; Procedimiento "imprime" para mostrar números en pantalla
    imprime: ; Etiqueta del procedimiento
      mov bx,ax ; Guardar el valor de ax en bx
      lea dx,numero ; Cargar la dirección de la cadena "numero" en dx
      mov ah,9 ; Establecer el valor 9 en ah para la función de interrupción de imprimir cadena
      int 21h ; Realizar la interrupción 21h, que imprime la cadena en pantalla
      mov ax,bx ; Restaurar el valor original de ax

      ; Convertir el número en ax a caracteres ASCII y almacenarlos en la pila
      mov cx,0 ; Inicializar el contador cx a 0
      ciclo: ; Etiqueta del ciclo de conversión
        mov bx,10 ; Establecer el divisor (10) en bx
        mov dx,0 ; Limpiar el registro dx antes de dividir

        div bx ; Dividir ax por bx, resultado en ax, residuo en dx
        push dx ; Empujar el residuo a la pila
        inc cx ; Incrementar el contador cx
        cmp ax,0 ; Comparar el valor de ax con 0
        jz mostrar ; Si ax es 0, saltar a la etiqueta "mostrar"
        jmp ciclo ; Repetir el ciclo de conversión

      ; Mostrar los caracteres almacenados en la pila
      mostrar: ; Etiqueta para mostrar caracteres
        pop dx ; Sacar el valor almacenado en la pila a dx
        add dl, 48 ; Agregar 48 al registro dl para convertir el valor numérico en su representación ASCII
        mov ah, 2  ; Establecer el valor 2 en ah para la función de interrupción de imprimir un carácter
        int 21h    ; Realizar la interrupción 21h, que imprime el carácter en pantalla
        loop mostrar ; Repetir el proceso de mostrar caracteres hasta que cx sea 0

      ; Imprimir caracteres de nueva línea y retorno de carro
      lea dx, enter ; Cargar la dirección de la cadena "enter" en dx
      mov ah, 9     ; Establecer el valor 9 en ah para la función de interrupción de imprimir cadena
      int 21h       ; Realizar la interrupción 21h, que imprime la cadena en pantalla
      ret           ; Retornar al punto de llamada del procedimiento "imprime"
ends

end start ; Establecer el punto de entrada y detener el ensamblador.
