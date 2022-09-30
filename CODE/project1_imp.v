`timescale 1ns / 1ps

//module for full adder 
module full_adder( a,b,cin, sum,carry);
input a,b,cin;
output sum,carry;
assign sum=a^b^cin;
assign carry=((a&b)|(b&cin)|(cin&a));
endmodule

//module for adder for the operation of A+M
module adder(a,b,sum);
input [7:0]a,b;
output[7:0] sum;
wire cout;
wire [7:0]c;
//instantiation of full adder  module 
 full_adder fa_1(a[0],b[0],1'b0,sum[0],c[0]);
 full_adder fa_2(a[1],b[1],c[0],sum[1],c[1]);
 full_adder fa_3(a[2],b[2],c[1],sum[2],c[2]);
 full_adder fa_4(a[3],b[3],c[2],sum[3],c[3]);
 full_adder fa_5(a[4],b[4],c[3],sum[4],c[4]);
 full_adder fa_6(a[5],b[5],c[4],sum[5],c[5]);
 full_adder fa_7(a[6],b[6],c[5],sum[6],c[6]);
 full_adder fa_8(a[7],b[7],c[6],sum[7],cout);
endmodule



// module for the operation of A-M
module subtractor(sa,sb,diff);
input [7:0]sa,sb;
output[7:0] diff;
wire bout;
wire [7:0]c;
//instantiation of full adder  module 
 full_adder fa_1(sa[0],(~sb[0]),1,(diff[0]),c[0]);
 full_adder fa_2(sa[1],(~sb[1]),c[0],diff[1],c[1]);
 full_adder fa_3(sa[2],(~sb[2]),c[1],diff[2],c[2]);
 full_adder fa_4(sa[3],(~sb[3]),c[2],diff[3],c[3]);
 full_adder fa_5(sa[4],(~sb[4]),c[3],diff[4],c[4]);
 full_adder fa_6(sa[5],(~sb[5]),c[4],diff[5],c[5]);
 full_adder fa_7(sa[6],(~sb[6]),c[5],diff[6],c[6]);
 full_adder fa_8(sa[7],(~sb[7]),c[6],diff[7],bout);
endmodule


module multiplier_first_step(A,Q,q0,p,h,q,c0);
input wire signed[7:0]A,Q,p;
input wire signed q0;
output reg signed [7:0]q,h;
output reg  c0;
wire[7:0] addition,subtraction;
adder addit(A,p,addition);
subtractor subtract(A,p,subtraction);

always @(*)
    begin
         if(Q[0]==q0)
               begin
                   c0=Q[0];
                   q=Q>>1;//after shifting right the msb bit of Q[7]= 0(MSB  bit is filled with zero
                   q[7]=A[0];
                   h=A>>1;//after shifting right the msb bit of Q[7]= 0(MSB  bit is filled with zero
                   if (A[7]==1)
                   h[7]=1;
                   else
                   h[7]=0;
               end
          else if(Q[0]==1 && q0==0)
               begin
                   c0=Q[0];
                   q=Q>>1;//after shifting right the msb bit of Q[7]= 0(MSB  bit is filled with zero
                   q[7]=subtraction[0];
                   h=subtraction>>1;//after shifting right the msb bit of Q[7]= 0(MSB  bit is filled with zero
                   if (subtraction[7]==1)
                   h[7]=1;
                   else
                   h[7]=0;
               end
            else
               begin
                    c0=Q[0];
                   q=Q>>1;//after shifting right the msb bit of Q[7]= 0(MSB  bit is filled with zero
                   q[7]=addition[0];
                   h=addition>>1;//after shifting right the msb bit of Q[7]= 0(MSB  bit is filled with zero
                   if (addition[7]==1)
                   h[7]=1;
                   else
                   h[7]=0;
               end
                   
     end
endmodule


 module booth_mult(A,B,C);
  input signed [7:0]A,B;
  output signed [15:0]C;
  wire[7:0]A1,A2,A3,A4,A5,A6,A7,A8,q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8;
  wire qout;
  
  
  multiplier_first_step n_1(8'b00000000,A,1'b0,B,A1,Q1,q0[1]);
  multiplier_first_step n_2(A1,Q1,q0[1],B,A2,Q2,q0[2]);
  multiplier_first_step n_3(A2,Q2,q0[2],B,A3,Q3,q0[3]);
  multiplier_first_step n_4(A3,Q3,q0[3],B,A4,Q4,q0[4]);
  multiplier_first_step n_5(A4,Q4,q0[4],B,A5,Q5,q0[5]);
  multiplier_first_step n_6(A5,Q5,q0[5],B,A6,Q6,q0[6]);
  multiplier_first_step n_7(A6,Q6,q0[6],B,A7,Q7,q0[7]);
  multiplier_first_step n_8(A7,Q7,q0[7],B,C[15:8],C[7:0],qout);
  
  
endmodule
