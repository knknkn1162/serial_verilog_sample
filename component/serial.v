`include "enable_gen.v"
`include "flopr_en.v"
`include "bshift_reg_en.v"
`include "counter_seq_en.v"

module serial (
  input wire clk, i_sclr_n, i_dat,
  output wire [7:0] o_dat
);

  parameter EN_SIZE = 3;
  parameter BIT_SIZE = 8;

  wire s_en;
  wire s_sclr;
  wire [BIT_SIZE-1:0] s_rcv;


  // make positive logic
  assign s_sclr = ~i_sclr_n;

  // make 50/9 MHz enable signal
  enable_gen #(EN_SIZE) enable_gen0(
    .clk(clk),
    .i_sclr(s_sclr),
    .o_en(s_en)
  );

  // remove chattering and detect enable posedge.
  // wire [EN_SIZE-1:0] s_reg_clk;
  // bshift_reg #(3) bshift_reg0(
  //   .clk(clk),
  //   .i_sclr(i_sclr),
  //   .i_bit(s_en),
  //   .o_data(s_reg_clk)
  // );
  // wire s_clkrise_en;
  // assign s_clkrise_en = (s_reg_clk[2:1] == 2'b01);

  // bflopr bflopr0(
  //   .clk(clk),
  //   .i_sclr(i_sclr),
  //   .i_a(i_en),
  //   .o_y(s_en_1)
  // );

  // transform serial -> pararrel
  bshift_reg_en #(BIT_SIZE) bshift_reg_ser2par(
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(s_en),
    .i_bit(i_dat),
    .o_data(s_rcv)
  );

  // sequential count
  wire [EN_SIZE-1:0] s_cnt;
  counter_seq_en #(EN_SIZE) counter_seq_en0 (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .i_dat(i_dat),
    .o_cnt(s_cnt)
  );

  // put o_dat
  wire s_dat_en;
  assign s_dat_en = s_en & (s_cnt == {EN_SIZE{1'b1}});
  flopr_en #(BIT_SIZE) flopr_en1(
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(s_en),
    .i_a(s_rcv),
    .o_y(o_dat)
  );

endmodule
