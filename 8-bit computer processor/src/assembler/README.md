### Explanation of Assembler

##### preassembler.c (1-3) and assembler.c (4) together simiulate a linker, performing multiple functions:

1. translate psuedo code (load address, 'la') to instructions in core ISA
2. translate global data to binary code
3. prepare for linking and convert labels to numbers
4. convert linker file to binary file

##### multiplication.txt and summation.txt hold the input data for testing multiplication and summation functions. preassembler.c takes the input and generates a linker file, which is then inputted into assembler.c, which processes and outputs the machine code (binary) for the Verilog modules to process.

