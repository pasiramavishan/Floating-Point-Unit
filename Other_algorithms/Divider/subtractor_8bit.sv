module subtractor_8bit (
    input logic [7:0]  numberA,
    input logic [7:0] numberB,
    output logic [7:0] result,
    output logic cout
);

    logic [8:0] c;
    
    assign c[0] = 1'b1;

    genvar i;

    
    generate
        for (i = 0; i < 8; i = i + 1) begin : adder_gen
            AdderSubtractor subtractor_sv(
                .A(numberA[i]),
                .B(numberB[i]),
                .op(1'b1),
                .cin(c[i]),
                .result(result[i]),
                .cout(c[i+1])
            );
        end
    endgenerate
    
    assign cout = c[8];
    

endmodule