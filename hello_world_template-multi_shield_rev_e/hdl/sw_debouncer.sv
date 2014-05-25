module debouncer 
(
	input wire noisy_input,
	input wire clk_1KHz,
	output logic debounced_output
);

	reg [7:0] debounce_shifter;

	//reg: wait for stable
	always @ ( posedge clk_1KHz ) 
	begin
		// Shift left, bring new input into lsb
		debounce_shifter[7:0] <= { debounce_shifter[6:0], noisy_input }; //shift register
		
		// Test result
		if ( debounce_shifter[7:0] == 8'b00000000 )
		begin	
			debounced_output <= 1'b0;
		end
		else if (debounce_shifter[7:0] == 8'b11111111 )
		begin		
			debounced_output <= 1'b1;
		end		
	end

endmodule