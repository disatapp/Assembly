TITLE Program Template     (homework3.asm)

; Author: Pavin Disatapundhu
; Course CS271 / Project ID: Homework 3             Date:4/20/14
; Description: *1. Display the program title and programmer’s name. 
;			*2. Get the user’s name, and askname the user. 
;			3. Display instructions for the user. 
;			4. Repeatedly prompt the user to enter a number. 
;			5. Validate the user input to be less than or equal to 200. 
;				5.1. Numbers entered over the max value should return a comment to the user and rejected. Oregon State University Page 2 of 3 CS271
;			6. Count and accumulate the valid user entered numbers until a negative number is entered. 
;				6.1. The negative number should be discarded, NOT accumulated with the other numbers. 
;				6.2. Numbers over the max value should not be part of the sum. 
;			7. Keep track of the largest (non-negative) number entered. 
;			8. Keep track of the smallest (non-negative) number entered. 
;			9. Calculate the (rounded integer) average of the non-negative numbers. 
;			10. Calculate the (rounded integer) standard deviation of the non-negative numbers. 
;				10.1. The standard method of calculating the standard deviation requires you to already know mean and to store all the values. You will not need to do that. 
;			11. Display: 
;				11.1. Display the largest (non-negative) number entered. 
;				11.2. Display the smallest (non-negative) number entered. 
;				11.3. The count of (non-negative) numbers entered 
;					11.3.1. If no non-negative numbers were entered, display a special message and skip to 11.7. 
;				11.4. The sum of (non-negative) numbers entered. 
;				11.5. The average rounded to the nearest integer. 
;					11.5.1. Rounding to the nearest integer is not the same as truncation. 
;				11.6. The standard deviation rounded to the nearest integer. 
;				11.7. A parting message, which includes the user’s name. 

INCLUDE Irvine32.inc


UPPER = 200 ;upper value constant
.data

; pre-intro
projectname BYTE "Data Validation and Accumulator",0
username BYTE "By: Pavin Disatapundhu", 0
askname BYTE "What's your name? ",0
hiuser BYTE "Hi,",0
askq BYTE "Give the number as an integer less than or equal to 200",0
askq2 BYTE "Negative numbers will be discarded",0
quest BYTE "Enter a number: ",0
error BYTE "Out of range. Enter a number <= 200]",0
nerror BYTE "Negative number. The number will be discarded",0
tapout BTYE "No non-negative numbers were entered!!"

;reply
displySum BYTE "Sum: ", 0
displyMean BYTE "Average: ", 0
displyMax BYTE "Largest: ", 0
displyMin BYTE "Smallest: ", 0
displyCount BYTE "Numbers entered: ", 0
;displySTDev BYTE "Standard Deviation: ", 0


credit BYTE "Results certified by Pavin Disatapundhu", 0
bye BYTE "Gooood Bye,",0

yourName BYTE 30 DUP(0) ;for username
min DWORD 0
max DWORD 0
count DWORD 0
numb DWORD ?
temp DWORD ?
;loopcount DWORD ?

; Uses to calculate 
sum DWORD 0
mean DWORD ?
;minsq DWORD ?
;maxsq DWORD ?
;STDev DWORD ?

.code
main PROC

;intro/ask for name *done*
	mov edx, OFFSET projectname ;meet and askname
	call writeString
	call Crlf
	mov edx, OFFSET username ;the man who made it possible
	call writeString
	call Crlf
	mov edx, OFFSET askname
	call writeString
	mov edx, OFFSET yourName ;ask user for name
	mov ecx, SIZEOF yourName
	call ReadString
	call crlf
	
;userInstructions *done*
	mov edx, OFFSET hiuser ;hello
	call writestring
	mov edx, OFFSET yourName ;display user's name
	call WriteString
	call crLf
	mov edx, OFFSET askq ;instructions
	call writeString
	call CrLf
	mov edx, OFFSET askq2
	call writeString
	call Crlf
	call CrLf
	mov sum,0
	mov count, 0

;getUserData
	loop1:
		mov edx, OFFSET quest  ;ask user to input value
		call writeString
		call ReadInt
		cmp eax, 0
		jl exit1
		cmp eax, UPPER
		jg error1
		cmp count, 0
		je int1
		jmp pass1
	error1:
		mov edx, OFFSET error ;wrong range
		call writeString
		call Crlf
		jmp loop1

	;store min/max/count/sum
	int1:
		mov min,eax
		mov max,eax 
		jmp pass2
	pass1:
		cmp min, eax
		jl min
		cmp max, eax
		jg max
		jmp pass2
	min:
		mov min, eax
		jmp pass1
	max:
		mov max, eax
		jmp pass1
	pass2:
		mov numb, eax
		mov eax, sum
		add eax, numb ;adding number 
		inc count ;count input
		jmp loop1
	exit1:
		call CrLf

;calculationsForStdev
	;find average
	mov eax, sum
	cdq
	mov ebx, count
	div ebx
	mov mean, eax
	
	;(min - average)^2
	mov eax, mean
	mov ebx, min
	mul ebx
	mov minsq, eax
	
	;(max - average)^2
	mov eax, max
	mov ebx, mean
	mul ebx
	mov maxsq, eax
	
	;(maxsq + minsq)
	mov eax, minsq
	mov ebx, maxsq
	add ebx
	mov temp, eax
	
	;find average
	mov eax, temp
	cdq
	mov ebx, 2
	div ebx
	mov temp, eax

	;sqrt to find the stdev
	fld temp
	fsqrt

;print

	cmp count, 0
	jg print1
	mov edx, OFFSET tapout  ;ask user to input value
	call writeString
	jmp done


	print1:
		mov edx, OFFSET displayMax  ;ask user to input value
		call writeString
		mov eax, max
		call WriteDec   ;display the value
		call CrLf

		mov edx, OFFSET displayMin  ;ask user to input value
		call writeString
		mov eax, min
		call WriteDec   ;display the value
		call CrLf

		mov edx, OFFSET displayCount  ;ask user to input value
		call writeString
		mov eax, count
		call WriteDec   ;display the value
		call CrLf

		mov edx, OFFSET displaySum  ;ask user to input value
		call writeString
		mov eax, sum
		call WriteDec   ;display the value
		call CrLf
		
		mov edx, OFFSET displayMean  ;ask user to input value
		call writeString
		mov eax, mean
		call WriteDec   ;display the value
		call CrLf

		call CrLf
		mov edx, OFFSET credit ; credit
		call WriteString
		call Crlf
			
;farewell *done*
	done:
		mov edx, OFFSET bye ; good-bye messege
		call WriteString
		mov edx, OFFSET yourName
		call WriteString
		call CrLf

	
	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
