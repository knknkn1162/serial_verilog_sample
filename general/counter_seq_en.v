`ifndef _counter_seq_en
`define _counter_seq_en

`include "flopr_en.v"

module counter_seq_en #(
  parameter WIDTH = 4
) (
  input wire clk, i_sclr, i_en, i_dat,
  output wire [WIDTH-1:0] o_cnt
);

  wire [WIDTH-1:0] s_cnt_0, s_cnt_1;
  flopr_en #(WIDTH) flopr_en0(
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .i_a(s_cnt_0),
    .o_y(s_cnt_1)
  );

  assign s_cnt_0 = (i_dat) ? (s_cnt_1 + 1'b1) : {WIDTH{1'b0}};
  assign o_cnt = s_cnt_1;
endmodule

`endif
