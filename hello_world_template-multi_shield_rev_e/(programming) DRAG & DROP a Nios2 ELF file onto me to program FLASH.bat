@echo off
cls
echo *
echo **************************************************
echo *          ELF + SOF --> EPCS Flash              *
echo * 												  *
echo *   Last mod BS 09 Aug 2013                      *
echo *                                                *
echo *   This batch file will convert your FPGA SOF   *
echo *   configuration file, and your NIOS2 ELF file  *
echo *   into the 'JIC' format, then programs the JIC *
echo *   file into module EPCS Serial Flash. If       *
echo *   successful, your application will boot on    *
echo *   reset. This file assumes a sof file called   *
echo *   "helix_4.sof".                               *
echo * 												  *
echo *   NOTE: This batch script will ONLY work if    *
echo *      if you have installed Quartus 13.0 to the *
echo *      default location. If you have not, edit   *
echo *      this file to match your install location. *
echo * 												  *
echo **************************************************
echo * 
echo *
REM # Make a copy of of the elf file. This is a workaround, because the
REM #    slashes are the wrong way in Windows and elf2flash fails
copy %1 %~dp0\helix_4_nios2.elf
cd %~dp0
start %SOPC_KIT_NIOS2%\"Nios II Command Shell.bat" ./script/make_sof_and_elf_into_hex_files.sh ./helix_4_nios2.elf
echo * 
echo *
echo **************************************************
echo *    Create JTAG Indirect Programming File       *
echo *                                                *
echo *                  IMPORTANT                     *
echo *                                                *
echo *   A new terminal window has just launched to   *
echo *   compile some intermediate files. Please      *
echo *   allow it to finish before continuing here.   *
echo *                                                *
echo **************************************************
echo *
pause
REM # Now use Quartus Convert Programming Files command line utility
REM #    The COF file contains details of the hex files, and the target
%QUARTUS_ROOTDIR%\bin\quartus_cpf -c ./helix_4_4ce22.cof
echo *
echo *
echo **************************************************
echo *          Serial Flash Programming              *
echo *                                                *
echo *                  IMPORTANT                     *
echo *                                                *
echo *   Please ensure only one programming tool is   *
echo *   attached to the system.                      *
echo *                                                *
echo **************************************************
echo *
echo *
pause
%QUARTUS_ROOTDIR%\bin\quartus_pgm -m JTAG -o pvbi;helix_4.jic
pause