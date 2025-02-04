/* module multiplier_6bit (
    input logic [5:0] num1, num2,
    input logic clk, rstn,
    output logic [11:0] result
);

    logic [11:0] reg1 = 0, reg2 = 0, reg3 = 0, reg4 = 0;


    multiplier_optimized dut1 (
        .num1(num1[2:0]),
        .num2(num2[2:0]),
        .clk(clk), 
        .rstn(rstn),
        .result(reg1[5:0])
    );
    
    
    multiplier_optimized dut2 (
        .num1(num1[5:3]),
        .num2(num2[2:0]),
        .clk(clk), 
        .rstn(rstn),
        .result(reg2[5:0])
    );

    multiplier_optimized dut3 (
        .num1(num1[2:0]),
        .num2(num2[5:3]),
        .clk(clk), 
        .rstn(rstn),
        .result(reg3[5:0])
    );

    multiplier_optimized dut4 (
        .num1(num1[5:3]),
        .num2(num2[5:3]),
        .clk(clk), 
        .rstn(rstn),
        .result(reg4[5:0])
    );

    assign result = reg1 + (reg2 << 3) + (reg3 << 3) + (reg4 << 6);
    
endmodule

*/
module multiplier_6bit (
    input logic [5:0] num1, num2,
    input logic clk, rstn,
    output logic [11:0] result,
	 output logic ready
);

    logic [3:0] c_bits;
    logic [11:0] result_temp;
    logic [11:0] num1_temp, num2_temp;


    always_ff @( posedge clk or negedge rstn ) begin : multiplier_optimized

        if (!rstn) begin
            c_bits <= 0;
            num1_temp <= {3'b0, num1};
            num2_temp <= {3'b0, num2};
            result_temp <= 0;
            
            
        end

        else begin
            
            if (c_bits ==  6) begin
                result <= result_temp;
					 ready <= 1'b1;
                
            end

            else begin
                c_bits <= c_bits + 1;
                num2_temp <= num2_temp >> 1;
                if (num2_temp[0] == 1) begin
                    result_temp <= result_temp + (num1_temp << c_bits);
                    
                end



            end


            
        end
        
    end
    
endmodule