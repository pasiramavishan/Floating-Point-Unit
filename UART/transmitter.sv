module transmitter (
    input  logic [31:0] data_in,  // Input data as a 32-bit register/vector
    input  logic       wr_en,    // Enable wire to start
    input  logic       clk_50m,
    input  logic       clken,    // Clock signal for the transmitter
    output logic       Tx,       // A single 1-bit register variable to hold transmitting bit
    output logic       Tx_busy   // Transmitter is busy signal
);

// Initialize Tx to 1 to indicate idle state
initial begin
    Tx = 1'b1;
end

// Define the 4 states using 2-bit encoding
parameter TX_STATE_IDLE  = 2'b00;
parameter TX_STATE_START = 2'b01;
parameter TX_STATE_DATA  = 2'b10;
parameter TX_STATE_STOP  = 2'b11;

logic [43:0] data = 32'h0;           // 44-bit register/vector initialized to 0
logic [5:0]  bit_pos = 6'h0;         // 6-bit register/vector initialized to 0
logic [1:0]  state = TX_STATE_IDLE; // 2-bit register/vector initialized to IDLE
logic        flag1 = 1'b0;
logic        flag2 = 1'b1;

// Toggle flag1 on write enable signal
always_ff @(posedge wr_en) begin
    flag1 <= ~flag1;
end

// Main state machine
always_ff @(posedge clk_50m) begin
    case (state)
        TX_STATE_IDLE: begin
            if (flag1 == flag2) begin
                state <= TX_STATE_START; // Transition to START state
                data  <= {2'b11, data_in[31:24], 1'b0, // Word 3
                          2'b11, data_in[23:16], 1'b0, // Word 2
                          2'b11, data_in[15:8],  1'b0, // Word 1
                          2'b11, data_in[7:0]};        // Word 0
                bit_pos <= 6'h0; // Reset bit position
                flag2 <= ~flag2;
            end
        end

        TX_STATE_START: begin
            if (clken) begin
                Tx <= 1'b0; // Start bit
                state <= TX_STATE_DATA;
                bit_pos <= 6'h0;
            end
        end

        TX_STATE_DATA: begin
            if (clken) begin
                if (bit_pos == 6'd43) begin
                    state <= TX_STATE_STOP; // Transition to STOP state
                end else begin
                    bit_pos <= bit_pos + 6'h1; // Increment bit position
                end
                Tx <= data[bit_pos]; // Transmit data bit
            end
        end

        TX_STATE_STOP: begin
            if (clken) begin
                Tx <= 1'b1; // Stop bit
                state <= TX_STATE_IDLE; // Return to IDLE state
            end
        end

        default: begin
            Tx <= 1'b1; // Default Tx to idle state
            state <= TX_STATE_IDLE;
        end
    endcase
end

// Assign busy signal based on state
assign Tx_busy = (state != TX_STATE_IDLE);

endmodule
