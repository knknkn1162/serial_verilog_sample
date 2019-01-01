`include "testbench.v"
`include "bshift_reg_en.v"

module bshift_reg_en_tb;
  parameter COUNT = 4;

  reg clk, i_sclr, i_en, i_bit;
  wire [COUNT-1:0] o_data;
  parameter CLK_PERIOD = 10;

  bshift_reg_en #(COUNT) uut(
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .i_bit(i_bit),
    .o_data(o_data)
  );

  `dump_block
  `conf_clk_block(clk, CLK_PERIOD)

  initial begin
    #(CLK_PERIOD)
      i_sclr = 1'b1;
    @(posedge clk) #1
      i_sclr = 1'b0;
      `assert_eq(o_data, 4'b0000);
      i_bit = 1'b0;
    @(posedge clk) #1
      `assert_eq(o_data, 4'b0000);
      i_bit = 1'b1;
      i_en = 1'b1;
    @(posedge clk) #1
      `assert_eq(o_data, 4'b0001);
      i_en = 1'b0;
    @(posedge clk) #1
      `assert_eq(o_data, 4'b0001);
      i_en = 1'b1;
    @(posedge clk) #1
      `assert_eq(o_data, 4'b0011);
      i_bit = 1'b0;
    @(posedge clk) #1
      `assert_eq(o_data, 4'b0110);
    @(posedge clk) #1
      `assert_eq(o_data, 4'b1100);
    @(posedge clk) #1
      `assert_eq(o_data, 4'b1000);

    `end_tb
  end


endmodule
