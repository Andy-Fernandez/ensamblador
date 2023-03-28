; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    welcom db "Bienbenido al sistema!$"
    
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    ; Carga la direccion del segmento de datos en el registro AX
    mov ax, data

    ; Inicializa el registro DS con la direccion del segmento de datos en el registro AX
    ; DS significa "Data Segment" (Segmento de Datos)
    mov ds, ax     

    ; Inicializa el registro ES con la direccion del segmento de datos en el registro AX
    ; ES significa "Extra Segment" (Segmento Extra)
    mov es, ax     

    ; add your code here
            
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    lea dx, welcom
    mov ah, 9
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
