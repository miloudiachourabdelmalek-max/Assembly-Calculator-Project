data segment  
;declaration de donnees 


m1 db 'enter the base :',13,10 , '$'
m2 db 'enter the first number :', 13,10 , '$' 
m3 db 'enter the second number :', 13 ,10 ,'$'
m4 db 'enter the operation: "+" for addition, "*" for multiplication, "/" for division (the 1nd number is the divisor).', 13, 10, '$'
m5 db 'enter your base : "b" for binary , "d" for decimal , "h" for hexadecimal', 13 , 10 ,'$'
nl db 13, 10, '$'
ov db 'there is an overflow', 13 , 10 ,'$'
rslt db 'your reslut is : ' , 13 , 10 , '$'
as db 18 dup(?) 
bs db 18 dup(?) 
a dw ?
b dw ?
op db ?
ba db ? 
s dw ?
dis dw 10
divv1 db 'the quotion :', 13 , 10 , '$' 
divv2 db 'the reminder :', 13 , 10 , '$'


ends 

stack segment
   
    dw 128 dup(?)  
ends 

 
 
code segment

assume cs:code, ds: data, ss: stack

start:

mov ax,data
mov ds,ax
 
mov ax, stack
mov ss,ax

        
;instructions de programme


operation:
push offset m4
call print


mov ah, 01h     
int 21h


push ax
mov dx, offset nl
mov ah, 09h
int 21h
 
pop ax 
cmp al, '+'
je next
cmp al, '*'
je next
cmp al, '/'
jne operation
 
next:

mov [op], al

base:

mov dx, offset nl
mov ah, 09h
int 21h


mov dx, offset m5
mov ah, 09h
int 21h


mov ah, 01h     
int 21h


cmp al, 'b'
je cmp2
cmp al, 'd'
je cmp2
cmp al, 'h'
jne base

 
cmp2:
  
mov [ba], al
cmp [ba], 'd'
je enter10
cmp [ba], 'b'
je enter2




enter10:


mov dx, offset nl
mov ah, 09h
int 21h

push offset m2
call print
 
mov as[0], 5 
mov dx, offset as
mov ah, 0Ah
int 21h

mov bp, dx

call EstDecimal

cmp bx, 0
je enter10 

push offset as
call StringToDecimal 
mov [a], ax
 



2enter10:

mov dx, offset nl
mov ah, 09h
int 21h

push offset m3
call print

  

mov bs[0], 5 
mov dx, offset bs
mov ah, 0Ah
int 21h

mov bp, dx
call EstDecimal      
      
cmp bx, 0
je 2enter10      

push offset bs
call StringToDecimal
mov [b], ax 

cmp [op], '+'
je add10
cmp [op], '*'
je mul10
jmp divv10


add10:
add ax, a
mov [s], ax
jo ovf


mov dx, offset nl
mov ah, 09h
int 21h

mov dx, offset rslt
int 21h

mov ax, [s]
call disp
jmp endd


mul10:

mul [a]
jo ovf
mov [s], ax
jo ovf


mov dx, offset nl
mov ah, 09h
int 21h

mov dx, offset rslt
int 21h

mov ax, [s]
call disp
jmp endd

divv10:

mov dx,0

div [a] 
mov [s], ax
mov di, dx

mov dx, offset nl
mov ah, 09h
int 21h

mov dx, offset divv1
int 21h

mov ax, [s]
call disp


mov dx, offset nl
mov ah, 09h
int 21h

mov dx, offset divv2
int 21h

mov ax, di
call disp
jmp endd





ovf:
mov dx, offset ov
mov ah, 09H
int 21h
jmp endd 


 
 
 
enter2: 
 




mov dx, offset nl
mov ah, 09h
int 21h

push offset m2
call print

  

mov as[0], 16 
mov dx, offset as
mov ah, 0Ah
int 21h

mov bp, dx
call EstBinaire      
      
cmp bx, 0
je enter2      


mov bx, offset as
call StringToBinary
mov [a], ax 
 
 
 
 
2enter2:



mov dx, offset nl
mov ah, 09h
int 21h

push offset m3
call print

  

mov bs[0], 16 
mov dx, offset bs
mov ah, 0Ah
int 21h

mov bp, dx
call EstBinaire      
      
cmp bx, 0
je 2enter2      


mov bx, offset bs
call StringToBinary
mov [b], ax


cmp [op], '+'
je add2
cmp [op], '*'
je mul2
jmp div2



add2:
add ax,[a]
jo ovf
mov [s], ax 

 
mov dx, offset nl
mov ah, 09h
int 21h

mov dx, offset rslt
int 21h

mov ax, [s]
call disp
jmp endd



mul2:

mul [a]
jo ovf

mov [s], ax 

 
mov dx, offset nl
mov ah, 09h
int 21h

mov dx, offset rslt
int 21h

mov ax, [s]
call disp
jmp endd



div2:




mov dx,0

div [a] 
mov [s], ax
mov di, dx

mov dx, offset nl
mov ah, 09h
int 21h

mov dx, offset divv1
int 21h

mov ax, [s]
call disp


mov dx, offset nl
mov ah, 09h
int 21h

mov dx, offset divv2
int 21h

mov ax, di
call disp
jmp endd












endd:
  
mov ah,4Ch
int 21h  


;procedures



print proc 
       
push bp
mov bp, sp
push dx

mov dx,[bp+4]
mov ah,09
int 21h 
pop dx
pop bp
ret
print endp



    
    
disp proc 
    
xor cx, cx

cmp [ba], 'd'
jne mv2

mov bx, 10
jmp nextdiv

mv2:
mov bx, 2


nextdiv:
xor dx, dx   
div bx
   
add dx, '0'
push dx
inc cx
cmp ax, 0
jnz nextdiv



print2:

pop dx
mov ah, 02h
int 21h
dec cx
cmp cx, 0   
jnz print2
    
ret        
        
disp endp



















EstDecimal PROC    
PUSH AX
push CX
push SI ; Sauvegarde du contexte
MOV BL, 1
MOV SI, 1; // ET c’est INC SI qui va le mettre à 2
MOV CX, 0
MOV CL, DS:[bp+1]
ADD CX, 1 ;
Reboucler1:
INC SI 
CMP SI, CX; ////CMP SI, DString[1]+1 =fin
JG Fin1 
CMP DS:[bp+SI], '0' ; // On peut aussi le faire avec CMP DString[SI], 30H ;
JL Sortir
CMP DS:[bp+SI], '9'
JG Sortir
JMP Reboucler1
Sortir:
MOV BL, 0 
Fin1:
POP SI
pop CX
pop AX
RET 
EstDecimal ENDP







StringToDecimal PROC
        mov bx, dx
        mov ax, 0          
        mov cl, [bx+1]
        MOV ch,0    ;cx=la taille reel
        mov si, 2
        boucle2:
            mul dis   ;ax=ax*10
            mov dl, [bx+si] ;lecture des carac
            add ax, dx
            sub ax, 30h  ;convertir en nombre
            inc si
        loop boucle2
        Fin4:
        ret
    StringToDecimal ENDP 







StringToBinary PROC    


MOV AX, 0
MOV BX, DX
MOV CX, 0 
MOV CL, [BX+1]
inc cx  
MOV SI, 1


Reboucler2:
INC SI 
CMP SI, CX
JG Fin3
SHL AX, 1 
CMP [BX+SI], '1'

JNE Reboucler2 
ADD AX, 1
JMP Reboucler2
Fin3:
RET 
StringToBinary ENDP 



EstBinaire PROC
PUSH AX 
push CX
push SI 
MOV BL, 1
MOV SI, 1
MOV CX, 0
MOV CL, ds:[bp+1]
inc cx 
Reboucler:
INC SI 
CMP SI, CX
JG Fin 
CMP ds:[bp+SI], '0' 
JE Reboucler 
CMP ds:[bp+SI], '1' 
JE Reboucler
MOV BL, 0
Fin:
POP SI
pop CX
pop AX
RET 
EstBinaire ENDP



end start