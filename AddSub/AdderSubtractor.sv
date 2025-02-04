module AdderSubtractor(
   input logic A, B, op, cin,
   output logic result, cout
);
   logic B_;

   assign B_ = op ^ B;
   assign result = A ^ B_ ^ cin;
   assign cout = ((A ^ B_) & cin) | (A & B_);

endmodule