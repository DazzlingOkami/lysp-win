#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define EXPORT_SYM(sym) if(!strcmp(name, #sym)) return &sym

struct _Cell;
typedef struct _Cell Cell;

extern Cell *flambdaFsubr(Cell *args, Cell *env);
extern Cell *lambdaFsubr(Cell *args, Cell *env);
extern Cell *letFsubr(Cell *args, Cell *env);
extern Cell *ifFsubr(Cell *args, Cell *env);
extern Cell *whileFsubr(Cell *args, Cell *env);
extern Cell *setqFsubr(Cell *args, Cell *env);
extern Cell *consSubr(Cell *args, Cell *env);
extern Cell *rplacaSubr(Cell *args, Cell *env);
extern Cell *rplacdSubr(Cell *args, Cell *env);
extern Cell *carSubr(Cell *args, Cell *env);
extern Cell *cdrSubr(Cell *args, Cell *env);
extern Cell *evalSubr(Cell *args, Cell *env);
extern Cell *applySubr(Cell *args, Cell *env);
extern Cell *mapSubr(Cell *args, Cell *env);
extern Cell *assqSubr(Cell *args, Cell *env);
extern Cell *printlnSubr(Cell *args, Cell *env);
extern Cell *addSubr(Cell *args, Cell *env);
extern Cell *subtractSubr(Cell *args, Cell *env);
extern Cell *multiplySubr(Cell *args, Cell *env);
extern Cell *divideSubr(Cell *args, Cell *env);
extern Cell *modulusSubr(Cell *args, Cell *env);
extern Cell *lessSubr(Cell *args, Cell *env);
extern Cell *lessEqualSubr(Cell *args, Cell *env);
extern Cell *equalSubr(Cell *args, Cell *env);
extern Cell *notEqualSubr(Cell *args, Cell *env);
extern Cell *greaterEqualSubr(Cell *args, Cell *env);
extern Cell *greaterSubr(Cell *args, Cell *env);
extern Cell *printlnSubr(Cell *args, Cell *env);
extern Cell *intPokeSubr(Cell *args, Cell *env);
extern Cell *charPeekSubr(Cell *args, Cell *env);
extern Cell *charPokeSubr(Cell *args, Cell *env);
extern Cell *primToStringSubr(Cell *args, Cell *env);

extern int heap_max_used(void);
extern size_t GC_count_objects(void);
extern size_t GC_count_bytes(void);

void *dlsym(void *module, const char *name){

    EXPORT_SYM(flambdaFsubr);
    EXPORT_SYM(lambdaFsubr);
    EXPORT_SYM(letFsubr);
    EXPORT_SYM(ifFsubr);
    EXPORT_SYM(whileFsubr);
    EXPORT_SYM(setqFsubr);
    EXPORT_SYM(consSubr);
    EXPORT_SYM(rplacaSubr);
    EXPORT_SYM(rplacdSubr);
    EXPORT_SYM(carSubr);
    EXPORT_SYM(cdrSubr);
    EXPORT_SYM(evalSubr);
    EXPORT_SYM(applySubr);
    EXPORT_SYM(mapSubr);
    EXPORT_SYM(assqSubr);
    EXPORT_SYM(printlnSubr);
    EXPORT_SYM(addSubr);
    EXPORT_SYM(subtractSubr);
    EXPORT_SYM(multiplySubr);
    EXPORT_SYM(divideSubr);
    EXPORT_SYM(modulusSubr);
    EXPORT_SYM(lessSubr);
    EXPORT_SYM(lessEqualSubr);
    EXPORT_SYM(equalSubr);
    EXPORT_SYM(notEqualSubr);
    EXPORT_SYM(greaterEqualSubr);
    EXPORT_SYM(greaterSubr);
    EXPORT_SYM(printlnSubr);
    EXPORT_SYM(intPokeSubr);
    EXPORT_SYM(charPeekSubr);
    EXPORT_SYM(charPokeSubr);
    EXPORT_SYM(primToStringSubr);

    EXPORT_SYM(puts);
    EXPORT_SYM(malloc);
    EXPORT_SYM(free);
    EXPORT_SYM(sprintf);
    EXPORT_SYM(exit);

    EXPORT_SYM(heap_max_used);
    EXPORT_SYM(GC_count_objects);
    EXPORT_SYM(GC_count_bytes);

    return (void*)0;
}
