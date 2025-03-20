%macro IO 4
mov rax, %1
mov rdi, %2
mov rsi, %3
mov rdx, %4
syscall 
%endmacro

section .data
m1 db "Enter the string:",
I1 equ $ - m1

m2 db "Length is:"
I2 equ $ - m2
m3 db "Entered string is:"
I3 equ $ - m3
m4 db 10, "String length is:"
I4 equ $ - m4
m5 db "",10
I5 equ $ - m5

section .bss
input resb 50
iLen equ $ - input
count resb 1
_output resb 20

section .text
global _start

_start:
IO 1, 1, m1, I1

call takeInput

IO 1, 1, m3, I3
IO 1, 1, input, iLen

IO 1, 1, m4, I4
dec byte[count]
movzx rax, byte [count]
call hex_to_dec
IO 1, 1, _output, 16
IO 1, 1, m5, I5
call exit
ret
takeInput:
IO 0, 0, input, iLen
mov [count], rax
ret
hex_to_dec:
mov rsi, _output+15
mov rcx,2
letter2:
xor rdx,rdx
mov rbx,10
div rbx
cmp dl, 09h
jbe add30

add30:
add dl,30h
mov [rsi],dl
dec rsi
dec rcx
jnz letter2
ret

exit:
mov rax,60



