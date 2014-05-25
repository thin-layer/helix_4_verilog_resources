/******************************************************
 * helix_4 add a QSys	to your project				*
 * Cut and paste this code into your top level entity *
 * 																	*
 * last modified by BS, 02 May 2013							*
 ******************************************************/

// ADD this code to the end of your top level entity:
	
	qsys_basic system	
	(
		// Reset and Clock In
		.clk_50_clk_in_reset_reset_n								( reset_n	),
		.clk_50_clk_in_clk											( local_osc	),	
		
		// PIO - Peripheral IO Pins
		.pio_0_external_connection_export						( 8'bZ ),
		
		// I2C Master
		.oc_i2c_master_0_global_signals_export_scl_pad_io	( scl ),	
		.oc_i2c_master_0_global_signals_export_sda_pad_io	( sda ),	
		
		// EPCS16 Serial Flash
		.epcs_flash_controller_0_external_sce              ( ncso ),		
		.epcs_flash_controller_0_external_dclk             ( dclk_qsys ), 		
		.epcs_flash_controller_0_external_sdo              ( asdo_qsys ),
		.epcs_flash_controller_0_external_data0            ( data0 ),
				
		// 512Mbit DDR2 DRAM 
		/* Note: The DRAM is not included in the default build. It adds considerable
		 * size and time to the compilation. You can easily enable it, 'ticking' it in
		 * Qsys, and uncomment these lines. 
		.altmemddr_0_external_connection_local_refresh_ack	(),
		.altmemddr_0_external_connection_local_init_done	(),
		.altmemddr_0_external_connection_reset_phy_clk_n	(),
		.altmemddr_0_memory_mem_odt								( dram_odt ),	
		.altmemddr_0_memory_mem_clk								( dram_clk	),
		.altmemddr_0_memory_mem_clk_n								( dram_clk_n ),	
		.altmemddr_0_memory_mem_cs_n								( dram_cs_n	),		
		.altmemddr_0_memory_mem_cke								( dram_cke ),	
		.altmemddr_0_memory_mem_addr								( dram_addr	),
		.altmemddr_0_memory_mem_ba									( dram_ba ),
		.altmemddr_0_memory_mem_ras_n								( dram_ras_n ),
		.altmemddr_0_memory_mem_cas_n								( dram_cas_n ),
		.altmemddr_0_memory_mem_we_n								( dram_we_n	),
		.altmemddr_0_memory_mem_dq									( dram_dq ),
		.altmemddr_0_memory_mem_dqs								( dram_dqs ),
		.altmemddr_0_memory_mem_dm									( dram_dm ),	*/
		
		// 4Mbit Asynchronous SRAM
		.sram_0_conduit_end_DQ										( sram_dq ),
		.sram_0_conduit_end_ADDR									( sram_addr	),
		.sram_0_conduit_end_UB_n									( sram_ub ),	
		.sram_0_conduit_end_LB_n									( sram_lb ),
		.sram_0_conduit_end_WE_n									( sram_we ),
		.sram_0_conduit_end_CE_n									( sram_ce ),
		.sram_0_conduit_end_OE_n									( sram_oe )
	);