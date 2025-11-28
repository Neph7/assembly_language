; Even or Odd - 32-bit MASM using Irvine32

.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc               ; Needed for WriteString, ReadInt, CrLf, exit

.data
    msg   BYTE "ENTER NUMBER: ", 0
    num   SDWORD ?                 ; store the integer
    msg1  BYTE "ENTERED NUMBER IS EVEN", 0
    msg2  BYTE "ENTERED NUMBER IS ODD", 0

.code
main PROC

    
    ; 1. Prompt user
   
    mov     edx, OFFSET msg        ; EDX = address of prompt string
    call    WriteString            ; print "ENTER NUMBER: "

   
    ; 2. Read integer
    
    call    ReadInt                ; read integer from keyboard into EAX
    mov     num, eax               ; save it in variable 'num'

 
    ; 3. Compute num % 2
  
    mov     eax, num               ; EAX = num
    mov     ebx, 2                 ; divisor = 2
    cdq                             ; sign-extend EAX into EDX:EAX (EDX becomes 0 or -1)
    idiv    ebx                    ; signed divide EDX:EAX by EBX
                                   ; quotient -> EAX, remainder -> EDX


    ; 4. Test remainder for even/odd
   
    cmp     edx, 0                 ; remainder == 0 ?
    jne     isOdd                  ; if not 0 ? odd

    ; EVEN branch
    call    CrLf
    mov     edx, OFFSET msg1       ; "ENTERED NUMBER IS EVEN"
    call    WriteString
    call    CrLf
    jmp     done

isOdd:
    ; ODD branch 
    call    CrLf
    mov     edx, OFFSET msg2       ; "ENTERED NUMBER IS ODD"
    call    WriteString
    call    CrLf

done:

    ; 5. Exit program
   
    INVOKE  ExitProcess, 0

main ENDP
END main
