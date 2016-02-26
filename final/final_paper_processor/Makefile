
SOURCE = main_tb.v
WAVE = gtkwave

all: 
	iverilog -o pp.vvp $(SOURCE)
	vvp pp.vvp
	$(WAVE) pp.vcd
	
clean:
	rm -rf *.vvp *.vcd