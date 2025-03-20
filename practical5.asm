section .data

nline db 10,10
nline_len equ $-nline

arr32 dd -11111111H,-22222222H,33333333H,-44444444H,55555555H
n equ 5

pmsg db 10,10,'the no of positive elements in 32 bit array: '
pmsg_len equ $-pmsg

nmsg db 10,10,'the no of negative elements in 32 bit array: '
nmsg_len equ $-nmsg

section .bss

p_count resb 1
n_count resb 1
char_count resb 1

%macro print 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 80h
%endmacro

%macro exit 0
mov eax,1
mov ebx,0
int 80h
%endmacro

section .text
global _start
_start:

mov esi,arr32
mov edi,n

mov ebx,0;
mov ecx,0;

next_num:
mov eax,[esi]
RCL eax,1
jc negative

positive:
inc ebx
jmp next

negative:
inc ecx

next:
add esi,4
dec edi
jnz next_num

mov[p_count],ebx
mov[n_count],ecx

print pmsg,pmsg_len
mov eax,[p_count]
call disp

print nmsg,nmsg_len
mov eax,[n_count]
call disp

print nline,nline_len
exit

disp:
mov edi,char_count
mov ecx,1

add al,30h
mov [edi],al

print char_count,1
ret
