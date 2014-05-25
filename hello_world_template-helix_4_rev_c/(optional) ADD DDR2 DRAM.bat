echo off
cls
echo *
echo **************************************************
echo *   Last mod BS 09 Aug 2013                      *
echo *												  *
echo *   ensure you've run:                           *
echo *      'helix_4 - NEW project'    				  *
echo *   before running this file                     *
echo *   this is just an adder.                       *
echo * 
echo *   NOTE: This batch script will ONLY work if    *
echo *      if you have installed Quartus 13.0 to the *
echo *      default location. If you have not, edit   *
echo *      this file to match your install location. *
echo **************************************************
echo * 
echo *

%QUARTUS_ROOTDIR%\bin\quartus_sh.exe -t helix_4_add_qsys.tcl

echo *
echo *
echo ****************************************************
echo *     IMPORTANT STEP!!                             *
echo * now open the generated helix_4.qpf using         *
echo * the Quartus II software, *AND* add the contents  *
echo * of file:											*
echo *    './hdl/add_me_to_top_level_for_qsys.sv'       *
echo * to your top level entity.                        *
echo ****************************************************
echo *
pause