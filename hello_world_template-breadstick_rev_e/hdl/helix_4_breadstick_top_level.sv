/******************************************************************************/
/*                                                                            */
/*                    H E A D E R   I N F O R M A T I O N                     */
/*                                                                            */
/******************************************************************************/
/*

Project Name       : helix_4 Rev C, Breadstick
File Name          : helix_4_breadstick_top_level.sv
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
   This is the new project template for the helix_4 Breadstick. 
   More here:

   - helix_4 Breadstick support: http://bit.ly/ZkOJr9
   - helix_4 FPGA Module support: http://bit.ly/XvFo2f

   The FPGA is a Cyclone IV EP4CE10F17C8N, with a 50MHz oscillator, SRAM and an 
	EPCS16 Serial Flash.
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
/*
	1) Convert to Breadstick B pinout
	2) Add DAC functionality
	3) Add control through I2C Master Nios template code

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

module helix_4_breadstick_top_level (
	// EPCS pins, do not modify
	inout 	logic 			ncso, 	 	// EPCS pin nCSO
	inout    logic				asdo, 	 	// EPCS pin ASDO
	inout    logic				dclk,    	// EPCS pin DCLK
	inout    logic				data0,  		// EPCS pin DATA0
		
	// Shield socket 0	
	inout 	logic [13:0] 	mod0_d,  
	inout 	logic 			nRST_0, 
	
	// GPIO
	inout		logic [53:0]	gpio,
	
	// I2C Open Drain
	inout 	logic 			sda, 
	inout 	logic 			scl, 		
	
	// 50MHz Local Oscillator
	input 	logic  			local_osc, 
	
	// External clock inputs (input only)
	input 	logic  			clkin_right, 			
	input 	logic 			clkin_left_p, 	
	input 	logic 	 		clkin_left_n,
	
	// SRAM interface, do not modify
	output	logic [17:0]	sram_addr,
	output	logic 			sram_ce,
	inout 	logic [15:0]	sram_dq,
	output	logic          sram_lb,
	output	logic          sram_oe,
	output	logic          sram_ub,
	output	logic          sram_we

);
	/***************************** Analog Pins ********************************/
	logic [11:0]		analog[15:0]; // Gpio analog voltages 12-bit

	// This module captures the ADC data from the PSOC5 Arm-CM3 Companion Chip
	// Todo, expand this to be bidirectional with DAC functionality
	//    Default configuration is ADC converting 14 channels @ 100kHz.
	//    For DAC functionality and more control, use Nios to configure the
	//    ADC/DAC peripheral over I2C. 
	adc_spis adc_master
	(
		.reset_n		( reset_n ),
		.clk			( local_osc ),
		.readings	( analog ),
		.scs_n		( gpio[21] ),	// Default, can be changed
		.sdat			( clkin_left_n ),	// Default, can be changed
		.sclk			( clkin_left_p )	// Default, can be changed	
	);	
	
	
	/**************** Reset controller ***************************************/
	// LOOK HERE: YOU need to define your reset source. Currently no reset is defined!.
	// There are 3 reset sources. Why three? Because you may have one from each shield socket
	logic reset_n;
	
	reset_gen reset_controller
	(
		.clk				( local_osc ),	
		.rst_async_n	( 1'b1 ),		// input
		.rst_sync_n		( reset_n )  	// output
	);
	
	
	/****************** Blink the LED ****************************************/
	logic [24:0] counter;
	
	// Increment the counter
	always_ff @( posedge local_osc )
	begin	
		if ( reset_n == 0 )
		begin
			counter <= 0;
		end
		else
		begin
			counter = counter + 1;
		end
	end
	

	/********************** Are you going to use Nios2 and QSys? **************
	 * Answer: 															      *
	 *    NO, then leave this code the way it is.                             *
	 *    YES, then comment out/remove this line:	   						  */
	assign data0 = counter[24]; 	
	/*    Now uncomment the below secion by deleting the lines as directed:   */	
	
	/* (delete this line to add Nios2 and QSys)
	// These lines necessary for dual use of EPCS pins
	logic dclk_qsys, asdo_qsys;	
	
	// data0 is an EPCS input, or LED out when EPCS inactive
	assign data0 = ncso ? counter[24] : 1'bZ; 
	
	// dclk is an EPCS output, or GPIO when EPCS inactive
	assign dclk = ncso ? 1'bZ : dclk_qsys; 
	
	// adso is an EPCS output, or GPIO when EPCS inactive
	assign asdo = ncso ? 1'bZ : asdo_qsys; 
			
	// wiring for USB Uart
	logic usb_uart_tx, usb_uart_rx;	
	assign gpio[20] = usb_uart_tx;
	assign usb_uart_rx = gpio[19];
	
	// Insantiate QSys
	qsys_basic system	
	(
		// Reset and Clock In
		// Reset and Clock In
		.clk_50_clk_in_reset_reset_n								( reset_n	),
		.clk_50_clk_in_clk											( local_osc	),	
		
		// PIO - Peripheral IO Pins	
		.mod0_an0_external_connection_export					( analog[10] ),
		.mod0_an1_external_connection_export					( analog[11] ),
		.mod0_an2_external_connection_export					( analog[12] ),
		.mod0_an3_external_connection_export					( analog[13] ),
		
		.an_0_external_connection_export							( analog[0] ),
		.an_1_external_connection_export							( analog[1] ),
		.an_2_external_connection_export							( analog[2] ),
		.an_3_external_connection_export							( analog[3] ),
		.an_4_external_connection_export							( analog[4] ),
		.an_5_external_connection_export							( analog[5] ),
		.an_6_external_connection_export							( analog[6] ),
		.an_7_external_connection_export							( analog[7] ),
		.an_8_external_connection_export							( analog[8] ),
		.an_9_external_connection_export							( analog[9] ),
		
		// EPCS16 Serial Flash
		.epcs_flash_controller_0_external_sce              ( ncso ),		
		.epcs_flash_controller_0_external_dclk             ( dclk_qsys ), 		
		.epcs_flash_controller_0_external_sdo              ( asdo_qsys ),
		.epcs_flash_controller_0_external_data0            ( data0 ),
		
		// For USB Uart
		.uart_0_external_connection_rxd                   ( usb_uart_rx ),                  
		.uart_0_external_connection_txd                   ( usb_uart_tx ),                  
		
		// 4Mbit Asynchronous SRAM
		.sram_0_conduit_end_DQ										( sram_dq ),
		.sram_0_conduit_end_ADDR									( sram_addr	),
		.sram_0_conduit_end_UB_n									( sram_ub ),	
		.sram_0_conduit_end_LB_n									( sram_lb ),
		.sram_0_conduit_end_WE_n									( sram_we ),
		.sram_0_conduit_end_CE_n									( sram_ce ),
		.sram_0_conduit_end_OE_n									( sram_oe )
	);
	(delete this line to add Nios2 and QSys) */
	
	/**************** Add your own code below ********************************/
	

endmodule // End Of Module helix_4_breadstick_top_level