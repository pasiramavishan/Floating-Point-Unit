module IEEE_multiplier(
    input logic [31:0] number1, number2,
    input logic rstn,
    input logic clk,
    output logic [31:0] result
);
    logic [24:0] reg1, reg2;
    logic normalize;
    logic [47:0] reg3 = 48'b0, reg4 = 48'b0, reg5;
    logic [7:0] realCo, reg6, reg7;
    logic cout1;
//    logic cout;
    assign result[31] = number1[31] ^ number2[31];
    assign reg1 = {1'b1, number1[22:0]};
    assign reg2 = {1'b1, number2[22:0]};
    // assign reg5 = 24'b0;


    subtractor_8bit subtractor (
        .reg1(number1[30:23]), 
        .reg2(8'd127), 
        .result(realCo)
        );

    Adder_8bit adder(
        .numberA(realCo),
        .numberB(number2[30:23]),
        .result(reg6),
        .cout(cout)
    );

    multiplier_24bit multilplier(
        .num1(reg1), 
        .num2(reg2),
        .clk(clk), 
        .rstn(rstn),
        .resultF(result[22:0]),
        .normalize(normalize)
        
    );

    always_comb begin
        if (normalize) begin
            result[30:23] = reg6 + 1;
        end
    
        else begin
            result[30:23] = reg6;
            
        end
        
    end    
endmodule