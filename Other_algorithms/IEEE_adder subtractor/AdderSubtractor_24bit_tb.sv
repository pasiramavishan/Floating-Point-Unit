module AdderSubtractor_24bit_tb ();
    logic [23:0] reg1, reg2;
    logic op;
    logic [23:0] result;
    logic cout;
    logic clk;

    localparam CLK_PERIOD = 10;

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    AdderSubtractor_24bit dut (.*);

    initial begin
        reg1 <= 24'b011001010001011001010010;
        reg2 <= 24'b110010000111011111001111;
        op <= 0;

//        @(posedge clk);
//        reg1 <= 24'd10;
//        reg2 <= 24'd20;
//        op <= 0;

//        @(posedge clk);
//        reg1 <= 24'd5;
//        reg2 <= 24'd10;
//        op <= 1;

//        @(posedge clk);
//        reg1 <= 24'd30;
//        reg2 <= 24'd10;
//        op <= 0;   

//        @(posedge clk);
//        reg1 <= 24'd5;
//        reg2 <= 24'd10;
//        op <= 1;

//        @(posedge clk);
//        reg1 <= 24'd30;
//        reg2 <= 24'd10;
//        op <= 1;
    end
endmodule