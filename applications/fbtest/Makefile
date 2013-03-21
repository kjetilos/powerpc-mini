CC=powerpc-unknown-linux-gnu-gcc
CFLAGS=-std=c99
TREE=../../tree

fbtest: main.c
	$(CC) $(CFLAGS) -o $@ $^

install: fbtest
	install -m 755 fbtest $(TREE)/bin/fbtest
