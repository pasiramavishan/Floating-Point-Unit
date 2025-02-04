module IEEE_divider_tb ();
    localparam CLK_PERIOD = 10;
    logic [31:0] num1, num2; //divisor
    logic clk, rstn=0;
    logic [31:0] result;
  	logic [24:0] remainder;
    logic divisionReady;
// Finish the simulation after 1000 time units
    initial begin
        #2000 $finish;
    end

    // Generate the clock signal
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end



    IEEE_divider dut(.*);

    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(3);
      
      
      
      
//       num1 <= 32'b01000000101011100110011001100110; //5.45
//       num2 <= 32'b01000000010011010111000010100100; //3.21


//       @(posedge clk);

//       rstn <= 1;

//       @(posedge clk);
//       rstn <=1;

//       // repeat (10) 
//       #2500 
//       check_output(result, 32'b00111111110110010101001000100100);  //1.6978192
//       check_output(remainder, 24'b101100001100110100000010 );



//       num1 <= 32'b01000010111010100111010111000011;  //117.23
//       num2 <= 32'b01000000101111101011100001010010;  //5.96


//       @(posedge clk);

//       rstn <= 0;

//       @(posedge clk);
//       rstn <=1;

//       // repeat (10) 
//       #1500 check_output(result, 32'b01000001100111010101101100010000); 
//       check_output(remainder, 24'b010010010110001000010010);
      
      
//       num1 <= 32'b01000001011101111000010100011111;  //15.47
//       num2 <= 32'b01000001000110001111010111000011;  //9.56


//       @(posedge clk);

//       rstn <= 0;

//       @(posedge clk);
//       rstn <=1;

//       // repeat (10) 
//       #1500 check_output(result, 32'b00111111110011110010000100110100);  //1.6182008
//       check_output(remainder, 24'b010010111100010110010000 );
	        
    //  num1 <= 32'b01000010111010100111010111000011;  //15.47
//      num2 <= 32'b01000011010110000011101011100001;  //9.56
num1 <= 32'b01000001011101111000010100011111;
num2 <= 32'b01000001000110001111010111000011;

      @(posedge clk);

      rstn <= 0;

      @(posedge clk);
      rstn <=1;

      // repeat (10) 
      #1500 check_output(result, 32'b00111111110011110010000100110100);  //1.6182008
      check_output(remainder, 24'b100110000011111001000100 );

      rstn <=0;
@(posedge clk);
num1 <= 32'b01000010000010111110101110000101;
num2 <= 32'b01000011011010101011001100110011;

      @(posedge clk);

      rstn <= 0;

      @(posedge clk);
      rstn <=1;

      // repeat (10) 
      #1500 check_output(result, 32'b00111110000110001001111001001010);  //1.6182008
      check_output(remainder, 24'b100110000011111001000100 );
	 	 
    end

    task check_output;
      input [32:0] actual;
      input [32:0] expected;
      if (actual !== expected) begin
        $display("Test Failed: Expected %b, but got %b", expected, actual);
      end else begin
        $display("Test Passed: Output %b matches expected %b", actual, expected);
      end
    endtask
endmodule



