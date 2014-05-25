/******************************************************************************/
/*                                                                            */
/*                    H E A D E R   I N F O R M A T I O N                     */
/*                                                                            */
/******************************************************************************/
/*

Project Name       : helix_4 Rev C, Multi-Shield Rev D, New Project Template
File Name          : helix_4_ms_top_level.sv
Prepared By        : B. Singer
Project Start      : 2013-03-15

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
   This is the new project template for the helix_4 Multi-Shield Rev D. 
   More here:

   - helix_4 Multi-Shield support: http://bit.ly/ZkOJr9
   - helix_4 FPGA Module support: http://bit.ly/XvFo2f

   The FPGA is a Cyclone IV EP4CE22F17C8N, with a 50MHz oscillator, SRAM and 
   DRAM, and an EPCS16 Serial Flash.
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
   DD MMM YYYY   0.0     Project Established						Your Name
   
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

module helix_4_ms_top_level (
	// EPCS pins, do not modify
	inout 	logic 			ncso, 	 	// EPCS pin nCSO
	inout    logic			asdo, 	 	// EPCS pin ASDO
	inout    logic			dclk,    	// EPCS pin DCLK
	inout    logic			data0,  	// EPCS pin DATA0
	
	// Shield socket 2
	inout    logic 			mod2_d2,  // mod2_d is not a contiguous bus
	inout 	logic [13:9] 	mod2_d, // todo: test
	inout 	logic 			nRST_2, 
	// Shield socket 1
	inout 	logic [13:0] 	mod1_d, 
	inout 	logic 			nRST_1, 
	// Shield socket 0
	inout 	logic [13:0] 	mod0_d,  
	inout 	logic 			nRST_0, 
	
	// I2C Open Drain
	inout 	logic 			sda, 
	inout 	logic 			scl, 		
	
	// 50MHz Local Oscillator
	input 	logic  			local_osc, 
	
	// SRAM interface, do not modify
	output	logic [17:0]	sram_addr,
	output	logic 			sram_ce,
	inout 	logic [15:0]	sram_dq,
	output	logic          sram_lb,
	output	logic          sram_oe,
	output	logic          sram_ub,
	output	logic          sram_we,	
	
	/* Commented out for simplicity. To use DRAM uncomment these lines, and
	 *    enable the DDR2 Controller in QSYS 
	// DRAM interface, do not modify	
	output 	logic [12:0] 	dram_addr,
	output 	logic [1:0]    dram_ba,
	output 	logic          dram_cas_n,
	output 	logic          dram_cke,
	inout  	logic      		dram_clk_n,
	inout  	logic        	dram_clk,
	output 	logic          dram_cs_n,
	output 	logic [1:0]    dram_dm,
	inout  	logic [15:0]   dram_dq,
	inout  	logic [1:0]    dram_dqs,
	output 	logic          dram_odt,
	output 	logic          dram_ras_n,
	output 	logic          dram_we_n*/
	
	// Pins used for commuincation with PSOC5LP Compaion MCU
	// USB UART @ 115200 Baud
	output	logic				usb_uart_tx,
	input		logic				usb_uart_rx,
	// SPI Channel for ADC, at 12MHz 
	input		logic				spis_cs_n,
	input		logic				spis_mosi,
	input		logic				spis_sclk	
);


	/**************** Reset controller ***************************************/
	// LOOK HERE: YOU need to define your reset source. Currently no reset is defined!.
	// There are 3 reset sources. Why three? Because you may have one from each shield socket
	logic reset_n;
	three_input_reset_gen reset_controller
	(
		.clk( local_osc ),			// using the local module oscillator 
		.rst_0_async_n( 1'b1 ),		// NO RESET INPUT SPECIFIED - add this when you are ready
		.rst_1_async_n( 1'b1 ),		// NO RESET INPUT SPECIFIED - add this when you are ready
		.rst_2_async_n( 1'b1 ),		// NO RESET INPUT SPECIFIED - add this when you are ready
		.rst_sync_n( reset_n )		// output - use 'reset_n' as main reset in your code
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
	
	
	/****************** Debounce our Buttons **********************************/
	// Debounce the BUT0 button
	logic debounced_dclk;
	debouncer dclk_debouncer
	(
		.noisy_input 			( dclk ),
		.clk_1KHz				( counter[12] ),
		.debounced_output		( debounced_dclk )
	);
	
	// Debounce the BUT1 button
	logic debounced_asdo;
	debouncer asdo_debouncer
	(
		.noisy_input 			( asdo ),
		.clk_1KHz				( counter[12] ),
		.debounced_output		( debounced_asdo )
	);
	
	
	/***************************** Analog Pins ********************************/
	// Analog Pin Value Registers
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
		.scs_n		( spis_cs_n ),	// Default, can be changed
		.sdat			( spis_mosi ),	// Default, can be changed
		.sclk			( spis_sclk )	// Default, can be changed	
	);	
	
	
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
	
	// Insantiate QSys
	qsys_basic system	
	(
		// Reset and Clock In
		// Reset and Clock In
		.clk_50_clk_in_reset_reset_n								( reset_n	),
		.clk_50_clk_in_clk											( local_osc	),	
		
		// PIO - Peripheral IO Pins	
		.mod0_an0_external_connection_export					( analog[0] ),
		.mod0_an1_external_connection_export					( analog[1] ),
		.mod0_an2_external_connection_export					( analog[2] ),
		.mod0_an3_external_connection_export					( analog[3] ),
		
		.mod1_an0_external_connection_export					( analog[4] ),
		.mod1_an1_external_connection_export					( analog[5] ),
		.mod1_an2_external_connection_export					( analog[6] ),
		.mod1_an3_external_connection_export					( analog[7] ),

		.mod2_an0_external_connection_export					( analog[8] ),
		.mod2_an1_external_connection_export					( analog[9] ),
		.mod2_an2_external_connection_export					( analog[10] ),
		.mod2_an3_external_connection_export					( analog[11] ),

		.usb_vin_external_connection_export						( analog[12] ),
		
		// EPCS16 Serial Flash
		.epcs_flash_controller_0_external_sce              ( ncso ),		
		.epcs_flash_controller_0_external_dclk             ( dclk_qsys ), 		
		.epcs_flash_controller_0_external_sdo              ( asdo_qsys ),
		.epcs_flash_controller_0_external_data0            ( data0 ),
		
		// For USB Uart
		.uart_0_external_connection_rxd                   ( usb_uart_rx ),                  
		.uart_0_external_connection_txd                   ( usb_uart_tx ),                  		
		
		// I2C Master
		.oc_i2c_master_0_global_signals_export_scl_pad_io	( scl ),	
		.oc_i2c_master_0_global_signals_export_sda_pad_io	( sda ),
		
		// 512Mbit DDR2 DRAM 
		// Note: The DRAM is not included in the default build. It adds considerable
		// size and time to the compilation. You can easily enable it, 'ticking' it in
		// Qsys, and uncomment these lines. 
		//.altmemddr_0_external_connection_local_refresh_ack	(),
		//.altmemddr_0_external_connection_local_init_done	(),
		//.altmemddr_0_external_connection_reset_phy_clk_n	(),
		//.altmemddr_0_memory_mem_odt								( dram_odt ),	
		//.altmemddr_0_memory_mem_clk								( dram_clk	),
		//.altmemddr_0_memory_mem_clk_n								( dram_clk_n ),	
		//.altmemddr_0_memory_mem_cs_n								( dram_cs_n	),		
		//.altmemddr_0_memory_mem_cke								( dram_cke ),	
		//.altmemddr_0_memory_mem_addr								( dram_addr	),
		//.altmemddr_0_memory_mem_ba									( dram_ba ),
		//.altmemddr_0_memory_mem_ras_n								( dram_ras_n ),
		//.altmemddr_0_memory_mem_cas_n								( dram_cas_n ),
		//.altmemddr_0_memory_mem_we_n								( dram_we_n	),
		//.altmemddr_0_memory_mem_dq									( dram_dq ),
		//.altmemddr_0_memory_mem_dqs								( dram_dqs ),
		//.altmemddr_0_memory_mem_dm									( dram_dm ),	
		
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


endmodule // End Of Module counter