#set variables
GPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
ASPARAMS = --32
LDPARAMS = -melf_i386

objects= loader.o kernel.o

#make output file from cpp 
%.o: %.cpp
		g++ $(GPPPARAMS) -o $@ -c $<
#create .o file from .s file
#as = assembler with ASPARAMS
#outputfile is target file and use input file as input file
%.o: %.s
		as $(ASPARAMS) -o $@ $<

mykernel.bin: linker.ld $(objects)
		ld $(LDPARAMS) -T $< -o $@ $(objects)

install: mykernel.bin 
		sudo cp $< /boot/mykernel.bin
