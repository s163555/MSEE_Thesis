@echo off
if "%1" =="" (
  bash "/mnt/c/Program Files/gummi/run_gummi.sh"
  goto :eof
  )

set filepath=%1
set filepath=%filepath:C:=%
set filepath=%filepath:\=/%
set filepath=%filepath:"=%
set filepath=/mnt/c%filepath%
REM TODO handle spaces inside strings

bash "/mnt/c/Users/Jeppe/Documents/MSEE_Thesis/run_gummi.sh" %filepath%
goto :eof