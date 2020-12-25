#ifndef __DLFCN_CPT_H
#define __DLFCN_CPT_H

#define RTLD_NOW    0
#define RTLD_LAZY   1
#define RTLD_GLOBAL 2
#define RTLD_LOCAL  4

#define dlopen(name, mode) ((void*)0)

void *dlsym(void *module, const char *name);

#define dlclose(module) (0)

#define dlerror() ("")

#endif
