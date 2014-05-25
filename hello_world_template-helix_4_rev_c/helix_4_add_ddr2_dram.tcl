###############################################################################
#                                                                             #
#   TCL Script to add QSys to a helix_4 Project (Rev C)                       #
#      Last updated BS 01 May 2013                                            #
#                                                                             #
###############################################################################

project_open helix_4

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

#io reference for the gpio
#these are pins that are NOT vccio1,2 or 5, which are selectable
#use STRATIX_DEVICE_IO_STANDARD assignment for other gpio, or bank by bank as below 
set_instance_assignment -name IO_STANDARD "1.8 V" -to scl
set_instance_assignment -name IO_STANDARD "1.8 V" -to sda
#nCEO
set_instance_assignment -name IO_STANDARD "1.8 V" -to mod0_d[10]
#end GPIO

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