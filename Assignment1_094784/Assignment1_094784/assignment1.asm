;Write assembly Language Program using x86 Microprocessor and 64 bit system architecture to
;ask a user to enter a number and determines and print whether the Number is Odd or Even.
;Explain all commands used at each stage [10 Marks] 

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data

result DWORD ?

.code
main proc
	mov eax, 7
	sub eax, 4
	mov result, eax

	invoke ExitProcess, 0

main endp
end main