if [ "x$1" = "x" ]
then
  echo  *** Error: no input elf file specified ***
  exit 1
fi

sof2flash --input=helix_4.sof --output=hwimage.flash --epcs --verbose
elf2flash --input=$1 --output=swimage.flash --epcs --after=hwimage.flash --verbose

nios2-elf-objcopy -I srec -O ihex hwimage.flash hwimage.hex
nios2-elf-objcopy -I srec -O ihex swimage.flash swimage.hex

echo 
echo    --- All done here! ---
echo 
echo Now close me, and continue in the terminal window behind me to complete the JIC generation, and flash programming.
echo
#read -p "Please press enter to continue"
#exit