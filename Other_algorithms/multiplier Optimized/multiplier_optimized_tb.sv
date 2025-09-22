module multiplier_optimized_tb ();
    logic [2:0] num1, num2;
    logic clk, rstn=0;
    logic [5:0] result;
    localparam CLK_PERIOD = 10;

    initial begin
        clk = 1;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    multiplier_optimized dut (.*);

    initial begin   
    
    // num1 <= 3'b110;
    // num2 <= 3'b110;

    num1 <= 3'b111;
    num2 <= 3'b111;

    #25;
    rstn <= 1;


    
    #300 check_output(result, 6'b 000110);  



    end
    
    task check_output;
        input [5:0] actual;
        input [5:0] expected;
        if (actual !== expected) begin
            $display("Test Failed: Expected %h, but got %h", expected, actual);
        end else begin
            $display("Test Passed: Output %h matches expected %h", actual, expected);
        end
    endtask

endmodule





