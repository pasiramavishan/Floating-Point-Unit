module multiplier_6bit (
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