CC      = gcc
CFLAGS  = -O  -g -Wall
CFLAGSO = -O3 -g -Wall -DNDEBUG
CFLAGSs = -s -Os -g -Wall -DNDEBUG
CFLAGSstd = -O -g -Wall -std=c99

all : lysp

lysp : lysp.c gc.c dlfcn_cpt.c
	$(CC) $(CFLAGS)  -o $@ lysp.c gc.c dlfcn_cpt.c
	size $@.exe

olysp: lysp.c gc.c dlfcn_cpt.c
	$(CC) $(CFLAGSO) -o $@ lysp.c gc.c dlfcn_cpt.c
	size $@.exe

ulysp: lysp.c gc.c dlfcn_cpt.c
	$(CC) $(CFLAGSs) -o $@ lysp.c gc.c dlfcn_cpt.c
	size $@.exe

glysp: lysp.c gc.c dlfcn_cpt.c
	$(CC) $(CFLAGSstd)  -o $@ lysp.c gc.c dlfcn_cpt.c

run : all
	./lysp.exe -v -x test.l

test : lysp olysp ulysp
	@echo
	./lysp.exe -v -x bench.l
	@echo
	./ulysp.exe -v -x bench.l
	@echo
	./olysp.exe -v -x bench.l

clean : .FORCE
	del *.exe
	del *.o

.FORCE :
