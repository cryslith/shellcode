all: shellcode readfile

shellcode:
	as -o shellcode.o shellcode.s
	ld -o shellcode shellcode.o
	rm shellcode.o

readfile:
	as -o readfile.o readfile.s
	ld -o readfile readfile.o
	rm readfile.o

.PHONY: all shellcode readfile
