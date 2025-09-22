module multiplier_6bit_tb ();
    logic [5:0] num1, num2;
    logic clk, rstn=0;
    logic [11:0] result;
    localparam CLK_PERIOD = 10;

    initial begin
        clk = 1;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    multiplier_6bit dut (.*);

    initial begin   
    
    num1 <= 6'b011110;
    num2 <= 6'b110001;

    #25;
    rstn <= 1;


    
    #300 check_output(result, 12'b01001111);  



    end
    
    task check_output;
        input [11:0] actual;
        input [11:0] expected;
        if (actual !== expected) begin
            $display("Test Failed: Expected %h, but got %h", expected, actual);
        end else begin
            $display("Test Passed: Output %h matches expected %h", actual, expected);
        end
    endtask

endmodule
    