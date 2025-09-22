module Adder_8bit(
    input [7:0] reg1, reg2,
    output [7:0] result,
    output cout
);
    reg op = 0;
    
    reg [8:0] c;

    assign c[0] = op;

    genvar i;
    
    for (i = 0; i < 8; i = i + 1) begin
        AdderSubtractor Adder_8bit(
            .A(reg1[i]),
            .B(reg2[i]),
            .result(result[i]),
            .op(op),
            .cin(c[i]),
            .cout(c[i+1])
        );
    end


    assign cout = c[8];
    
endmodule