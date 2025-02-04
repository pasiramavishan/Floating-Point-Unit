
module AdderSubtractor_24bit (
    
    input logic [23:0] reg1, reg2,
    // input logic [24:0] reg1, reg2,
    
    input logic op,
    output logic [23:0] result,
    // output logic [24:0] result,
    output logic cout
);

    // logic [25:0] c;
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
        /* for (i = 0; i < 25; i = i + 1) begin : adder_gen
            AdderSubtractor adder_sv (
                .A(reg1[i]),
                .B(reg2[i]),
                .op(op),
                .cin(c[i]),
                .result(result[i]),
                .cout(c[i+1])
            );
        end */
    endgenerate

    /* always_comb begin : approx
        if (result[0] == 1) begin
            result = result + 1;
        end        
    end */
    assign cout = c[24];
    
endmodule

    


    


