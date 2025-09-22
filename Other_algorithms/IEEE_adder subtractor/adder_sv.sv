module AdderSubtractor (
    input A,
    input B,
    input op,  // 0 for addition, 1 for subtraction
    input cin,
    output result,
    output cout
);
    logic B_;
    
    assign B_ = op ^ B;
    assign result = A ^ B_ ^ cin;
    assign cout = ((A ^ B_) & cin) | (A & B_);
endmodule