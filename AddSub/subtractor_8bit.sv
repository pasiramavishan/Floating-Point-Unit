
module subtractor_8bit (
  input logic [7:0] reg1, reg2,
  output logic [7:0] result,
  output logic cout
);
    logic op = 1;
    
    logic [8:0] c;

    assign c[0] = op;

    genvar i;
	 

generate    
	  for (i = 0; i < 8; i = i + 1) begin : subtractor_gen
			  AdderSubtractor addSub(
					.A(reg1[i]),
					.B(reg2[i]),
					.result(result[i]),
					.op(op),
					.cin(c[i]),
					.cout(c[i+1])
			  );
		 end
		 
endgenerate

    assign cout = c[8];
    
endmodule