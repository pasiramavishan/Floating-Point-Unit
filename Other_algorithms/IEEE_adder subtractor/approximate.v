module approximate(reg1, cout, incr, op, reg1_);
    input [23:0] reg1;
    input cout;
    input op;
    output reg signed [7:0] incr;
    output reg [23:0] reg1_;

    reg [23:0] reg1_temp;
    
    always @(*) begin
        incr = 0;
        reg1_temp = reg1;
        reg1_ = reg1;
        
        if (cout == 1 && op == 0) begin
            incr = incr + 1;
            reg1_temp = reg1_temp >> 1;
            reg1_ = reg1_temp;
        end else begin
            if (reg1_temp[23] == 0) begin
                while (reg1_temp[23] == 0 && incr < 24) begin
                    incr = incr - 1;
                    reg1_temp = reg1_temp << 1;
                end
                reg1_ = reg1_temp;
            end 
        end
    end
endmodule
