; Switch-Case

switchCase:
    ; evaluar la variable
    cmp ax, 1
    je caso1

    cmp ax, 2
    je caso2

    cmp ax, 3
    je caso3

    ; código que se ejecuta si no se cumple ningún caso
    ; ...

    ; saltar al final del switch
    jmp finSwitch

    caso1:
        ; código que se ejecuta si la variable es igual a 1
        ; ...
        jmp finSwitch

    caso2:
        ; código que se ejecuta si la variable es igual a 2
        ; ...
        jmp finSwitch

    caso3:
        ; código que se ejecuta si la variable es igual a 3
        ; ...
        jmp finSwitch

    finSwitch:
        ; código que se ejecuta después del switch
        ; ...
