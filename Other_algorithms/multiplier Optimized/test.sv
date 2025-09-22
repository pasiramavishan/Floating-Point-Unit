module test(
    input logic clk, 
    input logic rstn, 
    output logic [47:0] result
);

    logic [31:0] num1, num2; 
        
    assign num1 = 24'b101010110010101010110010;
    assign num2 = 24'b110001110001110001110001;




	
    multiplier_24bit dut(
        .num1(num1),
        .num2(num2), 
        .rstn(rstn), 
        .clk(clk), 
        .result(result)
	);
    
endmodule