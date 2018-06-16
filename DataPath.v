
module DataPath (
input MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero, clk, reset,
input [2:0] ALUOP,
output ALUZero,
output [5:0] OPcode,
output [5:0] funct
);

wire [31:0] PCBranch, PCPlus4, input_reg_PC;
////////////////////////////////////////////////////////////////
multiplexer #(32)bfPC (.A(PCPlus4), .B(PCBranch), .sel(PCSrc), .res(input_reg_PC));// before PC

wire [31:0] input_adr_instrMem; 
//////////////// next stage from mux
PCReg PC (.CountEn(1'b1), .nextVal(input_reg_PC), .lastVal(input_adr_instrMem), .clk(clk), .reset(reset));

assign PCPlus4 = input_adr_instrMem + 3'b100;
///////////////////////////////////////////////////////////////valuate 2 output OPcode and funct
wire [31:0] instruction; 
assign OPcode = instruction[31:26];
assign funct = instruction[5:0];

instr_mem insructionMemory ( .Adr(input_adr_instrMem), .RD(instruction));
///////////////////////////////////////////////////////////////
wire [4:0] WriteAdrReg;
wire [31:0] WriteDataToRegFile, SrcA, SrcB_Rtype;
Register_file RegisterFile (.reset(reset), .Read_Reg1(instruction[25:21]), .Read_Reg2(instruction[20:16]), .WriteAdr_Reg(WriteAdrReg), .clk(clk), .WriteData(WriteDataToRegFile), .RegWriteEn(RegWrite), .Read_Data1(SrcA), .Read_Data2(SrcB_Rtype));

multiplexer #(5)AdrRegData (.A(instruction[20:16]), .B(instruction[15:11]), .sel(RegDst), .res(WriteAdrReg));
/////////////////////////////////////////////////////////////// valuate output ALUZero
wire [31:0] SrcB_Itype, SrcB; // ouput of sign Extension module

multiplexer #(32)bfALU (.A(SrcB_Rtype), .B(SrcB_Itype), .sel(ALUSrc), .res(SrcB));

wire [31:0] ALUresult;
ALU alu32 (.A(SrcA), .B(SrcB), .ALUControl(ALUOP), .Zero(ALUZero), .Y(ALUresult));

////////////////////////////////////////////////////////////////
wire [31:0] ReadDataFromMemData;
Data_mem MemoryData (.Adr(ALUresult), .WD(SrcB_Rtype), .clk(clk), .RD(ReadDataFromMemData), .WE(MemWrite), .reset(reset));
 ///////////////////////////////////////////////////////

 multiplexer #(32)pstMemData (.A(ALUresult), .B(ReadDataFromMemData), .sel(MemtoReg), .res(WriteDataToRegFile));

 ///////////////////////////////////////////////////////
 wire [31:0] OutputOfSignExtend;
 
 M_signExtend signExtend (.immd(instruction[15:0]), .signExtend(~SgnZero), .extended(OutputOfSignExtend));
 
 assign SrcB_Itype = OutputOfSignExtend;
 assign PCBranch = (OutputOfSignExtend << 2) + PCPlus4;
 
endmodule 


