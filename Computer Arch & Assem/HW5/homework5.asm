TITLE Program Template     (homework6.asm)

; Author: Pavin Disatapundhu
; Course CS271 / Project ID: Homework 6                 Date:5/31/14
; Description: :

INCLUDE Irvine32.inc

MAXSIZE = 15
VALIDINT = 15
MAXINT EQU <"429496729">


;------------------------------------------------------------------------------
quickPush macro
;------------------------------------------------------------------------------
	push	ebp
	mov	ebp, esp
ENDM

;------------------------------------------------------------------------------
getString macro userstring, length	
;------------------------------------------------------------------------------
	LOCAL promptstring
		.data
		promptstring BYTE " Integer: ",0
		.code
		mov edx OFFSET promptstring
		call WriteString
		mov edx, userstring
		mov ecx, length
		call ReadString
ENDM

;------------------------------------------------------------------------------
displayString macro inputstring
;------------------------------------------------------------------------------
	mov	edx, inputstring
	call	WriteString
ENDM

;------------------------------------------------------------------------------

.data
intro1	BYTE "Welcome to the string to numeric from converter.",0
		"This program will read a number that you input as a string and convert it int numeric form.",0
		"Enter an integer within the range of [0-",MAXINT,"],0
task		BTYE "Enter a string "
error1	BYTE "Invalid input. Please enter a new value.",0
display1	BYTE "The input string is: ", 0
displayAvg	BYTE "Average: ", 0
displaySum	BYTE "Sum: ", 0
credit BYTE "Results certified by Pavin Disatapundhu", 0
bye BYTE "Gooood Bye,",0


inString	BYTE		MAXSIZE DUP(0)		; User's string
outString	BYTE		MAXSIZE DUP(?)		; User's string capitalized
inputPass1 BYTE	0
avg	DWORD	?
sum	DWORD	?
number	DWORD	?
flag	DWORD	1

.code
main PROC
intro:
	mov edx, OFFSET  intro
	call writeString

	mov	esi, OFFSET inString
	mov	ecx, LENGTHOF inString

mainloop:
	push OFFSET error1
	call	readVal
	pop  [esi]
	add  esi, 4
	loop mainloop

	;calculate avg, sum
	push OFFSET inString
	push LENGTHOF inString
	call calcString
	pop sum
	pop avg

	;display the string in int
	mov edx, OFFSET display1
	call writeString

	;display the string
	push	OFFSET instring
	push	LENGTHOF instring
	push	OFFSET 
	call printString
	call crlf

	;display sum that was calcuated
	mov edx, OFFSET displaySum
	call writeString
	push sum
	call writeVal
	call crlf

	;display avg that has been calcuated 
	mov  edx, OFFSET displayAvg
	call WriteString
	push avg
	call WriteVal
	call Crlf

	;display bye-bye
	call fearwell

	exit

main ENDP

;------------------------------------------------------------------------------
readVal PROC
;------------------------------------------------------------------------------
LOCAL 			input1[MAXINT]:BYTE, 
readLoop:
	lea  eax, user_in
	getString eax, LENGTHOF input1
	mov  ebx, [ebp+8]
	lea  eax, input1
	push eax
	push LENGTHOF input1
	push ebx
	lea  eax, flag
	push eax
	call validateInput

	mov  eax, flag
	cmp  eax, 1 ;comapre with true
	jne  readLoop
	lea  eax, input1
	push eax
	push LENGTHOF input1
	call convertInt

	pop eax
	mov [ebp+8], eax
	ret 	
readVal ENDP


;------------------------------------------------------------------------------
validateInput PROC
;------------------------------------------------------------------------------
;validate users input
	mov  esi, [ebp+20]
	mov  ecx, [ebp+16]
	cld

valStart:
	lodsb
	cmp  al, 0 
	je   passVal
	cmp  al, "0" 
	jb   skip1
	cmp  al, "9"
	ja   skip1	
	loop valStart

passVal:
	push [ebp+20]
	push [ebp+16]
	call calcString
	pop  eax
	cmp  eax, 429496729
	jg   skip1
	mov  eax, [ebp+8]
	mov  ebx, 1
	mov  [eax],ebx
	jmp  valEnd
skip1:
	mov	edx, [ebp+12]
	call	WriteString
valEnd:
	ret	16
validateInput ENDP

;------------------------------------------------------------------------------
calcString PROC
;------------------------------------------------------------------------------
	quickPush
	mov 	esi, [ebp+28]
	mov 	ecx, [ebp+24]
	xor 	edx, edx
	xor 	eax, eax
	cld
convLoop:
	lodsb
	cmp	eax, 0
	je 	convEnd
	imul	edx, edx, 10
	sub	eax, "0"
	add	edx, eax
	loop	convLoop
convEnd:
	mov  	[ebp+28], edx
	pop  	ebp
	ret  	4
calcString	ENDP

;------------------------------------------------------------------------------
printString PROC
;------------------------------------------------------------------------------
	quickPush
	mov  	esi, [ebp+32]
	mov  	ecx, [ebp+28]
	mov  	ebx, 0
printLoop:
	push 	[esi]
	call 	writeVal
	mov  	edx, [ebp+24]
	call 	WriteString
	add 	esi, 4
	loop 	printLoop	
	pop  	ebp
	ret  	12
printString ENDP

;------------------------------------------------------------------------------
writeVal PROC
;------------------------------------------------------------------------------
	lea  	eax, str_out
	push 	eax
	push  	[ebp+8]
	call 	convertChar
	lea  	eax, str_out
	displayString eax
	ret 	4
wrtieVal ENDP

;------------------------------------------------------------------------------
convertChar PROC
;------------------------------------------------------------------------------
	mov  	eax, [ebp+8]
	mov  	ebx, base
	xor  	ecx, ecx
charLoop1:
	xor  	edx, edx
	div  	ebx
	push  	edx
	inc  	ecx
	test 	eax, eax
	jnz  	charLoop1

	mov  	edi, [ebp+12]
charLoop2:
	pop  	temp
	mov  	al, BYTE PTR temp
	add  	al, "0"
	stosb
	loop 	charLoop2
	mov  	al, 0
	stosb
	ret  	8
convertChar  	ENDP

;------------------------------------------------------------------------------
farewell PROC ;DONE
;------------------------------------------------------------------------------
	;farewell
	call CrLf
	mov edx, OFFSET credit ; credit
	call writeString 
	call Crlf	
	mov edx, OFFSET bye ; good-bye messege
	call writeString
	call CrLf
	ret
farewell ENDP

END main