SOURCE = main_tb.v
WAVE = gtkwave
C11 = -std=c11

asm: 
	gcc preassembler.c -o preassemble $(C11)
	./preassemble
	gcc assembler.c -o assemble $(C11)
	./assemble
run:
	iverilog -o out.vvp $(SOURCE)
	vvp out.vvp
wave:
	$(WAVE) bag.vcd
clean:
	rm -f intermediate.txt output.bin link assemble preassemble out.vvp bag.vcd
	echo "Done."
	