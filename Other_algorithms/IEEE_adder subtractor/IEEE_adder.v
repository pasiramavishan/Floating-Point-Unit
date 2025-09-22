module IEEE_adder (number1, number2, op, clk, result);
    input [31:0] number1, number2;
    input op;
    input clk;
    output [31:0] result;

    wire [7:0] exponentDifference;
    reg [7:0] exponent;
    wire [23:0] intermediate, reg3;
    reg sign;
    wire [7:0] incr;
    reg [23:0] reg1, reg2; 
    wire cout;
    wire op_;

    assign op_ = op ^ number1[31] ^ number2[31];

    subtractor_8bit smallALU(
            .reg1(number1[30:23]),
            .reg2(number2[30:23]),
            .result(exponentDifference)
        );
        
    always @(posedge clk) begin
        if (exponentDifference>0) begin
            sign <= number1[31];
            exponent <= number1[30:23];
            reg1 <= {1'b1, number1[22:0]};
            reg2 <= {1'b1, number2[22:0]} >> exponentDifference;
            
        end

        else if (exponentDifference<0) begin
            sign <= number2[31] ^ op;
            exponent <= number2[30:23];
            reg1 <= {1'b1, number2[22:0]};
            reg2 <= {1'b1, number1[22:0]} >> -exponentDifference;   
        end

        else if (exponentDifference==0) begin
            if (number2[22:0] > number1[22:0]) begin
                sign <= number2[31] ^ op;
                exponent <= number2[30:23];
                reg1 <= {1'b1, number2[22:0]};
                reg2 <= {1'b1, number1[22:0]}; 
            end

            else begin
                sign <= number1[31];
                exponent <= number1[30:23];
                reg1 <= {1'b1, number1[22:0]};
                reg2 <= {1'b1, number2[22:0]};  
            end
        end

    end
    
    AdderSubtractor_24bit BigALU (
        .reg1(reg1), 
        .reg2(reg2), 
        .result(intermediate), 
        .op(op_), 
        .cout(cout)
    );

    approximate aprx(
        .reg1(intermediate),
        .cout(cout), 
        .op(op_),
        .incr(incr),
        .reg1_(reg3)
    );

    assign result = {sign, exponent + incr ,reg3[22:0]};

    
endmodule