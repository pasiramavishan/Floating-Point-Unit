module multiplier_24bit_tb ();
    logic [23:0] num1, num2;
    logic clk, rstn=0;
    logic [22:0] resultF;
    logic normalize;
    localparam CLK_PERIOD = 10;

    initial begin
        clk = 1;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    multiplier_24bit dut (.*);

    initial begin   
    
//    num1 <= 24'b101110011111101111100111;
//    num2 <= 24'b100101010001111010111000;

//    #25;
//    rstn <= 1;
    
        
//    #300 check_output(resultF, 23'b10110001010101111011101);  
    
//    #50;
//    rstn <= 0;
       
//    num1 <= 24'b101100111010111000010100;
//    num2 <= 24'b110000111010111000010100;

//    #50;
//    rstn <= 1;


    
//    #300 check_output(resultF, 23'b00010010101011111001000);  
    
    #50;
//    rstn <= 0;
       
    num1 <= 24'b110000111101011100001010;
    num2 <= 24'b111000010100011110101110;

    #50;
    rstn <= 1;


    
    #300 check_output(resultF, 23'b01011000101011011010110); 

    
    
    

    end
    
    task check_output;
        input [22:0] actual;
        input [22:0] expected;
        if (actual !== expected) begin
            $display("Test Failed: Expected %h, but got %h", expected, actual);
        end else begin
            $display("Test Passed: Output %h matches expected %h", actual, expected);
        end
    endtask

endmodule
    