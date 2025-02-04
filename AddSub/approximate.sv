module approximate(
    input logic  [23:0] reg1,
    input logic cout,
    input logic op,
    output logic signed [7:0] incr,
    output logic [23:0] reg1_
);
    logic [23:0] reg1_temp;
    
    always_comb begin
        incr = 0;
        reg1_temp = reg1;
        reg1_ = reg1;
        
      if (cout == 1 && op == 0) begin 
            incr = incr + 8'b1;
            reg1_temp = reg1_temp >> 1;
            reg1_ = reg1_temp;
        end else begin
            if (reg1_temp[23] == 0) begin
                while (reg1_temp[23] == 0 && incr < 24) begin
                    incr = incr - 8'b1;
                    reg1_temp = reg1_temp << 1;
                end
                reg1_ = reg1_temp;
            end 
        end
    end
endmodule
