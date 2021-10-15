module state(
	input	reset,
	input clk,
	input [2:0] state_in,
	output reg [2:0] state_out
    );
always@(posedge clk or posedge reset)begin
	if(reset)begin
		state_out <= 3'b100;
	end
	else begin
		state_out <= state_in;
	end
end

endmodule