echo off
SET PATH=%PATH%;c:\altera\13.0\quartus\bin
cls
echo *
echo **************************************************
echo *   Last mod BS 10 May 2013, QII 13.0 Build 156  *
echo *                                                *
echo *   This batch file will establish a new project *
echo *      by executing a TCL script, also in this   *
echo *      directory. You can change the nature of   *
echo *   	your new project by editing the TCL file. *
echo * 
echo *   NOTE: This batch script will ONLY work if    *
echo *      if you have installed Quartus 13.0 to the *
echo *      default location. If you have not, edit   *
echo *      this file to match your install location. *
echo **************************************************
echo * 
echo *

%QUARTUS_ROOTDIR%\bin\quartus_sh.exe -t helix_4_template_multi_shield.tcl

echo *
echo *
echo **************************************************
echo *   now open the generated helix_4.qpf using   *
echo *   the Quartus II software                      *
echo **************************************************
echo *
pause