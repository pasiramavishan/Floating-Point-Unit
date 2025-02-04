module radix4 #(
    N = 24
    // N = 8
) (
    input logic [N-1:0] num1, num2,
    input logic clk,
    input logic rstn,
    output logic [2*N-1:0] FinalResult,
    output logic ready
);
    logic [2:0] register;
    logic [2*N-1:0] multipler, reg1, result, reg2;
    logic [$clog2(N)-1:0]  c_bits;
    logic [N:0] num2_dup; 

    assign result = 0;
    
    always_ff @( posedge clk or negedge rstn ) begin : State

        if (!rstn) begin
            FinalResult <= 0;
            reg1 <= 0;
            reg2 <= 0;
            c_bits <= -1;
            num2_dup <= {num2, 1'b0}; 
            ready <= 1'b0;

        end
        else begin

            if (c_bits == N/2) begin
                FinalResult <= result << 1;
                ready <= 1'b1;
            end

            else begin
                c_bits <= c_bits + 1;
                
                register <= num2_dup[2:0];
                num2_dup <= num2_dup >> 2;
                reg1  <= result;
                reg2 <= multipler << (c_bits)*2;
            end

            
        end
    end

    always_comb begin : caseHandling

        case (register)
            3'b000: multipler = 0; 
            3'b001: multipler = num1; 
            3'b010: multipler = num1; 
            3'b011: multipler = num1 << 1; 
            3'b100: multipler = (~num1 + 1'b1) << 1 ; 
            3'b101: multipler = ~num1 + 1'b1; 
            3'b110: multipler = ~num1 + 1'b1; 
            3'b111: multipler = 0;
            default: multipler = 0;
        endcase

    end
    // Instantiate the AdderSubtractor_Nbit module
    AdderSubtractor_Nbit #(2*N) adder_subtractor_instance (
        .reg1(reg1),         
        .reg2(reg2),        
        .op(0),             
        .result(result),     
        .cout(cout)   
    );
    

endmodule