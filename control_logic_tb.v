`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:00:36 11/19/2020
// Design Name:   control_logic
// Module Name:   D:/MCU_kbg/control_logic_tb.v
// Project Name:  MCU_kbg
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: control_logic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module control_logic_tb;

	// Inputs
	reg [2:0] op;
	reg [2:0] pstate;
	reg zero;

	// Outputs
	wire ld_acc;
	wire ld_mdr;
	wire ld_ir;
	wire dout_en;
	wire ld_pc;
	wire inc;
	wire sel;
	wire rd;
	wire wr;
	wire [2:0] nstate;

	// Instantiate the Unit Under Test (UUT)
	control_logic uut (
		.op(op), 
		.pstate(pstate), 
		.zero(zero), 
		.ld_acc(ld_acc), 
		.ld_mdr(ld_mdr), 
		.ld_ir(ld_ir), 
		.dout_en(dout_en), 
		.ld_pc(ld_pc), 
		.inc(inc), 
		.sel(sel), 
		.rd(rd), 
		.wr(wr), 
		.nstate(nstate)
	);

	initial begin
		// Initialize Inputs
		op = 0;
		pstate = 0;
		zero = 1;

		#5 zero = 0;
	end
	
	always begin
		#5 op = 000;
		#5 op = 010;
		#5 op = 110;
      #5 op = 111;
		#5 op = 010;
		#5 op = 101;
	end
	
	always begin
		#4 pstate = 000;
		#4 pstate = 010;
		#4 pstate = 011;
		#4 pstate = 100;
		#4 pstate = 000;
		#4 pstate = 010;
		#4 pstate = 011;
		#4 pstate = 100;
	end
		
endmodule

