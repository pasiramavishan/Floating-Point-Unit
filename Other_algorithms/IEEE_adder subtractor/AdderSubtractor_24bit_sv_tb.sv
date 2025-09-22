module AdderSubtractor_24bit_sv_tb (reg1, reg2, result, op, cout);
    logic [23:0] reg1, reg2;
    logic op;
    output [23:0] result;
    output cout;

    wire [24:0] c;

    assign c[0] = op;
    

    genvar i;
    
//    for (i = 0; i < 24; i = i + 1) begin
//        AdderSubtractor addSub(
//            .A(reg1[i]),
//            .B(reg2[i]),
//            .result(result[i]),
//            .op(op),
//            .cin(c[i]),
//            .cout(c[i+1])
//        );
//    end
    
    generate
        for (i = 0; i < 24; i = i + 1) begin : adder_gen
            AdderSubtractor addSub (
                .A(reg1[i]),
                .B(reg2[i]),
                .op(op),
                .cin(c[i]),
                .result(result[i]),
                .cout(c[i+1])
            );
        end
    endgenerate
    assign cout = c[24];
    


endmodule