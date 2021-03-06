`ifndef _bshift_reg
`define _bshift_reg

module bshift_reg #(
  parameter COUNT = 3
) (
  input wire clk, i_sclr, i_bit,
  output wire [COUNT-1:0] o_data
);

  reg [COUNT-1:0] s_data;

  // equal to flopr*COUNT
  always @(posedge clk)
  begin
    if (i_sclr) begin
      s_data <= {COUNT{1'b0}};
    end else begin
      s_data <= {s_data[COUNT-2:0], i_bit};
    end
  end

  assign o_data = s_data;
endmodule

`endif
