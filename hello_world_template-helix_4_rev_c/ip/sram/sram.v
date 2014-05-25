module	sram
(
	//	global clk/reset
	input wire 		clk,
	input wire 		reset_n,
	// avalon slave
	input wire 								s_chipselect_n,
	input wire 		[(DATA_BITS/8-1):0] 	s_byteenable_n,
	input wire 								s_write_n,
	input wire 								s_read_n,
	input wire 		[(ADDR_BITS-1):0] 		s_address,
	input wire 		[(DATA_BITS-1):0] 		s_writedata,
	output wire 	[(DATA_BITS-1):0] 		s_readdata,
	
	// SRAM interface
	inout wire		[(DATA_BITS-1):0] 		SRAM_DQ,
	output wire		[(ADDR_BITS-1):0] 		SRAM_ADDR,
	output wire 	SRAM_UB_n,
	output wire 	SRAM_LB_n,
	output wire 	SRAM_WE_n,
	output wire 	SRAM_CE_n,
	output wire 	SRAM_OE_n
);

	parameter DATA_BITS		= 16;
	parameter ADDR_BITS		= 18;

	// if chip_select AND write, then output to device
	assign	SRAM_DQ 				=	( ~s_chipselect_n & ~s_write_n ) ? s_writedata : 'hZ;
	assign	s_readdata 				=	SRAM_DQ;
	assign	SRAM_ADDR				=	s_address;
	assign	SRAM_WE_n				=	s_write_n;
	assign	SRAM_OE_n				=	s_read_n;
	assign	SRAM_CE_n				=	s_chipselect_n;
	assign	{SRAM_UB_n,SRAM_LB_n}	=	s_byteenable_n;

endmodule


/* original
module	sram(
	//	global clk/reset
	clk,
	reset_n,
	// avalon slave
	s_chipselect_n,
	s_byteenable_n,
	s_write_n,
	s_read_n,
	s_address,
	s_writedata,
	s_readdata,
	
	// SRAM interface
	SRAM_DQ,
	SRAM_ADDR,
	SRAM_UB_n,
	SRAM_LB_n,
	SRAM_WE_n,
	SRAM_CE_n,
	SRAM_OE_n
);

parameter DATA_BITS		= 16;
parameter ADDR_BITS		= 18;

input						clk;
input						reset_n;

input						s_chipselect_n;
input	[(DATA_BITS/8-1):0]	s_byteenable_n;
input						s_write_n;
input						s_read_n;
input	[(ADDR_BITS-1):0]	s_address;
input	[(DATA_BITS-1):0]	s_writedata;
output	[(DATA_BITS-1):0]	s_readdata;

output						SRAM_CE_n;
output						SRAM_OE_n;
output				 		SRAM_LB_n;
output				 		SRAM_UB_n;
output						SRAM_WE_n;
output	[(ADDR_BITS-1):0]	SRAM_ADDR;
inout	[(DATA_BITS-1):0]	SRAM_DQ;

assign	SRAM_DQ 				=	SRAM_WE_n ? 'hz : s_writedata;
assign	s_readdata				=	SRAM_DQ;
assign	SRAM_ADDR				=	s_address;
assign	SRAM_WE_n				=	s_write_n;
assign	SRAM_OE_n				=	s_read_n;
assign	SRAM_CE_n				=	s_chipselect_n;
assign	{SRAM_UB_n,SRAM_LB_n}	=	s_byteenable_n;

endmodule*/