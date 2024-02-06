#!/bin/bash

# Check if two arguments are given and if filename.s exist
if [[ "$#" -eq 2 ]]; then
if [[ -r $1 ]]; then
# Compile x86 (32bit instructions) script into an elf object file
nasm -f elf -o input.o $1;
# Colpile the object file into a x86 (32bit instructions) executable
gcc -no-pie -m32 input.o -o $2;
else
echo "$2 doesn't exist"
fi

else
echo "Usage: $0 myprog.s myprog"
echo "Output: an executable file with name myprog"
fi

