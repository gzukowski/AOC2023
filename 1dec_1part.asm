.686
.model flat
extern __write : proc
extern __read : proc
extern _getchar : proc
extern _ExitProcess@4 : proc

public _main

.data
number db 80 dup (0)
read db 80 dup (0)
ten dd 10
input db 'input.txt'


.code

_string_compare proc
push ebp
mov ebp, esp
push esi
push edi

;;todo




pop edi
pop esi
pop ebp
ret
_string_compare endp

_read_to_eax proc
push ebp
push esi
push ebx
push edx
push edi




mov eax, 0
mov esi, 0
mov ebx, 0

mov bl, number[esi]
sub bl, 30H
add eax, ebx
mul ten


convert_loop:
	mov ebx, 0
	mov bl, number[esi]

	cmp bl, 10
	jz convert_end

	inc esi
	jmp convert_loop


	

convert_end:

mov bl, number[esi-1]
sub bl, 30H
add eax, ebx


pop edi
pop edx
pop ebx
pop esi
pop ebp
ret
_read_to_eax endp

_read_line proc
push ebp
push esi
push ebx
push edi
push edx

mov esi, 0 ; source index
mov edi, 0 ; destination index
mov edx, 0


get_number:
	mov dl, read[esi]

	cmp dl, 10
	jz end_get_number


	cmp dl, 39H
	ja increment

	mov  byte ptr number[edi], dl
	inc edi

increment:
	inc esi
	jmp get_number

end_get_number:
	mov  byte ptr number[edi], 10


pop edx
pop edi
pop ebx
pop esi
pop ebp
ret
_read_line endp


_main proc


mov ebx, 0


mov esi, 0
reading_loop:
	call _getchar

	cmp eax, '+'
	je reading_end

	cmp eax, 10
	jne read_input


	mov read[esi], al
	mov esi, 0


	call _read_line
	call _read_to_eax

	add ebx, eax

	jmp reading_loop



read_input:
mov read[esi], al
inc esi
jmp reading_loop

	
reading_end:
mov read[esi], 10
mov esi, 0

call _read_line
call _read_to_eax

add ebx, eax

push 0
CALL _ExitProcess@4
_main endp
end
