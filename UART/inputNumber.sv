module inputNumber (
    input logic [7:0] number,
    input logic clk, rstn, enter,
    input logic [2:0] partition,
    output logic [31:0] num1, num2 
);

always_ff @(posedge clk or negedge rstn) begin : blockName
    if (!rstn) begin
        num1 <= 0;
        num2 <= 0;
    end else begin
        if (!enter) begin
            case (partition)
                3'b000: num1[7:0] <= number;
                3'b001: num1[15:8] <= number;
                3'b010: num1[23:16] <= number;
                3'b011: num1[31:24] <= number;
                3'b100: num2[7:0] <= number;
                3'b101: num2[15:8] <= number;
                3'b110: num2[23:16] <= number;
                3'b111: num2[31:24] <= number; 
            endcase           
        end
    end
end
    
endmodule
