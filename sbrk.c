
#define GC_HEAP_MEM_SIZE (2 * 1024 * 1024)

static int pos = 0;
void *sbrk(int inc){
    static char mem[GC_HEAP_MEM_SIZE];
    if(pos + inc >= GC_HEAP_MEM_SIZE) return (void*)-1;
    void *p = mem + pos;
    pos += inc;
    return p;
}

int heap_used(void){
    return pos;
}