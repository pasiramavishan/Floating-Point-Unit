module IEEE_adder_tb();

    logic [31:0] number1, number2;
    logic op;
    logic [31:0] result;
    logic clk;

    localparam CLK_PERIOD = 10;

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    IEEE_adder dut (.*);

    initial begin
    
//        #50;


        //0b00111010010100011100000000000000

        
//        @(posedge clk);
//        number1 <= 32'b01000000111100010111100011010101;
//        number2 <= 32'b00111111111111111011111001110111;
//        op <= 0;

        
//       #50;
        
//        @(posedge clk);
        
//        number1 <= 32'b01000000110010110000111100101000;
//        number2 <= 32'b01000000110010110000100010011010;
//        op <= 1;
        
//        #50;
        
//        @(posedge clk);
//        number1 <= 32'b01000000111100010111100011010101;
//        number2 <= 32'b00111111111111111011111001110111;
//        op <= 0;
        
        
//        #50
        
//        @(posedge clk);
//        number1 <= 32'b11000000000000000000000000000000;
//        number2 <= 32'b01000001000100000000000000000000;
//        op <= 0;
        
        
          #50;
        
          @(posedge clk);
          number1 <= 32'b01000000101011011111000001101111;
          number2 <= 32'b01000000101011011110101010110011;
          op <= 1;
          
        #15 check_output(result, 32'b00111010001101111000000000000000);       
        //01000011000101101100011100010001

        @(posedge clk);
        number1 <= 32'b11000001110011101101001011110010;
        number2 <= 32'b11000001110011110100100110111010;
        op <= 1;
        
        #15 check_output(result, 32'b00111101011011011001000000000000);


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