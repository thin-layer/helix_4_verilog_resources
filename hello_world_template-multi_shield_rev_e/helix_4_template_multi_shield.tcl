###############################################################################
#                                                                             #
#   TCL Script to generate a new helix_4 Multi-Shield project (Rev E)         #
#      Last updated BS 30 May 2013                                            #
#                                                                             #
###############################################################################

#load_package flow

# Create the project and overwrite any settings
# files that exist
project_new helix_4 -overwrite

# Set the device, the name of the top-level BDF,
# and the name of the top level entity
set_global_assignment -name FAMILY "Cyclone IV E"
set_global_assignment -name DEVICE EP4CE22F17C8

#smart compile ensures only changes are recompiled and speeds recompilation
set_global_assignment -name SMART_RECOMPILE ON

#using epcs
set_global_assignment -name USE_CONFIGURATION_DEVICE ON
set_global_assignment -name CYCLONEIII_CONFIGURATION_DEVICE EPCS16

#assume a standard 3V3 IO for the target system
set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "2.5 V"

#we are going to use the config pins as I/O in user mode, give us more gpio
set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA0_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA1_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_FLASH_NCE_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DCLK_AFTER_CONFIGURATION "USE AS REGULAR IO"

#add files to the project
set_global_assignment -name SYSTEMVERILOG_FILE ./hdl/helix_4_ms_top_level.sv
set_global_assignment -name SYSTEMVERILOG_FILE ./hdl/sw_debouncer.sv
set_global_assignment -name SYSTEMVERILOG_FILE ./hdl/three_input_reset_gen.sv
set_global_assignment -name SYSTEMVERILOG_FILE ./hdl/adc_spis.sv
set_global_assignment -name SDC_FILE ./helix_4.sdc
#set top level entity file
set_global_assignment -name TOP_LEVEL_ENTITY helix_4_ms_top_level

# Add other pin assignments here
#**************************************************************************
# GPIO
#**************************************************************************
#scl, sda, nceo are fixed 1V8 I/O, use open drain to interface to higher VCCIO
set_location_assignment PIN_D3 -to scl
set_location_assignment PIN_D5 -to sda

#these EPCS flash pins are not connected to any of the shields, but goes to
#   the PSOC5LP
set_location_assignment PIN_D2 -to ncso
set_location_assignment PIN_C1 -to asdo
set_location_assignment PIN_H1 -to dclk
set_location_assignment PIN_H2 -to data0

#used for connection with PSOC5LP companion MCU
set_location_assignment PIN_N1 -to usb_uart_rx
set_location_assignment PIN_N2 -to usb_uart_tx
set_location_assignment PIN_P1 -to spis_cs_n
set_location_assignment PIN_M16 -to spis_mosi
set_location_assignment PIN_P2 -to spis_miso
set_location_assignment PIN_M15 -to spis_sclk

#shield socket 2
set_location_assignment PIN_B1 -to mod2_d2
set_location_assignment PIN_C2 -to mod2_d[9]
set_location_assignment PIN_D1 -to mod2_d[10]
set_location_assignment PIN_F3 -to mod2_d[11]
set_location_assignment PIN_F2 -to mod2_d[12]
set_location_assignment PIN_F1 -to mod2_d[13]
#b2_clkin_left
set_location_assignment PIN_G5 -to nRST_2

#shield socket 1
set_location_assignment PIN_G2 -to mod1_d[0]
set_location_assignment PIN_G1 -to mod1_d[1]
set_location_assignment PIN_J1 -to mod1_d[2]
set_location_assignment PIN_J2 -to mod1_d[3]
set_location_assignment PIN_K1 -to mod1_d[4]
set_location_assignment PIN_K2 -to mod1_d[5]
set_location_assignment PIN_L1 -to mod1_d[6]
set_location_assignment PIN_L2 -to mod1_d[7]
set_location_assignment PIN_L4 -to mod1_d[8]
set_location_assignment PIN_T4 -to mod1_d[9]
set_location_assignment PIN_R4 -to mod1_d[10]
set_location_assignment PIN_N14 -to mod1_d[11]
set_location_assignment PIN_P15 -to mod1_d[12]
set_location_assignment PIN_R14 -to mod1_d[13]
#clkin_right_p
set_location_assignment PIN_P14 -to nRST_1

#shield socket 0
set_location_assignment PIN_N16 -to mod0_d[0]
set_location_assignment PIN_N15 -to mod0_d[1]
set_location_assignment PIN_P16 -to mod0_d[2]
set_location_assignment PIN_R16 -to mod0_d[3]
set_location_assignment PIN_L14 -to mod0_d[4]
set_location_assignment PIN_L13 -to mod0_d[5]
set_location_assignment PIN_L16 -to mod0_d[6]
set_location_assignment PIN_L15 -to mod0_d[7]
set_location_assignment PIN_K16 -to mod0_d[8]
set_location_assignment PIN_K15 -to mod0_d[9]
set_location_assignment PIN_F16 -to mod0_d[10]
set_location_assignment PIN_J16 -to mod0_d[11]
set_location_assignment PIN_J15 -to mod0_d[12]
set_location_assignment PIN_J14 -to mod0_d[13]
#clkin_right_n
set_location_assignment PIN_J13 -to nRST_0

#the TXS0108 buffers can tell which side of the bus is driving, making them almost
#   transparent to the application, but they prefer strong current drive
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[0]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[1]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[2]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[3]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[4]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[5]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[6]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[7]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[8]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[9]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[10]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[11]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[12]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod0_d[13]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to nRST_0

set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[0]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[1]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[2]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[3]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[4]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[5]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[6]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[7]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[8]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[9]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[10]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[11]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[12]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod1_d[13]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to nRST_1

set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod2_d2
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod2_d[9]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod2_d[10]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod2_d[11]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod2_d[12]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to mod2_d[13]

set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to nRST_2
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to scl
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to sda

#50Mhz solid state oscillator clock source
set_location_assignment PIN_M2 -to local_osc

#io reference for the gpio
#these are pins that are NOT vccio1,2 or 5, which are selectable
#use STRATIX_DEVICE_IO_STANDARD assignment for other gpio, or bank by bank as below 
set_instance_assignment -name IO_STANDARD "1.8 V" -to scl
set_instance_assignment -name IO_STANDARD "1.8 V" -to sda
#nCEO
set_instance_assignment -name IO_STANDARD "1.8 V" -to mod0_d[10]
#end GPIO

#*************************************************************************
# DDR2 DRAM, you can remove this section to leave ddr2 OUT of your design.
#*************************************************************************
set_location_assignment PIN_E11 -to dram_we_n
set_location_assignment PIN_C3 -to dram_ras_n
set_location_assignment PIN_A3 -to dram_odt
set_location_assignment PIN_C8 -to dram_dqs[0]
set_location_assignment PIN_A6 -to dram_dqs[1]
set_location_assignment PIN_A10 -to dram_dq[0]
set_location_assignment PIN_D15 -to dram_addr[11]
set_location_assignment PIN_D12 -to dram_addr[10]
set_location_assignment PIN_G15 -to dram_addr[9]
set_location_assignment PIN_F15 -to dram_addr[8]
set_location_assignment PIN_A15 -to dram_addr[7]
set_location_assignment PIN_C16 -to dram_addr[6]
set_location_assignment PIN_E8 -to dram_addr[5]
set_location_assignment PIN_D16 -to dram_addr[4]
set_location_assignment PIN_C14 -to dram_addr[3]
set_location_assignment PIN_B16 -to dram_addr[2]
set_location_assignment PIN_F13 -to dram_addr[1]
set_location_assignment PIN_C15 -to dram_addr[0]
set_location_assignment PIN_D6 -to dram_ba[1]
set_location_assignment PIN_D11 -to dram_ba[0]
set_location_assignment PIN_B3 -to dram_cas_n
set_location_assignment PIN_A12 -to dram_cke
set_location_assignment PIN_B14 -to dram_clk
set_location_assignment PIN_A14 -to dram_clk_n
set_location_assignment PIN_B4 -to dram_cs_n
set_location_assignment PIN_A4 -to dram_dm[1]
set_location_assignment PIN_D9 -to dram_dm[0]
set_location_assignment PIN_B5 -to dram_dq[15]
set_location_assignment PIN_E6 -to dram_dq[14]
set_location_assignment PIN_A7 -to dram_dq[13]
set_location_assignment PIN_E7 -to dram_dq[12]
set_location_assignment PIN_D8 -to dram_dq[11]
set_location_assignment PIN_B6 -to dram_dq[10]
set_location_assignment PIN_B7 -to dram_dq[9]
set_location_assignment PIN_A5 -to dram_dq[8]
set_location_assignment PIN_B10 -to dram_dq[7]
set_location_assignment PIN_C9 -to dram_dq[6]
set_location_assignment PIN_A11 -to dram_dq[5]
set_location_assignment PIN_B12 -to dram_dq[4]
set_location_assignment PIN_B11 -to dram_dq[3]
set_location_assignment PIN_B13 -to dram_dq[2]
set_location_assignment PIN_D14 -to dram_dq[1]
set_location_assignment PIN_G16 -to dram_addr[12]
#io reference

set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_ba[1]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[0]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[1]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[2]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[4]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[6]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[8]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[9]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[11]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_we_n
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[0]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[1]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[2]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[3]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[4]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[5]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[6]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[7]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dm[0]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_clk_n
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_clk
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_cke
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_ba[0]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[3]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[5]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[7]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[10]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_addr[12]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_ras_n
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_odt
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dqs[0]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dqs[1]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[8]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[9]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[10]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[11]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[12]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[13]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[14]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dq[15]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_dm[1]
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_cs_n
set_instance_assignment -name IO_STANDARD "SSTL-18 CLASS I" -to dram_cas_n
#special constraints for ddr2
#end DDR2 DRAM

#**************************************************************************
# Async SRAM, you can remove this section to leave SRAM out of your design.
#**************************************************************************
set_location_assignment PIN_M8 -to sram_addr[17]
set_location_assignment PIN_P8 -to sram_addr[16]
set_location_assignment PIN_T13 -to sram_addr[15]
set_location_assignment PIN_L8 -to sram_addr[14]
set_location_assignment PIN_T15 -to sram_addr[13]
set_location_assignment PIN_P11 -to sram_addr[12]
set_location_assignment PIN_R13 -to sram_addr[11]
set_location_assignment PIN_T14 -to sram_addr[10]
set_location_assignment PIN_N12 -to sram_addr[9]
set_location_assignment PIN_N11 -to sram_addr[8]
set_location_assignment PIN_R10 -to sram_addr[7]
set_location_assignment PIN_P6 -to sram_addr[6]
set_location_assignment PIN_N5 -to sram_addr[5]
set_location_assignment PIN_T3 -to sram_addr[4]
set_location_assignment PIN_N3 -to sram_addr[3]
set_location_assignment PIN_T5 -to sram_addr[2]
set_location_assignment PIN_R3 -to sram_addr[1]
set_location_assignment PIN_T2 -to sram_addr[0]
set_location_assignment PIN_M10 -to sram_dq[15]
set_location_assignment PIN_P9 -to sram_dq[14]
set_location_assignment PIN_N9 -to sram_dq[13]
set_location_assignment PIN_N8 -to sram_dq[12]
set_location_assignment PIN_M7 -to sram_dq[11]
set_location_assignment PIN_N6 -to sram_dq[10]
set_location_assignment PIN_R1 -to sram_dq[9]
set_location_assignment PIN_K5 -to sram_dq[8]
set_location_assignment PIN_R12 -to sram_dq[7]
set_location_assignment PIN_R11 -to sram_dq[6]
set_location_assignment PIN_T11 -to sram_dq[5]
set_location_assignment PIN_T10 -to sram_dq[4]
set_location_assignment PIN_R7 -to sram_dq[3]
set_location_assignment PIN_R6 -to sram_dq[2]
set_location_assignment PIN_T7 -to sram_dq[1]
set_location_assignment PIN_T6 -to sram_dq[0]
set_location_assignment PIN_M6 -to sram_lb
set_location_assignment PIN_P3 -to sram_oe
set_location_assignment PIN_L7 -to sram_ub
set_location_assignment PIN_T12 -to sram_we
set_location_assignment PIN_R5 -to sram_ce
#io reference
#b3 and b4, selectable with VCCIO_34, which is there to set VCCIO on GPIO_23,24,27,28.
#end SRAM


