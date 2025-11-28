; Largest Number in Array - 32-bit MASM using Irvine32

.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc               ; Needed for WriteString, WriteInt, CrLf, exit

.data
    msgArray    BYTE "Array elements are: ", 0
    msgResult   BYTE "The largest number is: ", 0

    ; Define an array of signed 32-bit integers
    numbers     SDWORD  5, -3, 12, 7, 0

    ; Variable to hold the largest number
    largest     SDWORD  ?

.code
main PROC


    ; 1. (Optional) Display the array header message
  
    mov     edx, OFFSET msgArray      ; EDX = address of "Array elements are: "
    call    WriteString               ; print the header text
    call    CrLf                      ; move to new line

  
    ; 2. Initialize "largest" with the first array element
  
    mov     eax, numbers              ; EAX = numbers[0]
    mov     largest, eax              ; largest = numbers[0]

  
    ; 3. Set up loop index to start from second element
    ;    ECX will be our index, starting from 1
  
    mov     ecx, 1                    ; index = 1 (second element)

ArrayLoop:


    ; 4. Check if index >= LENGTHOF numbers
    ;    LENGTHOF numbers is resolved at assembly time
  
    cmp     ecx, LENGTHOF numbers     ; compare index with number of elements
    jge     DoneLoop                  ; if index >= count, exit loop

  
    ; 5. Load current element numbers[ecx] into EAX
    ;    TYPE numbers = size of each element (4 bytes)
    ;    Effective address: numbers + ecx * 4
    
    mov     eax, numbers[ecx*TYPE numbers]  ; EAX = numbers[ecx]

   
    ; 6. Compare current element with "largest"
 
    cmp     eax, largest              ; if numbers[ecx] > largest ?
    jle     SkipUpdate                ; if <= largest, skip updating

    ; 7. Update largest if current element is greater

    mov     largest, eax              ; largest = numbers[ecx]

SkipUpdate:

    ; 8. Increment index and repeat the loop

    inc     ecx                       ; index++
    jmp     ArrayLoop                 ; go back to start of loop

DoneLoop:

    ; 9. Print the result: "The largest number is: X"

    mov     edx, OFFSET msgResult     ; EDX = address of result message
    call    WriteString               ; print "The largest number is: "

    mov     eax, largest              ; EAX = largest number found
    call    WriteInt                  ; print the integer value in EAX

    call    CrLf                      ; print newline


    ; 10. Exit program
  
    INVOKE  ExitProcess, 0

main ENDP
END main
