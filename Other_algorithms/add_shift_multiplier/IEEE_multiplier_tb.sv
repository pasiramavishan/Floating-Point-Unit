module IEEE_multiplier_tb ();
    logic [31:0] number1, number2;
    logic [31:0] result;
    logic op;
    logic clk;

    localparam CLK_PERIOD = 10;

    initial begin
        clk = 1;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    IEEE_multiplier dut (.*);

    initial begin


//    number1 <= 32'b01000000101011011101001011110010;
//    number2 <= 32'b01000000000101100001010001111011;

     op <= 1;
     
//    #300 check_output(result, 32'b01000001010010111100111100000100);       
    number1 <= 32'b00111011101000111101011100001010;
    number2 <= 32'b00111100000101101011101110011001;
    op <= 0;
    #60;
    op <=1;

    #30;
    op <=0;
    #300 check_output(result, 32'b00111000010000001111000000100000);  
  
    
    number1 <= 32'b01000010111001010000000000000000;
    number2 <= 32'b01000001000111111101011100001010;
    op <= 1;
    #5;
    op <=0;

    #300 check_output(result, 32'b01000100100011101111101101011100); 
    
      
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