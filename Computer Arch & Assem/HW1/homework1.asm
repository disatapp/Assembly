TITLE Program Template     (template.asm)

; Author:
; Course / Project ID                 Date:
; Description:

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

; (insert variable definitions here)
username BYTE "Elementery Arithmetic By: Pavin Disatapundhu", 0
prompt_1	BYTE	"Enter the first number: ", 0
prompt_2	BYTE	"Enter the second number: ", 0
prompt_3 BYTE "Enter the last number: " , 0
bye BYTE "Gooood Bye!",0

input_1 DWORD ?
input_2 DWORD ?
input_3 DWORD ?
sum DWORD ?
diff DWORD ?
prod DWORD ?
quot DWORD ?
qleft DWORD ?

sumsybm BYTE " + ",0
diffsybm BYTE " - ",0
prodsybm BYTE " x ",0
quotsybm BYTE " ÷ ",0
equal BYTE " = ",0
dot BYTE ".",0

.code
main PROC

; (insert executable instructions here)
;Introduce programmer
	mov		edx, OFFSET username
	call WriteString
	call	CrLf

;Introduce ask for input 1
	mov		edx, OFFSET prompt_1
	call	WriteString
	call	ReadInt
	mov	input_1, eax

;Introduce ask for input 2
	mov		edx, OFFSET prompt_2
	call	WriteString
	call	ReadInt
	mov	input_2, eax

;Introduce ask for input 3
	mov		edx, OFFSET prompt_3
	call	WriteString
	call	ReadInt
	mov	input_3, eax

; Where the magic happends

;add 1&2
	mov eax, input_1
	mov ebx, input_2
	add eax, ebx
	mov sum, eax ;Calc add

;display sum
	mov eax, input_1 
	call WriteDec
	mov edx, OFFSET sumsybm ;display " + "
	call WriteString
	mov eax, input_2				
	call WriteDec
	mov edx, OFFSET equal ;display " = "			
	call WriteString
	mov eax, sum ;display the sum					
	call WriteDec
	call Crlf

;sub 2&3
	mov eax, input_2
	mov ebx, input_3
	sub eax, ebx
	mov diff, eax ;Calc diff

;display diff
	mov eax, input_2 
	call WriteDec
	mov edx, OFFSET diffsybm ;display " - "
	call WriteString
	mov eax, input_3				
	call WriteDec
	mov edx, OFFSET equal ;display " = "			
	call WriteString
	mov eax, diff ;display the diff					
	call WriteDec
	call Crlf

;mulit 1&2&3
	mov eax, input_1
	mov ebx, input_2
	mul ebx
	mov ebx, input_3
	mul ebx
	mov prod, eax ;Calc mult

;display multiply
	mov eax, input_1 
	call WriteDec
	mov edx, OFFSET prodsybm ;display " x "
	call WriteString
	mov eax, input_2 
	call WriteDec
	mov edx, OFFSET prodsybm ;display " x "
	call WriteString
	mov eax, input_3				
	call WriteDec
	mov edx, OFFSET equal ;display " = "			
	call WriteString
	mov eax, prod ;display the prod				
	call WriteDec
	call Crlf

;div 1&3
	mov eax, input_1
	cdq
	mov ebx, input_3
	div ebx
	mov quot, eax
	mov qleft, edx ;Calc div

;display div
	mov eax, input_1 
	call WriteDec
	mov edx, OFFSET quotsybm ;display " ÷ "
	call WriteString
	mov eax, input_3				
	call WriteDec
	mov edx, OFFSET equal ;display " = "			
	call WriteString
	mov eax, qout ;display the qout					
	call WriteDec
	mov edx, OFFSET dot ;display " . "			
	call WriteString
	mov eax, qleft ;display the qleft				
	call WriteDec
	call Crlf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
