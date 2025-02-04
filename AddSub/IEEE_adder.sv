module IEEE_adder (
    input logic [31:0] number1, number2,
    input logic op,
    input logic clk, rstn,
    output logic [31:0] result
);
    logic [7:0] exponentDifference;
    logic [7:0] exponent;
    logic [23:0] intermediate, reg3;
    logic sign;
    logic [7:0] incr;
    logic [23:0] reg1, reg2;
	 
    // logic [24:0] reg1, reg2;

    logic cout, cout1;
    logic op_;

    assign op_ = op ^ number1[31] ^ number2[31];

    subtractor_8bit smallALU(
            .reg1(number1[30:23]),
            .reg2(number2[30:23]),
				.result(exponentDifference),
				.cout(cout1)
        );
        
    always @(posedge clk or negedge rstn) begin
	 
			if (!rstn) begin
				sign <= 0;
				exponent <= 0;
				reg1 <= 0;
				reg2 <= 0;
			end
			
			else begin
			
			if (exponentDifference==0) begin
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
        else if (!exponentDifference[7]) begin
            sign <= number1[31];
            exponent <= number1[30:23];
            reg1 <= {1'b1, number1[22:0]};
            reg2 <= {1'b1, number2[22:0]} >> exponentDifference;
            
        end

        else if (exponentDifference[7]) begin
            sign <= number2[31] ^ op;
            exponent <= number2[30:23];
            reg1 <= {1'b1, number2[22:0]};
            reg2 <= {1'b1, number1[22:0]} >> -exponentDifference;   
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