; Repeat-Until Loop

repeatUntil:
    ; código que se ejecuta dentro del bucle
    ; ...

    ; verificar si se cumple la condición de salida
    ; si no se cumple, volver al inicio del bucle
    cmp ax, 10
    jne repeatUntil

    ; código que se ejecuta después del bucle
    ; ...
