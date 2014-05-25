//-----------------------------------------------------
// reset.v reset controller
// last modified 12/07/2012
// copied from somewhere on the Altera website
//-----------------------------------------------------

module three_input_reset_gen 
( 
	output 	logic 	rst_sync_n, 
	input 	logic 	clk, 
	input 	logic 	rst_0_async_n,
	input 	logic 	rst_1_async_n,
	input 	logic 	rst_2_async_n
);
	// any of the three inputs can trigger a reset
	assign rst_async_n = ( rst_0_async_n & rst_1_async_n & rst_2_async_n );
	logic rst_s1;
	logic rst_s2;

	always_ff @ ( posedge clk, negedge rst_async_n )
	begin
		if ( ~rst_async_n ) 
		begin 
			rst_s1 <= 1'b0;
			rst_s2 <= 1'b0;
		end 
	
		else 
	
		begin
			rst_s1 <= 1'b1;
			rst_s2 <= rst_s1;
		end 
	end
	
	assign rst_sync_n = rst_s2; 
	
endmodule 	