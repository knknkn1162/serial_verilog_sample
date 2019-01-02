`include "testbench.v"
`include "counter_seq_en.v"

module counter_en_tb;
  parameter WIDTH = 3;
  reg clk, i_sclr, i_en, i_dat;
  wire [WIDTH-1:0] o_cnt;

  parameter CLK_PERIOD = 10;
  counter_seq_en #(WIDTH, ULIMIT) uut(
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .i_dat(i_dat),
    .o_cnt(o_cnt)
  );

  `dump_block
  `conf_clk_block(clk, CLK_PERIOD)

  initial begin
    #(CLK_PERIOD)
    @(posedge clk)
      i_sclr = 1'b1;
    @(posedge clk) #1
      `assert_eq(o_cnt, 3'b000);
      i_sclr = 1'b0;
    @(posedge clk) #1
      `assert_eq(o_cnt, 3'b000);
      i_en = 1'b1; i_dat = 1'b0;
    @(posedge clk) #1
      `assert_eq(o_cnt, 3'b000);
      i_dat = 1'b1;
    @(posedge clk) #1
      `assert_eq(o_cnt, 3'b001);
    @(posedge clk) #1
      `assert_eq(o_cnt, 3'b010);
    @(posedge clk) #1
      `assert_eq(o_cnt, 3'b011);
      i_dat = 1'b0;
    @(posedge clk) #1
      `assert_eq(o_cnt, 3'b000);
    @(posedge clk) #1
      `assert_eq(o_cnt, 3'b000);
      i_dat = 1'b1;
    @(posedge clk) #1
      `assert_eq(o_cnt, 3'b001);
    @(posedge clk) #1
      `assert_eq(o_cnt, 3'b010);

    `end_tb
  end
endmodule
