all: shellcode readfile short_shellcode

clean: clean_shellcode clean_readfile clean_short_shellcode

shellcode:
	as -o shellcode.o shellcode.s
	ld -o shellcode shellcode.o
	rm shellcode.o

clean_shellcode:
	rm shellcode

readfile:
	as -o readfile.o readfile.s
	ld -o readfile readfile.o
	rm readfile.o

clean_readfile:
	rm readfile

short_shellcode:
	as -o short_shellcode.o short_shellcode.s
	ld -o short_shellcode short_shellcode.o
	rm short_shellcode.o

clean_short_shellcode:
	rm short_shellcode

.PHONY: all clean clean_shellcode clean_readfile clean_short_shellcode
