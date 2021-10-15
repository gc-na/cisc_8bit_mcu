module top_mcu(
    input clk,
    input reset,
    input [7:0] memory_in,
    output [7:0] memory_ou,
    output [4:0] mem_add,
    output sig_r,
    output sig_w,
    output sig_dout_e
    );
    
wire [7:0] memory_out;
wire [4:0] mem_addr;
wire sig_rd;
wire sig_wr;
wire sig_dout_en;

assign memory_ou = memory_out;
assign mem_add = mem_addr;
assign sig_r = sig_rd;
assign sig_w = sig_wr;
assign sig_dout_e = sig_dout_en;

wire sig_ld_acc;
wire sig_ld_mdr;
wire sig_ld_ir;
wire sig_ld_pc;
wire sig_inc;
wire sig_sel;
wire sig_flag;
wire [2:0] sig_nstate;
wire [2:0] sig_state_out;
wire [4:0] sig_pc_out;
wire [7:0] sig_buf_out;
wire [7:0] sig_mdr_out;
wire [7:0] sig_acc_out;
wire [7:0] sig_ir_out;
wire [7:0] sig_alu_out;

acc acc1(
    .clk (clk),
    .ld (sig_ld_acc),
    .reset (reset),
    .acc_in (sig_alu_out),
    .acc_out (sig_acc_out)
    );
addr_mux addr_mux1(
    .a (sig_pc_out),
    .b (sig_ir_out[4:0]),
    .sel (sig_sel),
    .mux_out (mem_addr)
    );
alu alu1(
    .a (sig_acc_out),
    .b (sig_mdr_out),
    .op (sig_ir_out[7:5]),
    .alu_out (sig_alu_out)
    );
bi_buf bi_buf1(
    .en (sig_dout_en),
    .buf_in ( sig_acc_out),
    .d_in (memory_in),
    .buf_out (sig_buf_out),
    .d_out (memory_out)
    );
control_logic control_logic1(
    .zero (sig_flag),
    .op (sig_ir_out[7:5]),
    .pstate (sig_state_out),
    .rd (sig_rd),
    .wr (sig_wr),
    .ld_ir (sig_ld_ir),
    .sel (sig_sel),
    .inc (sig_inc),
    .ld_acc (sig_ld_acc),
    .ld_pc (sig_ld_pc),
    .dout_en (sig_dout_en),
    .ld_mdr (sig_ld_mdr),
    .nstate (sig_nstate)
    );
flag flag1(
    .clk (clk),
    .ld (sig_ld_acc),
    .reset (reset),
    .alu_out (sig_alu_out),
    .flag (sig_flag)
    );
ir ir1(
    .clk (clk),
    .ld (sig_ld_ir),
    .reset (reset),
    .ir_in (sig_buf_out),
    .ir_out (sig_ir_out[7:0])
    );
mdr mdr1(
    .clk (clk),
    .ld (sig_ld_mdr),
    .reset (reset),
    .mdr_in (sig_buf_out),
    .mdr_out (sig_mdr_out)
    );
pc_logic pc_logic1(
    .clk (clk),
    .inc_pc (sig_inc),
    .ld_pc (sig_ld_pc),
    .reset (reset),
    .pc_in (sig_ir_out[4:0]),
    .pc_out (sig_pc_out)
    );
state state1(
    .clk (clk),
    .reset (reset),
    .state_in (sig_nstate),
    .state_out (sig_state_out)
    );
endmodule