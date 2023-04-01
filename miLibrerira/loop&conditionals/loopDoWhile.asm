; Do-While Loop

doWhile:
    ; código que se ejecuta antes de la condición
    ; ...

    ; verificar si se cumple la condición de salida
    cmp ax, 10
    jge finDoWhile

    ; código que se ejecuta dentro del bucle
    ; ...

    ; volver al inicio del bucle
    jmp doWhile

    finDoWhile:
        ; código que se ejecuta después del bucle
        ; ...
