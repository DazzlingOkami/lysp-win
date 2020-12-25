CC      = gcc
CFLAGS  = -O  -g -Wall
CFLAGSO = -O3 -g -Wall -DNDEBUG
CFLAGSs = -Os -g -Wall -DNDEBUG

all : lysp.exe

lysp : lysp.c gc.c dlfcn_cpt.c sbrk.c
	$(CC) $(CFLAGS)  -o $@ lysp.c gc.c dlfcn_cpt.c sbrk.c
	size $@.exe

olysp: lysp.c gc.c
	$(CC) $(CFLAGSO) -o $@ lysp.c gc.c dlfcn_cpt.c sbrk.c
	size $@.exe

ulysp: lysp.c gc.c
	$(CC) $(CFLAGSs) -o $@ lysp.c gc.c dlfcn_cpt.c sbrk.c
	size $@.exe

run : all
	./lysp.exe -v -x test.l

test : lysp.exe olysp.exe ulysp.exe
	@echo
	./lysp.exe -v -x bench.l
	@echo
	./ulysp.exe -v -x bench.l
	@echo
	./olysp.exe -v -x bench.l

clean : .FORCE
	rm -rf *~ *.o lysp olysp ulysp *.dSYM

.FORCE :
