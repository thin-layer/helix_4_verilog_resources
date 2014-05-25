#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting SOF File: C:\Dropbox\workspace\Rev_D_Quartus_130\helix_4_ms_audio_volume_with_rangefinder_MB1010_q130\helix_4.sof to: "..\flash/helix_4_epcs_flash_controller_0.flash"
#
sof2flash --input="C:/Dropbox/workspace/Rev_D_Quartus_130/helix_4_ms_audio_volume_with_rangefinder_MB1010_q130/helix_4.sof" --output="../flash/helix_4_epcs_flash_controller_0.flash" --epcs --verbose 

#
# Programming File: "..\flash/helix_4_epcs_flash_controller_0.flash" To Device: epcs_flash_controller_0
#
nios2-flash-programmer "../flash/helix_4_epcs_flash_controller_0.flash" --base=0x1000 --epcs --sidp=0x2068 --id=0x1234ABCD --timestamp=1373615647 --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program --verbose 

#
# Converting ELF File: C:\Dropbox\workspace\Rev_D_Quartus_130\helix_4_ms_audio_volume_with_rangefinder_MB1010_q130\software\audio_rangefinder_vol_control_sw_0\audio_rangefinder_vol_control_sw_0.elf to: "..\flash/audio_rangefinder_vol_control_sw_0_epcs_flash_controller_0.flash"
#
elf2flash --input="C:/Dropbox/workspace/Rev_D_Quartus_130/helix_4_ms_audio_volume_with_rangefinder_MB1010_q130/software/audio_rangefinder_vol_control_sw_0/audio_rangefinder_vol_control_sw_0.elf" --output="../flash/audio_rangefinder_vol_control_sw_0_epcs_flash_controller_0.flash" --epcs --after="../flash/helix_4_epcs_flash_controller_0.flash" --verbose 

#
# Programming File: "..\flash/audio_rangefinder_vol_control_sw_0_epcs_flash_controller_0.flash" To Device: epcs_flash_controller_0
#
nios2-flash-programmer "../flash/audio_rangefinder_vol_control_sw_0_epcs_flash_controller_0.flash" --base=0x1000 --epcs --sidp=0x2068 --id=0x1234ABCD --timestamp=1373615647 --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program --verbose 

