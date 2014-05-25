/******************************************************************************/
/*                                                                            */
/*                    H E A D E R   I N F O R M A T I O N                     */
/*                                                                            */
/******************************************************************************/
/*

Project Name       : helix_4 Rev C, Breadstick
File Name          : adc_spi.sv
Prepared By        : B. Singer
Project Start      : 2013-07-25

*/ 
/******************************************************************************/
/*                                                                            */
/*                      C O P Y R I G H T   N O T I C E                       */
/*                                                                            */
/******************************************************************************/
/*
   Copyright (c) 2013, Thin Layer Embedded Pty Ltd
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice, 
      this list of conditions and the following disclaimer.
   2. Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
   POSSIBILITY OF SUCH DAMAGE.
*/

/******************************************************************************/
/*                                                                            */
/*                      I N   P L A I N   E N G L I S H                       */
/*                                                                            */
/******************************************************************************/
/*
   You can do ANYTHING you want with this code, but
   - there is no warranty and you can't hold Thin Layer Embedded liable for any
     damages.
   - you need to include: "Copyright (c) 2013, Thin Layer Embedded Pty Ltd", 
     only where you've used our code.

   Thin Layer Embedded makes every effort to comply with software license
   requirements and to acknowledge the owners of code wherever possible. If you 
   see a problem with our acknowledgements or licensing, please let us know 
   immediately so we can correct the issue: support@thin-layer-embedded.com.
*/
/******************************************************************************/
/*                                                                            */
/*                           H A R D W A R E                                  */
/*                                                                            */
/******************************************************************************/
/*
   The SPIM component in the PSOC5LP transmits max 16 bits at a time. This 16
	bits is 4 bits channel number (MSB), then 12 bits data. Max resolution is 12
	bits at the moment, no plans for higher res.
*/

/******************************************************************************/
/*                                                                            */
/*                           D E S C R I P T I O N                            */
/*                                                                            */
/******************************************************************************/
/*
   This top level entity declares ports, increments a simple counter to blink
   an LED, and has a place for you to add your own code.
   
   What do I do next?
   - Start writing code!
   - Add QSys to this template: http://bit.ly/ZSCd7a
   - Look for IP, tutorials, code & examples here: http://bit.ly/ZkYCpe
   
*/
/******************************************************************************/
/*                                                                            */
/*                         C H A N G E  H I S T O R Y                         */
/*                                                                            */
/******************************************************************************/
/*
   Date          Version Description
   ------------------------------------------------------------------------
   25 Jul 2013   1.0     Initial Release						B. Singer   
*/

/******************************************************************************/
/*                                                                            */
/*                          T O D O   L I S T                                 */
/*                                                                            */
/******************************************************************************/

/******************************************************************************/
/*                                                                            */
/*                      I N C L U D E   F I L E S                             */
/*                                                                            */
/******************************************************************************/

/******************************************************************************/
/*                                                                            */
/*                           P A R A M E T E R S                              */
/*                                                                            */
/******************************************************************************/
 
/******************************************************************************/
/*                                                                            */
/*                             T Y P E D E F S                                */
/*                                                                            */
/******************************************************************************/

/******************************************************************************/
/*                                                                            */
/*                              M O D U L E S                                 */
/*                                                                            */
/******************************************************************************/
module adc_spis 
( 
	input 	logic 			reset_n,
	input 	logic 			clk, 
	output 	logic [11:0]	readings [15:0], // 16 output registers, of 12bits
	
	// Physical pins
	input 	logic 			scs_n,
	input 	logic				sclk,
	input 	logic				sdat
);

	logic [15:0] shift_register;

	// sensitive to sclk
	always_ff @ ( posedge sclk, negedge reset_n )
	begin
		if ( reset_n == 1'b0 )
		// In reset
		begin
			shift_register = 16'd0;
		end
		else
		// Normal behaviour
		begin
			if ( scs_n == 1'b0 ) // if chip selected
			begin 
				// Shift the data in
				shift_register[0] <= sdat; 		// LSB Last
				shift_register[1] <= shift_register[0];
				shift_register[2] <= shift_register[1];
				shift_register[3] <= shift_register[2];
				shift_register[4] <= shift_register[3];
				shift_register[5] <= shift_register[4];
				shift_register[6] <= shift_register[5];
				shift_register[7] <= shift_register[6];
				shift_register[8] <= shift_register[7];
				shift_register[9] <= shift_register[8];
				shift_register[10] <= shift_register[9];
				shift_register[11] <= shift_register[10];
				shift_register[12] <= shift_register[11];
				shift_register[13] <= shift_register[12];
				shift_register[14] <= shift_register[13];
				shift_register[15] <= shift_register[14]; // MSB First
			end			
		end
	end
	
	// Now register to local clock
	always_ff @ ( posedge clk, negedge reset_n )
	begin
		if ( ~reset_n )
		// In reset
		begin
			//readings[15:0] = 0;	// Write all registers to 0
		end
		else
		// Normal behaviour
		begin
			if ( scs_n == 1'b1 ) // i.e. shifting finished
				// upper nibble are the channel number
				readings[ {shift_register[15:12]} ] <= shift_register[11:0];
		end
	end
	
endmodule // End Of Module adc_spi