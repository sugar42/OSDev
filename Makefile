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

#to run in virtual box
mykernel.iso: mykernel.bin
		mkdir iso
		mkdir iso/boot
		mkdir iso/boot/grub
		cp $< mykernel.bin iso/boot/
		echo 'set timeout=0' >> iso/boot/grub/grub.cfg
		echo 'set default=0' >> iso/boot/grub/grub.cfg
		echo '' >> iso/boot/grub/grub.cfg
		echo 'menuentry "My Operating System" {' >> iso/boot/grub/grub.cfg
		echo '	multiboot /boot/mykernel.bin' >> iso/boot/grub/grub.cfg
		echo '	boot' >> iso/boot/grub/grub.cfg
		echo '}' >> iso/boot/grub/grub.cfg
		grub-mkrescue --output=$@ iso 
		rm -rf iso
#kills vm process if exists instead of throwing error		
run: mykernel.iso
		(killall VirtualBox && sleep 1) || true  
		VBoxManage startvm "MAXIMUS" &

