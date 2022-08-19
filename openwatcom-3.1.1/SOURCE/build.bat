@echo off
@echo Build everything for DOS/Windows, using only WATOM for WIN32
@echo EUDIR is %EUDIR%

rem Note: Can't build properly if exwc (e.g. ed) is running

echo deleting any existing target files ...
del ec.a
del ec*.lib
del backend*.exe
del ec*.exe
del bind.il

echo build the Translator library for each C compiler

GOTO WIN32_WATCOM

call djglib.bat
if not exist ec.a goto fail

call watlib.bat /fp5 /fpi87
move ec.lib ecfastfp.lib
if not exist ecfastfp.lib goto fail

call watlib.bat /fpc 
if not exist ec.lib goto fail

:WIN32_WATCOM

call watlibw.bat
if not exist ecw.lib goto fail

GOTO WATCOM

echo a compiler error with Borland is probably OK ...
call borelib.bat
if not exist ecwb.lib goto fail

call lccelib.bat
if not exist ecwl.lib goto fail

:WATCOM

echo OK to copy all translator libs to %EUDIR%\bin? (Control-C to abort)
pause

move ec.a %EUDIR%\bin
move ec.lib %EUDIR%\bin
move ecfastfp.lib %EUDIR%\bin
move ecw.lib %EUDIR%\bin
move ecwb.lib %EUDIR%\bin
move ecwl.lib %EUDIR%\bin

GOTO WIN32

echo DOS translator
rem %EUDIR%\bin\ec.exe -wat ec.ex
%EUDIR%\bin\ex.exe ec.ex -wat ec.ex
call emake
if not exist ec.exe goto fail

echo DOS interpreter
call imake.bat
if not exist ex.exe goto fail

echo DOS backend
call bmake.bat
if not exist backend.exe goto fail

:WIN32

echo Windows translator
rem %EUDIR%\bin\ecw.exe -wat -con ec.ex
%EUDIR%\bin\exwc ec.ex -wat -con ec.ex
call emake
move ec.exe ecw.exe
if not exist ecw.exe goto fail

echo Windows interpreter
call imakew.bat
if not exist exw.exe goto fail

echo Windows backend
call bmakew.bat
if not exist backendw.exe goto fail

echo OK to copy all .exe's to %EUDIR%\bin? (Control-C to abort)
pause 

move ex.exe %EUDIR%\bin
move exw.exe %EUDIR%\bin

REM N.B. CAN'T BE IN ED (exwc is running) WHEN THIS IS RUN...
exwc %EUDIR%\bin\makecon.exw %EUDIR%

move backend.exe %EUDIR%\bin
move backendw.exe %EUDIR%\bin
move ec.exe %EUDIR%\bin
move ecw.exe %EUDIR%\bin

call clean.bat
dir %EUDIR%\bin /od

goto done

:fail
echo FAILED!

:done

