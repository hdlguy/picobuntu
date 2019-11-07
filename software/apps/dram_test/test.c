#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <string.h>

#include "mem-io.h"
#include "utils.h"
//#include "proto2_hw.h"

#define  array_size     (0x04000000)

int main(int argc,char** argv)
{

    uint32_t* dram_data = (uint32_t*)malloc((size_t)array_size);


    // create test data.
    srand(1);
    for (int i=0; i<array_size/4; i++) dram_data[i] = rand();

    // chech dram results
    int errors = 0;
    srand(1);
    for (int i=0; i<array_size/4; i++) {
        if (dram_data[i] != rand()) errors++;
    }
    fprintf(stdout, "errors = %d\n", errors);

    return 0;
}
