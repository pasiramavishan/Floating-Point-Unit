module divider_24bit #(
    N = 48
)(
    input logic [N-1:0] num1, num2, //divisor
    input logic clk, rstn,
  	output logic [N/2-1:0] remainder, 
  	output logic [N/2-2:0] quotient,
    output logic normalize
);
    logic [2*N:0] aq, aq_temp;
    logic [N:0] M;
    logic [$clog2(N)-1:0] c_bits;
    enum logic [1:0] {SHIFT, SUB, RESTORE, END} state;
    
    
    always_ff @( posedge clk or negedge rstn ) begin : divisor

        if (!rstn) begin

            c_bits <= 0;
            aq <= {49'b0, num1};
            M <= {1'b0, num2};
            state <= SHIFT;
            
        end

        else begin
            
            case (state)
                SHIFT: begin
                    aq <= aq << 1;
                    state <= SUB;
                end  

                SUB: begin
                  	aq_temp <= aq - {M, 48'b0}; 
                    state <= RESTORE;
                
                end

                RESTORE: begin
                    
                
                    if (aq_temp[2*N] == 1) begin
                        aq[0] <= 0;
                        // aq <= aq - {M, 4'b0}; 
                    end

                    else begin
                        aq <= {aq_temp[2*N:1], 1'b1};
                        
                    end

                  if (c_bits == N-1) begin
                        state <= END;
                    end

                    else begin
                        c_bits = c_bits + 1;
                        state <= SHIFT;
                    end
                
                end

                END: begin
//                   if (aq[2*N-1] == 1) begin
                    
                  	
                  
//                   end
                  remainder <= aq[N+22:N-1];
                  if (aq[N/2] == 0) begin
                    normalize <= 1'b1;
                    if (aq[N+22]==1)
                        quotient <= aq[22:0] + 1;
                        
                    else begin
                      	quotient <= aq[22:0];
                    end
                   end

                  else begin
                       normalize <= 1'b0;
                       //normalize <= 1'b1;
                       if (aq[N+22]==1)
                         quotient <= aq[23:1] + 22'b1;

                       else begin
                         quotient <= aq[23:1];
                       end
                  end
                end 
            endcase

        end        
    end
endmodule
