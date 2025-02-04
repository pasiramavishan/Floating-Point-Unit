module test (
    input logic clk, rstn, enter, rstn_number,
	input logic [7:0] number,
	input logic [2:0] partition,
    input logic [1:0] operation,
	output logic [31:0] result
	//output logic [7:0] A //B, C, D, E, F, G, H
);

// logic [31:0] num1, num2;
    
    
// assign num1 = 32'b01000000101011011111000001101111;  //5.4356
// assign num2 = 32'b01000000101011011110101010110011;  //5.4349

FloatingPointUnit dut(
    .clk(clk), 
	 .rstn(rstn), 
	 .rstn_number(rstn_number),
	 .enter(enter),
    .partition(partition),
	
    .operation(operation),
    .number(number),
    .result(result)
);   						 // (-) -> 00111010001101111000000000000000

							 // (+) -> 0100000100101101111011011001000
							 
// assign A = 8'd65;							 
							 
endmodule