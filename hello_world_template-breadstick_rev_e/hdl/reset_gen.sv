//-----------------------------------------------------
// reset.v reset controller
// copied from somewhere on the Altera website
// small modifications BS, 12 July 2013

//-----------------------------------------------------

module reset_gen 
( 
	output 	logic 	rst_sync_n, 
	input 	logic 	clk, 
	input 	logic 	rst_async_n
);

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