module multiplier_optimized (
    input logic [2:0] num1, num2,
    input logic clk, rstn,
    output logic [5:0] result
);

    logic [2:0] c_bits;
    logic [5:0] result_temp;
    logic [5:0] num1_temp, num2_temp;


    always_ff @( posedge clk or negedge rstn ) begin : multiplier_optimized

        if (!rstn) begin
            c_bits <= 0;
            num1_temp <= {3'b0, num1};
            num2_temp <= {3'b0, num2};
            result_temp <= 0;
            
            
        end

        else begin
            
            if (c_bits == 3) begin
                result <= result_temp;
                
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