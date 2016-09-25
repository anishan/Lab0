// Adder circuit
`define AND and #50
`define OR or #50
`define NOT not #50
`define XOR xor #50

module behavioralFullAdder
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin
);
    // Uses concatenation operator and built-in '+'
    assign {carryout, sum}=a+b+carryin;
endmodule

module structuralFullAdder
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin
);
    // Your adder code here
    wire AxorB;
    wire AandB;
    wire AxorBandCin;

    `XOR xorgate1(AxorB, a, b);
    `XOR xorgate2(sum, AxorB, carryin);

    `AND andgate1(AandB, a, b);
    `AND andgate2(AxorBandCin, AxorB, carryin);
    `OR orgate(carryout, AandB, AxorBandCin);

    

endmodule

module FullAdder4bit
(
    output[3:0] sum,  // 2's complement sum of a and b
    output carryout,  // Carry out of the summation of a and b
    output overflow,  // True if the calculation resulted in an overflow
    input[3:0] a,     // First operand in 2's complement format
    input[3:0] b      // Second operand in 2's complement format
);

    

    wire carryout0;
    wire carryout1;
    wire carryout2;
    

    structuralFullAdder adder0(sum[0], carryout0, a[0], b[0], 0); // carryin=0 for first bit
    //and andgate0(tempCarryout, carryout, 1);
    structuralFullAdder adder1(sum[1], carryout1, a[1], b[1], carryout0); // carryin=0 for first bit
    structuralFullAdder adder2(sum[2], carryout2, a[2], b[2], carryout1); // carryin=0 for first bit
    structuralFullAdder adder3(sum[3], carryout, a[3], b[3], carryout2); // carryin=0 for first bit

    // figure out if overflow
    wire nA3;
    wire nB3;
    wire nS3;
    wire andtop;
    wire andbottom;

    `NOT notgatea(nA3, a[3]);
    `NOT notgateb(nB3, b[3]);
    `NOT notgates(nS3, sum[3]);

    `AND andgate1(andtop, nA3, nB3, sum[3]);
    `AND andgate2(andbottom, a[3], b[3], nS3);

    `OR orgate(overflow, andtop, andbottom);

endmodule
