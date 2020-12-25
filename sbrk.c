
#define GC_HEAP_MEM_SIZE (2 * 1024 * 1024)

void *sbrk(int inc){
    static char mem[GC_HEAP_MEM_SIZE];
    static int pos = 0;
    if(pos + inc >= GC_HEAP_MEM_SIZE) return (void*)-1;
    void *p = mem + pos;
    pos += inc;
    return p;
}
