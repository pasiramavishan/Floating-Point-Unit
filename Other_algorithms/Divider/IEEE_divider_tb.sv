module IEEE_divider_tb ();
    localparam CLK_PERIOD = 10;
    logic [31:0] num1, num2; //divisor
    logic clk, rstn=0;
    logic [31:0] result;
    logic [24:0] remainder;

    initial begin
            clk = 0;
            forever #(CLK_PERIOD/2) clk <= ~clk;
        end


        IEEE_divider dut(.*);

        initial begin
            // num1 <= 32'b01000000101011100110011001100110;
            // num2 <= 32'b01000000010011010111000010100100;
        
            // // num1 <= 4'b1100; 000000000000000000000000000000000000000000000000
            // // num2 <= 4'b0011; 000000000000000000000001010000000000000000000000

            // @(posedge clk);

            // rstn <= 1;

            // @(posedge clk);
            // rstn <=1;

            // // repeat (10) 
            // #2500 check_output(result, 32'b00111111110110010101001000100100); 
            // check_output(remainder, 24'b101100001100110100000010 );
        
            num1 <= 32'b01000001010011101011100001010010;
            num2 <= 32'b01000001010010001010001111010111;
            
            
            @(posedge clk);

            rstn <= 0;

            @(posedge clk);
            rstn <=1;

            // repeat (10) 
            #2500 check_output(result, 32'b00111111100000111110000011111000); 
            check_output(remainder, 24'b101100001100110100000010 );
        
        end

        task check_output;
            input [32:0] actual;
            input [32:0] expected;
            if (actual !== expected) begin
            $display("Test Failed: Expected %b, but got %b", expected, actual);
            end else begin
            $display("Test Passed: Output %b matches expected %b", actual, expected);
            end
        endtask
    endmodule

