module test_tb ();

    logic clk;
    logic op;
    logic [31:0] result;
    localparam CLK_PERIOD = 10;

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end
    
    test dut(.*);
    
    initial begin
        @(posedge clk);
        op <= 1;
        
    end
endmodule