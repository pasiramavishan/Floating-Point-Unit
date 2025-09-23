module divider_tb ();
    localparam N = 4;
    localparam CLK_PERIOD = 10;
    logic [N-1:0] num1, num2;
    logic clk, rstn=0;
    logic [N/2-1:0] remainder, quotient;

    
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end


    divider dut(.*);

    initial begin
        // num1 <= 24'b010110101010011010000101;
        // num2 <= 24'b011010101011110101000101;

        num1 <= 4'b1100;
        num2 <= 4'b0011;

        @(posedge clk);

        rstn <= 1;

        @(posedge clk);
        rstn <=1;

        repeat (10) 
        #15 check_output(quotient, 4'b0111); 
    end

    task check_output;
        input [47:0] actual;
        input [47:0] expected;
        if (actual !== expected) begin
        $display("Test Failed: Expected %h, but got %h", expected, actual);
        end else begin
        $display("Test Passed: Output %h matches expected %h", actual, expected);
        end
    endtask
endmodule