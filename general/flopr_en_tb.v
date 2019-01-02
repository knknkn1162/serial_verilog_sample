`include "testbench.v"
`include "flopr_en.v"

module flopr_en_tb;
  parameter WIDTH = 32;
  reg clk, i_sclr, i_en;
  reg [WIDTH-1:0] i_a;
  wire [WIDTH-1:0] o_y;

  parameter CLK_PERIOD = 10;
  flopr_en #(WIDTH) uut(.clk(clk), .i_sclr(i_sclr),
    .i_en(i_en),
    .i_a(i_a),
    .o_y(o_y)
  );

  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, flopr_en_tb);
  end

  initial begin
    clk <= 0;
  end

  always #(CLK_PERIOD/2) begin
    clk <= !clk;
  end

  initial begin
    #(CLK_PERIOD)
      i_sclr = 1'b1;
    @(posedge clk) #1
      i_sclr = 1'b0;
      `assert_eq(o_y, 32'h00000000);
      i_a <= 32'h00000001;
    @(posedge clk) #1
      `assert_eq(o_y, 32'h00000000);
      i_en <= 1'b1;
    @(posedge clk) #1
      `assert_eq(o_y, 32'h00000001);
    @(posedge clk) #1
      `assert_eq(o_y, 32'h00000001);

    `end_tb
  end
endmodule
