module IEEE_multiplier(
    input logic [31:0] number1, number2,
    input logic op,
    input logic clk,
    output logic [31:0] result
);
    logic [24:0] reg1, reg2;
    logic [47:0] reg3 = 48'b0, reg4 = 48'b0, reg5;
    logic [7:0] realCo, reg6, reg7;
    logic cout1;
//    logic cout;
    logic [4:0] c_clocks;
    localparam CLOCKS_PER_PULSE = 26;
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


    always_ff @( posedge clk or posedge op ) begin : multiply
        if (op) begin
            c_clocks <= 0;
            reg3 <= 48'b0; 
            reg4 <= 48'b0;

        end  
        
        else begin          
            if (c_clocks == CLOCKS_PER_PULSE - 1) begin

                if (cout1 == 1) begin
                    result[22:0] <= reg5[47:25];
                    reg7 <= reg6 + 1;
                end
                
                else begin
                    result[22:0] <= reg5[46:24];
                    reg7 <= reg6;
                end
            
            end
            else begin
                c_clocks <= c_clocks + 1;
                if (reg2[c_clocks-1] == 0) begin
                    reg3 <= reg5;
                    reg4 <= 48'd0;      //32'b0 1000001 0100 1011 1100 1111 0000 0100 
                end                     //1001 0111 1001 1110 0000100
                else begin    
                    reg3 <= reg5;
                    reg4 <= reg1 << c_clocks;

                end
            end
        end
    end



    AdderSubtractor_24bit BigALU (
        .reg1(reg3), 
        .reg2(reg4), 
        .result(reg5), 
        .op(1'b0), 
        .cout(cout1)
    );
    
    assign result[30:23] = reg7;
    
endmodule