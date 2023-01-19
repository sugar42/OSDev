//ifndef -> "if something is not defined"
//closed with #endif tag
#ifndef __TYPES_H

#define __TYPES_H

    //byte-perfect implementation of different datatype sizes to interact correct with the hardware/assembler
    //example -> if compiler has different size of compiled ints as maybe assembler 
    typedef char int8_t;
    typedef unsigned char uint8_t;

    typedef short int16_t;
    typedef unsigned short uint16_t;

    typedef int int32_t;
    typedef unsigned short uint32_t;

    typedef long long int int64_t;
    typedef unsigned long long int uint64_t;


#endif
//closes ifndef tag 