
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
s dw 2 dup (?)
base1 dw ?
divv1 db 'the quotion :', 13 , 10 , '$' 
divv2 db 'the reminder :', 13 , 10 , '$'
divby0 db 'dividing by 0, enter agin:', 13 , 10 , '$'

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
je enterba
cmp al, 'd'
je enterba
cmp al, 'h'
jne base

enterba:
mov [ba], al



enter:


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
cmp [ba], 'd'
jne comp2
call EstDecimal
jmp cmpf

comp2:
cmp [ba],'b'
jne comp16
call EstBinaire
jmp cmpf 

comp16:
call EstHexa

cmpf:
cmp bx, 0
je enter 

mov dx, offset as
call stringtonumber

cmp [op], '/'
jne moving
cmp ax, 0
jne moving

mov dx, offset nl
mov ah, 09h
int 21h

push offset divby0
call print
jmp enter

moving: 
mov [a], ax
 



enter2:

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

cmp [ba], 'd'
jne comp22
call EstDecimal
jmp cmpf2

comp22:
cmp [ba],'b'
jne comp216
call EstBinaire
jmp cmpf2 

comp216:
call EstHexa

cmpf2:
cmp bx, 0
je 2enter 

mov dx, offset bs
call stringtonumber 
mov [b], bx




 

cmp [op], '+'
je add10
cmp [op], '*'
je mul10
jmp divv10


add10:
add ax, a
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


mul10:

mov dx, 0
mul [a]
jo ovf
mov [s], ax
mov [s+2], dx



mov dx, offset nl
mov ah, 09h
int 21h

mov dx, offset rslt
int 21h

mov ax, [s]
call disp

mov ax, [s+2]
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

mov dx, offset nl
mov ah, 09h
int 21h

mov dx, offset ov
mov ah, 09H
int 21h
jmp endd 


 
 
 












endd:
  
mov ah,4Ch
int 21h  










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
jmp nextdiv2

mv2:
cmp [ba], 'b'
jne mv16
mov bx, 2
jmp nextdiv2

mv16:
mov bx, 16


nextdiv2:
xor dx, dx   
div bx
cmp dx, 9
jg add16
 
1add10:   
add dx, '0'
push dx
inc cx
cmp ax, 0
jnz nextdiv2
jmp print2

add16:
add dx, 55
push dx
inc cx
cmp ax, 0
jnz nextdiv2
print2:   

pop dx
mov ah, 02h
int 21h
dec cx
cmp cx, 0   
jnz print2
    
ret        
        
disp endp






EstHexa PROC
MOV BL, 1 
MOV SI, 1
MOV CX, 0
MOV CL, DS:[bp+1] 
ADD CX, 1 
RebouclerHex:
INC SI 
CMP SI, CX
JG FinHex 
CMP DS:[bp+SI], '0' 
JL SortirHex 

CMP DS:[bp+SI], '9'  
JLE RebouclerHex 


CMP DS:[bp+SI], 'A'  
JL SortirHex 

CMP DS:[bp+SI], 'F' 
JG SortirHex 
JMP RebouclerHex 
SortirHex:
MOV BL, 0 
FinHex:
RET 
EstHexa ENDP 












EstDecimal PROC    
 
MOV BL, 1
MOV SI, 1
MOV CX, 0
MOV CL, DS:[bp+1]
ADD CX, 1 
Reboucler1:
INC SI 
CMP SI, CX
JG Fin1 
CMP DS:[bp+SI], '0' 
JL Sortir
CMP DS:[bp+SI], '9'
JG Sortir
JMP Reboucler1
Sortir:
MOV BL, 0 
Fin1:

RET 
EstDecimal ENDP






stringtonumber PROC
    
     
      
      
        mov bx, dx
        mov ax, 0          
        mov cl, [bx+1]
        MOV ch,0   
        mov si, 2
        
cmp [ba],'d'
jne etic1
mov base1, 10
jmp boucle2

etic1:
cmp [ba],'b'
jne etic2
mov base1, 2
jmp boucle2

etic2:
mov base1, 16
         
        
        boucle2:
            mul base1
            jo ovf   
            mov dl, [bx+si] 
            add ax, dx
           
            cmp dx, '9'
            jg sub16
            sub ax, 30h  
            inc si
            jmp loopp
            
            sub16:
            sub ax, 55
            
            inc si
          
            
            
            
         loopp:   
        loop boucle2
        Fin4:
        ret
    stringtonumber ENDP 





EstBinaire PROC
 
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

RET 
EstBinaire ENDP



end start
