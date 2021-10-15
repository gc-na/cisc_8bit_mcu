module control_logic(
	input [2:0] op, pstate,
	input zero,
	output reg ld_acc, ld_mdr, ld_ir, dout_en, ld_pc, inc, sel, rd, wr,
	output reg [2:0] nstate
    );
always@*begin
//Initialize Control Signals
	rd	    = 0; wr    = 0; ld_ir = 0; sel = 0; inc = 0;
	ld_acc = 0; ld_pc	= 0; dout_en = 0;
	ld_mdr = 0; nstate = 000;
	
	case(pstate)
		3'b100 : begin
			rd	    = 0; wr    = 0; ld_ir = 0; sel = 0; inc = 0;
			ld_acc = 0; ld_pc	= 0; dout_en = 0;
			ld_mdr = 0; nstate = 000;
		end
		//1T : instruction fetch
		3'b000 : begin
			rd	    = 1; wr    = 0; ld_ir = 1; sel = 0; inc = 0;
			ld_acc = 0; ld_pc	= 0; dout_en = 0;
			ld_mdr = 0; nstate = 001;
		end
		//2T : instruction decode
		3'b001 : begin
			rd	    = 0; wr    = 0; ld_ir = 0; sel = 0; inc = 0;
			ld_acc = 0; ld_pc	= 0; dout_en = 0;
			ld_mdr = 0; nstate = 010;
		end
		//3T : Excute Cycle 1
		3'b010 : begin
			case(op)
				3'b000 : begin // HALT
					rd	    = 0; wr    = 0; ld_ir = 0; sel = 1; inc = 0;
					ld_acc = 0; ld_pc	= 0; dout_en = 0;
					ld_mdr = 0; nstate = 000;
				end
				
				3'b001 : begin // SKIP-if-ZERO
					rd	    = 0; wr    = 0; ld_ir = 0; sel = 1; inc = 1;
					ld_acc = 0; ld_pc	= 0; dout_en = 0;
					ld_mdr = 0; nstate = 011;
				end
				
				3'b010 : begin // ADD
					rd	    = 1; wr    = 0; ld_ir = 0; sel = 1; inc = 1;
					ld_acc = 0; ld_pc	= 0; dout_en = 0;
					ld_mdr = 1; nstate = 011;
				end
				
				3'b011 : begin // AND
					rd	    = 1; wr    = 0; ld_ir = 0; sel = 1; inc = 1;
					ld_acc = 0; ld_pc	= 0; dout_en = 0;
					ld_mdr = 1; nstate = 011;
				end
				
				3'b100 : begin // XOR
					rd	    = 1; wr    = 0; ld_ir = 0; sel = 1; inc = 1;
					ld_acc = 0; ld_pc	= 0; dout_en = 0;
					ld_mdr = 1; nstate = 011;
				end
				
				3'b101 : begin // LOAD
					rd	    = 1; wr    = 0; ld_ir = 0; sel = 1; inc = 1;
					ld_acc = 0; ld_pc	= 0; dout_en = 0;
					ld_mdr = 1; nstate = 011;
				end
				
				3'b110 : begin // STORE
					rd	    = 0; wr    = 1; ld_ir = 0; sel = 1; inc = 1;
					ld_acc = 0; ld_pc	= 0; dout_en = 1;
					ld_mdr = 0; nstate = 000;
				end
				
				3'b111 : begin // JUMP
					rd	    = 0; wr    = 0; ld_ir = 0; sel = 1; inc = 0;
					ld_acc = 0; ld_pc	= 1; dout_en = 0;
					ld_mdr = 0; nstate = 000;
				end
				
				default : begin
					rd	    = 0; wr    = 0; ld_ir = 0; sel = 0; inc = 0;
					ld_acc = 0; ld_pc	= 0; dout_en = 0;
					ld_mdr = 0; nstate = 000;
				end
			endcase
		end
		//4T : Excute Cycle 2
		3'b011 : begin
			case(op)
				3'b001 : begin // SKIP-if-ZERO
					rd	    = 0; wr    = 0; ld_ir = 0; sel = 0; inc = 0;
					ld_acc = 0; ld_pc	= 0; dout_en = 0;
					ld_mdr = 0; nstate = 000;
					inc = zero ? 1:0;
				end
				
				3'b010 : begin // ADD
					rd	    = 0; wr    = 0; ld_ir = 0; sel = 0; inc = 0;
					ld_acc = 1; ld_pc	= 0; dout_en = 0;
					ld_mdr = 0; nstate = 000;
				end
				
				3'b011 : begin // AND
					rd	    = 0; wr    = 0; ld_ir = 0; sel = 0; inc = 0;
					ld_acc = 1; ld_pc	= 0; dout_en = 0;
					ld_mdr = 0; nstate = 000;
				end
				
				3'b100 : begin // XOR
					rd	    = 0; wr    = 0; ld_ir = 0; sel = 0; inc = 0;
					ld_acc = 1; ld_pc	= 0; dout_en = 0;
					ld_mdr = 0; nstate = 000;
				end
				
				default : begin
					rd	    = 0; wr    = 0; ld_ir = 0; sel = 0; inc = 0;
					ld_acc = 0; ld_pc	= 0; dout_en = 0;
					ld_mdr = 0; nstate = 000;
				end
			endcase
		end
		
		default : begin
			rd	    = 0; wr    = 0; ld_ir = 0; sel = 0; inc = 0;
			ld_acc = 0; ld_pc	= 0; dout_en = 0;
			ld_mdr = 0; nstate = 000;
		end
	endcase
end // end always
	
endmodule