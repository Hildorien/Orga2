CC=c99
CFLAGS= -Wall -Wextra -pedantic -O0 -ggdb -lm
NASM=nasm
NASMFLAGS=-f elf64 -g -F DWARF

all: main tester

main: main.c cuatrotree_c.o cuatrotree_asm.o
	$(CC) $(CFLAGS) $^ -o $@

tester: tester.c cuatrotree_c.o cuatrotree_asm.o
	$(CC) $(CFLAGS) $^ -o $@

cuatrotree_asm.o: cuatrotree.asm
	$(NASM) $(NASMFLAGS) $< -o $@

cuatrotree_c.o: cuatrotree.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o
	rm -f main tester
	rm -f salida.caso.*
