module subtractor_8bit(reg1, reg2, result);
    input [7:0] reg1, reg2;
    output [7:0] result;

    wire op = 1;
    
    wire [8:0] c;

    assign c[0] = op;

    genvar i;
    
    for (i = 0; i < 8; i = i + 1) begin
        AdderSubtractor addSub(
            .A(reg1[i]),
            .B(reg2[i]),
            .result(result[i]),
            .op(op),
            .cin(c[i]),
            .cout(c[i+1])
        );
    end


//    assign cout = c[8];
    
endmodule