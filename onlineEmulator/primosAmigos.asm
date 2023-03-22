amigos: DB "SON PRIMOS AMIGOS" ; store string
noamigos: DB "NO SON PRIMOS AMIGOS" ; store string
start: 
mov bx, 6 ; variable a
mov cx, 5; variable b
;mov cx, 24 ; variable i
;cmp bx, dx
;jnz ciclo ; a es mayor que b
;jc ciclo ; b es mayor que a 
;jz ciclo ; son iguales

while:
    mov ax, 0
    cmp cx, ax
    jz final

proceso: 
    ;mov dx, bx ; variable t
    push cx; guardamos el valor de b en la pila
    
    mov ax, bx ; dividimos 
    div cx
    
    mov cx, dx ; asignamos el resto a b osea cx
    
    pop bx ; asignamos valor a 'a', bx
    
    mov ax, 0
    cmp cx, ax
    jz final
    jc proceso
    jnz proceso

final:
    mov ax, 1
    cmp ax, bx
    jz amig

amig:
    MOV AH, 0x13            ; move BIOS interrupt number in AH
    MOV CX, 17              ; move length of string in cx
    MOV BX, 0               ; mov 0 to bx, so we can move it to es
    MOV ES, BX              ; move segment start of string to es, 0
    MOV BP, OFFSET amigos    ; move start offset of string in bp
    MOV DL, 0               ; start writing from col 0
    int 0x10 
    ;int 21h

noamig:
    MOV AH, 0x13            ; move BIOS interrupt number in AH
    MOV CX, 20              ; move length of string in cx
    MOV BX, 0               ; mov 0 to bx, so we can move it to es
    MOV ES, BX              ; move segment start of string to es, 0
    MOV BP, OFFSET noamigos    ; move start offset of string in bp
    MOV DL, 0               ; start writing from col 0
    int 0x10 
    ;int 21h