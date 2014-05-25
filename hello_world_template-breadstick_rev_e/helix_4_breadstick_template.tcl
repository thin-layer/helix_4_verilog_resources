###############################################################################
#                                                                             #
#   TCL Script to generate a new helix_4 FPGA Module project (Rev C)          #
#      Last updated BS 01 May 2013                                            #
#                                                                             #
###############################################################################

# Thin Layer Embedded
# TCL script for a new helix_4 project
# Last modified BS 11 Apr 2013 - transition from Rev B -> Rev C
# NOTE: this script assumes that dram is fitted

#load_package flow

# Create the project and overwrite any settings
# files that exist
project_new helix_4 -overwrite

# Set the device, the name of the top-level BDF,
# and the name of the top level entity
set_global_assignment -name FAMILY "Cyclone IV E"
set_global_assignment -name DEVICE EP4CE10F17C9L

#smart compile ensures only changes are recompiled and speeds recompilation
set_global_assignment -name SMART_RECOMPILE ON

#using epcs
set_global_assignment -name USE_CONFIGURATION_DEVICE ON
set_global_assignment -name CYCLONEIII_CONFIGURATION_DEVICE EPCS16

#assume a standard 3V3 IO for the target system
set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVCMOS"

#we are going to use the config pins as I/O in user mode, give us more gpio
set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA0_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA1_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_FLASH_NCE_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DCLK_AFTER_CONFIGURATION "USE AS REGULAR IO"

#add files to the project
set_global_assignment -name SYSTEMVERILOG_FILE ./hdl/helix_4_breadstick_top_level.sv
set_global_assignment -name SYSTEMVERILOG_FILE ./hdl/reset_gen.sv
set_global_assignment -name SYSTEMVERILOG_FILE ./hdl/adc_spis.sv
set_global_assignment -name SDC_FILE ./helix_4_low_power.sdc
#set top level entity file
set_global_assignment -name TOP_LEVEL_ENTITY helix_4_breadstick_top_level

# Add other pin assignments here
#**************************************************************************
# GPIO
#**************************************************************************
#scl, sda, nceo are bank 6, referenced to 1V8 if DRAM in system, use open drain to interface to higher VCCIO
set_location_assignment PIN_D3 -to scl
set_location_assignment PIN_D5 -to sda
#programming pins with dual usage
set_location_assignment PIN_C1 -to asdo
set_location_assignment PIN_H1 -to dclk
set_location_assignment PIN_H2 -to data0
#bank 1, ref VCCIO1
set_location_assignment PIN_D2 -to ncso
set_location_assignment PIN_B1 -to gpio[0]
set_location_assignment PIN_C2 -to gpio[1]
#set_location_assignment PIN_C1 -to gpio[2]
set_location_assignment PIN_D1 -to gpio[3]
set_location_assignment PIN_G5 -to gpio[4]
set_location_assignment PIN_F3 -to gpio[5]
set_location_assignment PIN_F2 -to gpio[6]
set_location_assignment PIN_F1 -to gpio[7]
#set_location_assignment PIN_H2 -to gpio[8]
#set_location_assignment PIN_H1 -to gpio[9]
set_location_assignment PIN_G1 -to gpio[10]
set_location_assignment PIN_G2 -to gpio[11]
#bank 2, ref VCCIO2
set_location_assignment PIN_J2 -to gpio[12]
set_location_assignment PIN_J1 -to gpio[13]
set_location_assignment PIN_K2 -to gpio[14]
set_location_assignment PIN_K1 -to gpio[15]
set_location_assignment PIN_L1 -to gpio[16]
set_location_assignment PIN_L2 -to gpio[17]
set_location_assignment PIN_L4 -to gpio[18]
set_location_assignment PIN_N1 -to gpio[19]
set_location_assignment PIN_N2 -to gpio[20]
set_location_assignment PIN_P1 -to gpio[21]

# Note discontinuity in naming, because shield
#    pins are in the middle of GPIO naming convention
set_location_assignment PIN_K16 -to gpio[37]
set_location_assignment PIN_K15 -to gpio[38]
#bank 6, ref 1V8 if DRAM, or VCCIO_678 otherwise
set_location_assignment PIN_F16 -to gpio[39]
#bank 5 continued
set_location_assignment PIN_J16 -to gpio[40]
set_location_assignment PIN_J15 -to gpio[41]
set_location_assignment PIN_J14 -to gpio[42]
set_location_assignment PIN_J13 -to gpio[43]



# Shield Socket IO
set_location_assignment PIN_P2 -to nRST_0
set_location_assignment PIN_T4 -to mod0_d[0]
set_location_assignment PIN_R4 -to mod0_d[1]
#bank 3, 4, ref 2V5 ONLY - these are the PLL_CLKOUT pins
set_location_assignment PIN_N14 -to mod0_d[2]
set_location_assignment PIN_P15 -to mod0_d[3]
set_location_assignment PIN_R14 -to mod0_d[4]
set_location_assignment PIN_P14 -to mod0_d[5]
#bank 5, ref VCCIO5
set_location_assignment PIN_N15 -to mod0_d[6]
set_location_assignment PIN_N16 -to mod0_d[7]
set_location_assignment PIN_R16 -to mod0_d[8]
set_location_assignment PIN_P16 -to mod0_d[9]
set_location_assignment PIN_L13 -to mod0_d[10]
set_location_assignment PIN_L14 -to mod0_d[11]
set_location_assignment PIN_L16 -to mod0_d[12]
set_location_assignment PIN_L15 -to mod0_d[13]

set_location_assignment PIN_M2 -to local_osc
#todo rename for PSOC connection
set_location_assignment PIN_M1 -to clkin_right
set_location_assignment PIN_M15 -to clkin_left_p
set_location_assignment PIN_M16 -to clkin_left_n
#end GPIO

#*************************************************************************
# DDR2 DRAM, you can remove this section to leave ddr2 OUT of your design.
#*************************************************************************
#todo: remap the DRAM to GPIO
set_location_assignment PIN_E11 -to gpio[52]
#set_location_assignment PIN_C3 -to dram_ras_n
set_location_assignment PIN_A3 -to gpio[53]
#set_location_assignment PIN_C8 -to dram_dqs[0]
#set_location_assignment PIN_A6 -to dram_dqs[1]
#set_location_assignment PIN_A10 -to dram_dq[0]
set_location_assignment PIN_D15 -to gpio[48]
#set_location_assignment PIN_D12 -to dram_addr[10]
set_location_assignment PIN_G15 -to gpio[45]
set_location_assignment PIN_F15 -to gpio[46]
#set_location_assignment PIN_A15 -to dram_addr[7]
set_location_assignment PIN_C16 -to gpio[49]
#set_location_assignment PIN_E8 -to dram_addr[5]
set_location_assignment PIN_D16 -to gpio[47]
#set_location_assignment PIN_C14 -to dram_addr[3]
set_location_assignment PIN_B16 -to gpio[50]
#set_location_assignment PIN_F13 -to dram_addr[1]
#set_location_assignment PIN_C15 -to dram_addr[0]
#set_location_assignment PIN_E10 -to dram_ba[2]
set_location_assignment PIN_D6 -to gpio[44]
#set_location_assignment PIN_D11 -to dram_ba[0]
#set_location_assignment PIN_B3 -to dram_cas_n
#set_location_assignment PIN_A12 -to dram_cke
#set_location_assignment PIN_B14 -to dram_clk
#set_location_assignment PIN_A14 -to dram_clk_n
set_location_assignment PIN_B4 -to gpio[51]
#set_location_assignment PIN_A4 -to dram_dm[1]
#set_location_assignment PIN_D9 -to dram_dm[0]
#set_location_assignment PIN_B5 -to dram_dq[15]
#set_location_assignment PIN_E6 -to dram_dq[14]
#set_location_assignment PIN_A7 -to dram_dq[13]
#set_location_assignment PIN_E7 -to dram_dq[12]
#set_location_assignment PIN_D8 -to dram_dq[11]
#set_location_assignment PIN_B6 -to dram_dq[10]
#set_location_assignment PIN_B7 -to dram_dq[9]
#set_location_assignment PIN_A5 -to dram_dq[8]
#set_location_assignment PIN_B10 -to dram_dq[7]
#set_location_assignment PIN_C9 -to dram_dq[6]
#set_location_assignment PIN_A11 -to dram_dq[5]
#set_location_assignment PIN_B12 -to dram_dq[4]
#set_location_assignment PIN_B11 -to dram_dq[3]
#set_location_assignment PIN_B13 -to dram_dq[2]
#set_location_assignment PIN_D14 -to dram_dq[1]
#set_location_assignment PIN_G16 -to dram_addr[12]
#io reference


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
#all SRAM pins are VCCIO set through the VCCIO_34 pin
#   except sram_dq[9] & sram_dq[8] which are from bank2 and set by VCCIO_2
#   in this template they remain @ default of 3.3V
#end SRAM


