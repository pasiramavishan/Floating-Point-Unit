module test (clk, op, result);
    input clk;
    input op;
    output [31:0] result;

    wire [31:0] number1, number2;
    
    assign result = 0;
    assign number1 = 32'b01000000101011011111000001101111;
    assign number2 = 32'b01000000101011011110101010110011;

    IEEE_adder dut(
        .number1(number1),
        .number2(number2), 
        .op(op), 
        .clk(clk), 
        .result(result));
    
endmodule