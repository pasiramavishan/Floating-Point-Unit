module AdderSubtractor(A, B, result, op, cin, cout);
   input A, B, op, cin;
   output result, cout;
    
   wire B_;

   assign B_ = op ^ B;
   assign result = A ^ B_ ^ cin;
   assign cout = ((A ^ B_) & cin) | (A & B_);

endmodule

// module AdderSubtractor (
//     input A,
//     input B,
//     input op,  // 0 for addition, 1 for subtraction
//     input cin,
//     output result,
//     output cout
// );
//     wire B_xor_op;
//     wire sum;
    
//     assign B_xor_op = B ^ op;
//     assign {cout, sum} = A + B_xor_op + cin;
//     assign result = sum;
// endmodule