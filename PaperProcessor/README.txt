Team Name: 	Aardvark

Team Members: Andy Jeong, Gordon Macshane, Brenda So



To change the directory to the file location:
	cd /<location1>/<location2> (...so on)

To compile on terminal: 
	iverilog -o <objectname> main_tb.v

To run the compiled object file:
	vvp <objectname>
	(if <objectname> is testbench, type ./testbench)

To change the instruction:
	change the bits in instruct.bin

Optional:
To see the waveform using gtkwave simulator (as defined in code as "pp.vcd"):
	gtkwave pp.vcd

To remove the object file:
	rm <objectname>
