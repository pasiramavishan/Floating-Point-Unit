module IEEE_multiplier_tb ();
    logic [31:0] number1, number2;
    logic [31:0] result;
    logic rstn=0;
    logic clk;

    localparam CLK_PERIOD = 10;

    initial begin
        clk = 1;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    IEEE_multiplier dut (.*);

    initial begin


    number1 <= 32'b01000000101011011101001011110010;
    number2 <= 32'b01000000000101100001010001111011;
    #25;
    rstn <=1;

    #50;
    rstn <=0;
     
    #300 check_output(result, 32'b01000001010010111100111100000100);       
    
    number1 <= 32'b01000001001100111010111000010100;
    number2 <= 32'b01000001010000111010111000010100;
    #25;
    rstn <=1;

    #50;
    rstn <=0;
    #300 check_output(result, 32'b01000011000010010101011111001000);  
  
    
    number1 <= 32'b00111111110001011000000100000110;
    number2 <= 32'b00111111101101110100101111000111;
    #25;
    rstn <=1;

    #50;
    rstn <=0;

    #300 check_output(result, 32'b01000000000011010110100110110010); 
    
      
    end
    
    task check_output;
        input [31:0] actual;
        input [31:0] expected;
        if (actual !== expected) begin
            $display("Test Failed: Expected %h, but got %h", expected, actual);
        end else begin
            $display("Test Passed: Output %h matches expected %h", actual, expected);
        end
    endtask
endmodule