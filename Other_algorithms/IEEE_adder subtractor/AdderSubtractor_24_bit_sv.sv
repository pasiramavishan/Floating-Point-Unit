module AdderSubtractor_24bit_sv (
    
    input logic [23:0] reg1, reg2,
    input logic op,
    output logic [23:0] result,
    output logic cout
);

    logic [24:0] c;

    assign c[0] = op;

    genvar i;

    
    generate
        for (i = 0; i < 24; i = i + 1) begin : adder_gen
            AdderSubtractor adder_sv (
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

    


    


