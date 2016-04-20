TITLE Program Template     (homework4.asm)

; Author: Pavin Disatapundhu
; Course CS271 / Project ID: Homework 4                 Date:5/7/14
; Description: Prime number:
;			greet user, ask for username
;			ask for the input number between 1-300 to Validate if its a prime number.
;			the program verifies if its between 1-300
;			say if its out of range
;			calcuate the nth prime and place asterisk next to numbers when its displayed
;			print with 10 prime numbers per line
;			Say goodbye to the user

INCLUDE Irvine32.inc

UPPER = 300 ;upper value constant
.data

; (insert variable definitions here)
projectname BYTE "Optimus Prime",0
username BYTE "By: Pavin Disatapundhu", 0
good BYTE "Good day,",0
askint BYTE "Enter the number of prime numbers you would like to see.",0
askint2 BYTE "I'll accept orders for up to 300 primes",0
quest BYTE "Enter the number of primes to display [1-300]:",0
error BYTE "Out of range. Please try again",0
credit BYTE "Results certified by Pavin Disatapundhu", 0
bye BYTE "Gooood Bye,",0
astr BYTE "*",0

inputPass DWORD ? ;user input
loopcount DWORD 0 ;count to 10
cur DWORD 1 ;current number
flag DWORD 0
temp DWORD 0
count DWORD 0




.code
main PROC
	call introduction
	call getUserData
	call showPrimes
	call farewell
	exit	; exit to operating system
main ENDP

;introduction
introduction PROC USES edx,
	;intro/ask for name
	mov edx, OFFSET projectname ;meet and greet
	call writeString
	call Crlf
	mov edx, OFFSET username ;the man who made it possible
	call writeString
	call Crlf
	call crlf
	
	;userInstructions
	mov edx, OFFSET askint ;instructions
	call writeString
	call CrLf
	mov edx, OFFSET askint2
	call writeString
	call Crlf
	call CrLf
	ret
introduction ENDP

getUserData PROC USES eax edx,
;get user data

	loop1:
		mov edx, OFFSET quest  ;ask user to input value
		call writeString
		call ReadInt
		mov number, eax
		call validateInput
		cmp inputPass, 1
		je loop1
	pass1:
		ret

getUserData ENDP

	validateInput PROC USES eax edx,	
	;validate users input
			mov eax, number
			cmp eax, 1
			jl error1
			cmp eax, UPPER
			jg error1
			jmp pass2
		error2:
			mov edx, OFFSET error ;wrong range
			call writeString
			call Crlf
			mov inputPass, 1
			ret
		pass2:
			call CrLf
			mov inputPass, 0
			ret
	validateInput ENDP

	
showPrimes PROC USES eax ebx edx,
;print the prime number
	cmp number, 1
	je print1
	loop3:
		mov flag, 0
		call isPrime 
		cmp flag, 1
		je line3
		loop loop3
	line3:
		cmp loopcount, 10 ;assert if 10 per line 
		jl print1
		mov loopcount, 0 ;start a new line
		call CrLf
	print1:
		mov eax, number
		call writeDec
		mov eax, cur
		mov ebx, temp
		sub eax, ebx
		cmp eax, 2	;assert if its twin prime
		je print2
		jmp print3
	print2:
		mov edx, OFFSET astr ;print *
		call writeDec
	print3:
		mov  al, TAB  
		call WriteChar
		inc loopcount
		inc count
		mov eax, cur
		mov temp, eax
		mov eax, number
		cmp eax, count
		je pass3
		loop loop3
	pass3:
		call CrLf
		ret

showPrimes ENDP
	
	isPrime PROC USES eax ecx edx, 
	mov ecx, cur ;used to compare if the divisible
	dec ecx 
	check4:
		cmp ecx, 1 ;compare if 0 or 1
		jle isntprime1
		mov eax, cur
		div ecx
		cmp edx, 0 
		je pass4  ;if not prime flag with not be set
		loop check4
	isntprime1:
		mov flag, 1 ;set remainer flag to one if it passes
	pass4:
		inc cur
		ret
	isPrime ENDP


farewell PROC USES edx,
	;farewell
	call CrLf
	mov edx, OFFSET credit ; credit
	call WriteString
	call Crlf	
	mov edx, OFFSET bye ; good-bye messege
	call WriteString
	call CrLf
	ret
farewell ENDP

END main
