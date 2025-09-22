module AdderSubtractor(A, B, result, op, cin, cout);
   input A, B, op, cin;
   output result, cout;
   wire B_;

   assign B_ = op ^ B;
   assign result = A ^ B_ ^ cin;
   assign cout = ((A ^ B_) & cin) | (A & B_);

endmodule