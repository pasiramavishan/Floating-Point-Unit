module IEEE_divider (
    input logic [31:0] num1, num2, //divisor
    input logic clk, rstn,
    output logic [31:0] result,
    output logic [23:0] remainder
);
    logic normalize;
    logic [47:0] reg1, reg2;
    logic [7:0] reg3;

assign reg1 = {1'b1, num1[22:0], 24'b0};
assign reg2 = {1'b1, num2[22:0], 24'b0};

subtractor_8bit subtractor (
    .numberA(num1[30:23]),
    .numberB(num2[30:23]),
    .result(reg3),
    .cout(cout)
);

always_ff @( posedge clk or negedge rstn ) begin : divider

    if (!rstn) begin
        result <= 32'b0;
    end

    else begin

        result[31] <= num1[31] ^ num2[31];
        if (normalize)
            result[30:23] <= reg3 + 8'd127 - 1'b1;
        else begin
            result[30:23] <= reg3 + 8'd127;
        end
    
    end

end

divider_24bit#(
    .N(48)
)  dut(
    .num1(reg1), 
    .num2(reg2), //divisor
    .clk(clk),
    .rstn(rstn),
    .remainder(remainder), 
    .quotient(result[22:0]),
    .normalize(normalize)
);

endmodule