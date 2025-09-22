module multiplier_12bit_tb ();
    logic [11:0] num1, num2;
    logic clk, rstn=0;
    logic [23:0] result;
    localparam CLK_PERIOD = 10;

    initial begin
        clk = 1;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    multiplier_12bit dut (.*);

    initial begin   
    
    num1 <= 12'b101010110010;
    num2 <= 12'b110001110001;

    #25;
    rstn <= 1;


    
    #300 check_output(result, 24'b0100001010001000010010010);  



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
    