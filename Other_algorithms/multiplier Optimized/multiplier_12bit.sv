module multiplier_12bit (
    input logic [11:0] num1, num2,
    input logic clk, rstn,
    output logic [23:0] result
);

    logic [23:0] reg1 = 0, reg2 = 0, reg3 = 0, reg4 = 0;


    multiplier_6bit dut1 (
        .num1(num1[5:0]),
        .num2(num2[5:0]),
        .clk(clk), 
        .rstn(rstn),
        .result(reg1[11:0])
    );
    
    
    multiplier_6bit dut2 (
        .num1(num1[11:6]),
        .num2(num2[5:0]),
        .clk(clk), 
        .rstn(rstn),
        .result(reg2[11:0])
    );

    multiplier_6bit dut3 (
        .num1(num1[5:0]),
        .num2(num2[11:6]),
        .clk(clk), 
        .rstn(rstn),
        .result(reg3[11:0])
    );

    multiplier_6bit dut4 (
        .num1(num1[11:6]),
        .num2(num2[11:6]),
        .clk(clk), 
        .rstn(rstn),
        .result(reg4[11:0])
    );

    assign result = reg1 + (reg2 << 6) + (reg3 << 6) + (reg4 << 12);
    
endmodule