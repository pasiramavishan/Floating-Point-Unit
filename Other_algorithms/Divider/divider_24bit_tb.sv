module divider_24bit_tb ();
    localparam N = 48;
    localparam CLK_PERIOD = 10;
    logic [N-1:0] num1, num2;
    logic clk, rstn=0;
    logic [N-1:0] remainder, quotient;

    
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end


    divider_24bit dut(.*);

    initial begin
        num1 <= 48'b110101101001011110001101000000000000000000000000;
        num2 <= 48'b100110110101110000101001000000000000000000000000;
    
        // num1 <= 4'b1100; 000000000000000000000000000000000000000000000000
        // num2 <= 4'b0011; 000000000000000000000001010000000000000000000000

        @(posedge clk);

        rstn <= 1;

        @(posedge clk);
        rstn <=1;

        // repeat (10) 
        #800 check_output(quotient, 24'b0); 
        check_output(remainder, 24'b101100001100110100000010 );
    end

    task check_output;
        input [23:0] actual;
        input [23:0] expected;
        if (actual !== expected) begin
        $display("Test Failed: Expected %h, but got %h", expected, actual);
        end else begin
        $display("Test Passed: Output %h matches expected %h", actual, expected);
        end
    endtask
endmodule