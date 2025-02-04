module topModule (
    input  logic clk,
    input  logic Rx, wr_en_in,
    input  logic [2:0] operation,
    output logic [6:0] seg_out1, seg_out2, seg_out3, seg_out4,
                       seg_out5, seg_out6, seg_out7, seg_out8, // Flattened 7x8 array to a single dimension
    output logic ready,
    output logic Tx, Tx_busy, sumready
);

    logic Rxclk_en, Txclk_en;
    logic wr_en;
	 logic sumReady;
    logic [31:0] data_out, num1, num2; 
    logic [31:0] sum;

    // Receiver module instance
    receiver Receiver (
        .Rx(Rx),
        .ready(ready),         // 1-bit output
        .clk_50m(clk),      
        .clken(Rxclk_en),
        .data_out1(num1),
        .data_out2(num2)       // 32-bit output
    );

    // Baudrate generator instance
    baudrate Baudrate (
        .clk_50m(clk),
        .Rxclk_en(Rxclk_en),
        .Txclk_en(Txclk_en)
    );
    
    assign data_out = (operation == 2'b010) ? num2 :
                      (operation == 2'b000) ? sum  : num1;
							 
							 
    always_ff @(posedge clk) begin
        if (ready) begin
            sum <= num1 + num2; // Perform addition
				sumReady <= 1'b1;
		  end
			else 
				sumReady <= 1'b0;
    end
	 
	 
    always_ff @(posedge Txclk_en) begin
        if (sumReady) begin
            wr_en <= 1'b1;      // Enable the transmitter
        end else begin
            wr_en <= 1'b0;      // Disable transmitter
        end
    end
    
    // Transmitter module instance
    transmitter Transmitter (
        .data_in(32'hABCE2135),          // Input data as an 8-bit register/vector 
        .wr_en(wr_en_in),          // Enable wire to start 
        .clk_50m(clk),
        .clken(Txclk_en),       // Clock signal for the transmitter
        .Tx(Tx),                // A single 1-bit register variable to hold transmitting bit
        .Tx_busy(Tx_busy)       // Transmitter busy signal 
    );

	 assign sumready = sumReady;
	 
    // Seven-segment display instances
    seven_segment_display segA (
        .num(data_out[3:0]),  
        .seg(seg_out1)              
    );
    seven_segment_display segB (
        .num(data_out[7:4]),  
        .seg(seg_out2)              
    );
    seven_segment_display segC (
        .num(data_out[11:8]),  
        .seg(seg_out3)              
    );
    seven_segment_display segD (
        .num(data_out[15:12]),  
        .seg(seg_out4)              
    );
    seven_segment_display segE (
        .num(data_out[19:16]),  
        .seg(seg_out5)              
    );
    seven_segment_display segF (
        .num(data_out[23:20]),  
        .seg(seg_out6)              
    );
    seven_segment_display segG (
        .num(data_out[27:24]),  
        .seg(seg_out7)              
    );
    seven_segment_display segH (
        .num(data_out[31:28]),  
        .seg(seg_out8)              
    );

endmodule
