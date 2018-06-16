
module  multiplexer (A, B, sel, res);

parameter n = 32;
input [n-1:0] A;
input [n-1:0] B;
input sel; //if 1 res = A otherwise res = B
output [n-1:0] res;



assign res = (sel == 0) ? A : B;

endmodule
