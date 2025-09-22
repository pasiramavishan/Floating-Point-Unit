module AdderSubtractor_Nbit(
    N = 32
)(
    
    input logic [N-1:0] reg1, reg2,
    input logic op,
    output logic [N-1:0] result,
    output logic cout
);

    logic [N:0] c;

    assign c[0] = op;

    genvar i;

    
    generate
        for (i = 0; i < N; i = i + 1) begin : adder_gen
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
    
    assign cout = c[N];
    
endmodule

    