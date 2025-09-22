module test_tb ();

    logic clk, rstn=0;
    logic [47:0] result;
    localparam CLK_PERIOD = 10;


    initial begin
        clk = 1;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    test dut (.*);


    
    initial begin   

    #25;
    rstn <= 1;


    
    #300 check_output(result, 48'b0100001010010000100110100100101110101000010010010);  



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