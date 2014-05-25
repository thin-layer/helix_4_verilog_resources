#************************************************************
# THIS IS A WIZARD-GENERATED FILE.                           
#
# Version 12.1 Build 177 11/07/2012 SJ Web Edition
#
#************************************************************

# Copyright (C) 1991-2012 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.



# Clock constraints
set local_osc_period 20
create_clock -name "local_osc" -period $local_osc_period [get_ports {local_osc}]

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

# todo: change to gpio naming

# tsu/th constraints
#set_input_delay -clock "local_osc" -max 19ns [get_ports {mod*}] 
#set_input_delay -clock "local_osc" -min 1.000ns [get_ports {mod*}] 

# tco constraints
#set_output_delay -clock "local_osc" -max 19ns [get_ports {mod*}] 
#set_output_delay -clock "local_osc" -min -1.000ns [get_ports {mod*}] 

# tpd constraints


# *************************************************
# *               SRAM Constraints                *
# *************************************************

#the SRAM is 10ns read access time
set SRAM_tCO_max 10.0
set SRAM_tCO_min 8.0
#board propagation delay, guessing here - todo: measure
set SRAM_BDa_max 0.0	
set SRAM_BDa_min 0.0

#for the sram data pin outputs
#create the output minimum delay for the data input to the #FPGA that accounts for all delays specified
set_output_delay -add_delay -clock "local_osc" -max [expr $SRAM_tCO_max + $SRAM_BDa_max] [get_ports {sram_*}]
set_output_delay -add_delay -clock "local_osc" -min [expr $SRAM_tCO_min + $SRAM_BDa_min] [get_ports {sram_*}]


# *************************************************
# *  JTAG Signal Constraints, cookbook page 1-22  *
# *************************************************

#constrain the TCK port
create_clock -name tck -period 100.00ns [get_ports altera_reserved_tck]

#cut all paths to and from tck
set_clock_groups -exclusive -group [get_clocks tck]

#constrain the TDI port
set_input_delay -clock tck 20 [get_ports altera_reserved_tdi]

#constrain the TMS port
set_input_delay -clock tck 20 [get_ports altera_reserved_tms]

#constrain the TDO port
set_output_delay -clock tck 20 [get_ports altera_reserved_tdo]
