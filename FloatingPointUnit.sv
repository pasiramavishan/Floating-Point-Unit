module FloatingPointUnit (
    input logic clk, rstn, Rx, wr_en_in,
    input logic [2:0] operation,
	output logic [6:0] seg_out1, seg_out2, seg_out3, seg_out4, seg_out5, seg_out6, seg_out7, seg_out8,
	output logic Tx, Tx_busy, wr_en_debug, readt_debug, sumready
);
	
	 logic Rxclk_en, Txclk_en, ready; 
    logic [31:0] result_adder, result_mult, result_div, result_subtractor, number1, number2;
	 logic [23:0] remainder;
	 logic [31:0] result, result_dup;
	 logic divisionReady, multReady, wr_en;

	 
    // Receiver module instance
    receiver Receiver_uart (
        .Rx(Rx),
        .ready(ready),          // 1-bit output
        .clk_50m(clk),      
        .clken(Rxclk_en),
        .data_out1(number1),
		  .data_out2(number2)		  // 32-bit output
    );

    // Baudrate generator instance
    baudrate Baudrate_uart (
        .clk_50m(clk),
        .Rxclk_en(Rxclk_en),
        .Txclk_en(Txclk_en)
    );
	 
	 
   always_comb begin : main
    case (operation)
        3'b000: result = result_adder;
        3'b001: result = result_adder;
        3'b010: result = result_mult;
        3'b011: result = result_div;
        3'b100: result = number1;
        3'b101: result = number2;
        default: result = 32'b0;
    endcase
end

	always_ff @(posedge clk) begin: readyLoop
		if (divisionReady) begin
			wr_en <= 1'b1;
			result_dup <= result;
		end
		else 
			wr_en <= 1'b0;
		
	end
	
    IEEE_multiplier multiplier(
        .number1(number1),
        .number2(number2),
        .rstn(ready),
        .clk(clk),
        .result(result_mult),
		  .ready(multReady)
    );

    IEEE_adder AdderSubtractor (
        .number1(number1),
        .number2(number2),
        .op(operation[0]),
        .clk(clk), 
        .rstn(ready),
        .result(result_adder)
    );

	/* IEEE_adder AdderSubtractor2 (
			  .number1(number1),
			  .number2(number2),
			  .op(1'b1),
			  .clk(clk), 
			  .rstn(ready),
			  .result(result_subtractor)
		 ); */

    IEEE_divider divider (
        .num1(number1), 
        .num2(number2),
        .clk(clk), 
        .rstn(ready),
        .result(result_div),
        .remainder(remainder),
		  .ready(divisionReady)
    );

		transmitter Transmitter_uart(	
			.data_in(result), //input data as an 8-bit regsiter/vector 
			.wr_en(wr_en),       //enable wire to start 
			.clk_50m(clk),
			.clken(Txclk_en),       //clock signal for the transmitter
			.Tx(Tx),                //a single 1-bit register variable to hold transmitting bit
			.Tx_busy(Tx_busy)       //transmitter is busy signal 
			);
	
	
	 
	 /* genvar i;
    generate
        for (i = 0; i < 8; i++) begin : display
            seven_segment_display u_seven_segment (
                .num(result[i * 4 +: 4]),  
                .seg(seg_out[i])              
            );
        end
    endgenerate */
	 
	 
	 // assign wr_en_debug = wr_en;
	 assign sumready = wr_en;
	 
	 
					 seven_segment_display segA (
                .num(result[3 : 0]),  
                .seg(seg_out1)              
            );
					 seven_segment_display segB (
                .num(result[7 : 4]),  
                .seg(seg_out2)              
            );
					 seven_segment_display segC (
                .num(result[11 : 8]),  
                .seg(seg_out3)              
            );
					 seven_segment_display segD (
                .num(result[15 : 12]),  
                .seg(seg_out4)              
            );
					 seven_segment_display segE (
                .num(result[19 : 16]),  
                .seg(seg_out5)              
            );
					 seven_segment_display segF (
                .num(result[23 : 20]),  
                .seg(seg_out6)              
            );
					 seven_segment_display segG (
                .num(result[27 : 24]),  
                .seg(seg_out7)              
            );
					 seven_segment_display segH (
                .num(result[31 : 28]),  
                .seg(seg_out8)              
            );
    
endmodule
