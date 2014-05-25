@echo off
cls
echo *
echo **************************************************
echo *             SOF --> EPCS Flash                 *
echo * 												  *
echo *   Last mod BS 09 Aug 2013                      *
echo *                                                *
echo *   This batch file will convert your FPGA SOF   *
echo *   configuration file into the 'JIC' format,    *
echo *   then program the JIC file into module EPCS   *
echo *   Serial Flash. If successful, your FPGA       *
echo *   design will run on reset. This file assumes  *
echo *   a sof file called "helix_4.sof".             *
echo * 												  *
echo *   NOTE: This batch script will ONLY work if    *
echo *      if you have installed Quartus 13.0 to the *
echo *      default location. If you have not, edit   *
echo *      this file to match your install location. *
echo * 												  *
echo **************************************************
echo * 
echo *
pause
REM # Now use Quartus Convert Programming Files command line utility
REM #    The COF file contains details of the hex files, and the target
REM #c:\altera\13.0\quartus\bin\quartus_cpf -c ./helix_4.cof
%QUARTUS_ROOTDIR%\bin\quartus_cpf -c -d EPCS16 -s EP4CE22 helix_4.sof helix_4.jic
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