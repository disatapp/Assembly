TITLE Program Template     (homework2.asm)

; Author: Pavin Disatapundhu
; Course CS271 / Project ID: Homework 2                 Date:4/20/14
; Description: lucas number:
;			ask for the greet user, ask for username
;			ask for the input number between 1-46 to compute n # of lucas numbers
;			calculate the lucas number of the input value
;			Say goodbye to the user

INCLUDE Irvine32.inc

UPPER = 46 ;upper value constant
.data

; (insert variable definitions here)
projectname BYTE "The Lucas Number",0
username BYTE "By: Pavin Disatapundhu", 0
greet BYTE "What's your name? ",0
good BYTE "Good day,",0
askint BYTE "Enter the number of Lucas terms to be displayed",0
askint2 BYTE "Give the number as an integer in the range [1..46]",0
lucas BYTE "How many Lucas terms do you want? ",0
error BYTE "Out of range. Enter a number in [1-46]",0
credit BYTE "Results certified by Pavin Disatapundhu", 0
bye BYTE "Gooood Bye,",0

yourName BYTE 30 DUP(0) ;for username
count DWORD ?
temp DWORD ?
loopcount DWORD ?


.code
main PROC

;intro/ask for name
	mov edx, OFFSET projectname ;meet and greet
	call writeString
	call Crlf
	mov edx, OFFSET username ;the man who made it possible
	call writeString
	call Crlf
	mov edx, OFFSET greet
	call writeString
	mov edx, OFFSET yourName ;ask user for name
	mov ecx, SIZEOF yourName
	call ReadString
	call crlf
	
;userInstructions
	mov edx, OFFSET good ;hello
	call writestring
	mov edx, OFFSET yourName ;display user's name
	call WriteString
	call crLf
	mov edx, OFFSET askint ;instructions
	call writeString
	call CrLf
	mov edx, OFFSET askint2
	call writeString
	call Crlf
	call CrLf

;getUserData
	loop1:
		mov edx, OFFSET lucas  ;ask user to input value
		call writeString
		call ReadInt
		cmp eax, 1
		jl error1
		cmp eax, UPPER
		jg error1
		jmp pass1
	error1:
		mov edx, OFFSET error ;wrong range
		call writeString
		call Crlf
		jmp loop1
	pass1:
		mov count, eax
		call CrLf

	;initialize before loop/display

	;display first
	mov eax, 2  ;fixed the first number beacuse I couldnt figure out how to do it without fixing it
	call WriteDec
	mov al, TAB
	call WriteChar
	mov loopcount, 1  ;increment the loopcount to 1 out of 5
	cmp count, 1 ;compare the count
	je done

	;display second
	mov eax, 1   ;fixed the second number beacuse I couldnt figure out how to do it without fixing it
	call WriteDec
	mov al, TAB
	call WriteChar
	inc loopcount  ;increment the loopcount to 2 out of 5
	cmp count, 2 ;compare the count
	je done

	;intitialize/for realiessss
	mov temp, 1
	mov ebx, 2
	mov ecx, count
	dec ecx
	dec ecx

	loop2: ;counting loopee
		mov eax, temp
		add eax, ebx    ;eax = (n-1), abx = (n-2), 
		mov ebx, temp
		mov temp, eax
		call WriteDec   ;display the lucas value
		mov  al, TAB      
		call WriteChar
		inc loopcount
		cmp loopcount, 5 ;post-test loop to diplay only 5 per line 
		je newline
		jmp pass2
	newline:
		mov loopcount, 0 ;start a new line
		call CrLf
	pass2:
		loop loop2   ;restart the loop

	;farewell
	done:
		call CrLf
		mov edx, OFFSET credit ; credit
		call WriteString
		call Crlf	
		mov edx, OFFSET bye ; good-bye messege
		call WriteString
		mov edx, OFFSET yourName
		call WriteString
		call CrLf

	
	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
