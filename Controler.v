
module Controler (
input [5:0] OP,
input [5:0] func,
input Zero,
output reg MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, SgnZero,
output reg [2:0] ALUOP
);

always @*
begin
	case (OP) 
	6'b000000 : begin 
						case (func) 
						6'b100000 : begin  MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b0; RegDst = 'b1; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b000; end //add
						'd33 : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b0; RegDst = 'b1; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b000; end ///addu
						6'b100010 : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b0; RegDst = 'b1; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b001; end // sub
						'd35 : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b0; RegDst = 'b1; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b001; end //subu
						6'b100100 : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b0; RegDst = 'b1; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b010; end  //and
						'd37 : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b0; RegDst = 'b1; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b011; end  //or
						'd38 : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b0; RegDst = 'b1; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b100; end //xor
						//'d39 : begin MemtoReg = 'b1; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b0; RegDst = 'b1; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b001; end //nor
						6'b101010 : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b0; RegDst = 'b1; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b110; end // slt
						'd43 : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b0; RegDst = 'b1; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b111; end //sltu
						default : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b0; RegDst = 'b1; RegWrite = 'b0; SgnZero = 'b1; ALUOP = 'b000; end					
						endcase
		    end
	6'b100011 : begin  MemtoReg = 'b1; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b1; RegDst = 'b0; RegWrite = 'b1; SgnZero = 'b0; ALUOP = 'b000; end //LW
	6'b101011 : begin  MemtoReg = 'b1; MemWrite = 'b1; PCSrc = 'b0; ALUSrc = 'b1; RegDst = 'b0; RegWrite = 'b0; SgnZero = 'b0; ALUOP = 'b000; end //SW
	6'b000100 : begin  MemtoReg = 'b0; MemWrite = 'b0; PCSrc = Zero; ALUSrc = 'b0; RegDst = 'b0; RegWrite = 'b0; SgnZero = 'b0; ALUOP = 'b001; end //Beq
	6'b000101 : begin  MemtoReg = 'b0; MemWrite = 'b0; PCSrc = ~Zero; ALUSrc = 'b0; RegDst = 'b0; RegWrite = 'b0; SgnZero = 'b0; ALUOP = 'b001; end //bne
	6'b001100 : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b1; RegDst = 'b0; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b010; end  //andi
	'd13 : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b1; RegDst = 'b0; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b011; end  //ori
	'd14 : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b1; RegDst = 'b0; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b100; end //xori
	6'b001000 : begin  MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b1; RegDst = 'b0; RegWrite = 'b1; SgnZero = 'b0; ALUOP = 'b000; end //addi
	'd9 :  begin  MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b1; RegDst = 'b0; RegWrite = 'b1; SgnZero = 'b1; ALUOP = 'b000; end //addiu 
       'b001010: begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b1; RegDst = 'b0; RegWrite = 'b1; SgnZero = 'b0; ALUOP = 'b110; end // slti
	'd11 : begin MemtoReg = 'b0; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b1; RegDst = 'b0; RegWrite = 'b1; SgnZero = 'b0; ALUOP = 'b111; end // sltiu
	default : begin MemtoReg = 'b1; MemWrite = 'b0; PCSrc = 'b0; ALUSrc = 'b0; RegDst = 'b1; RegWrite = 'b0; SgnZero = 'b1; ALUOP = 'b001; end	
	endcase
	
 end


endmodule
////////////////////////////////////////////////////////////







