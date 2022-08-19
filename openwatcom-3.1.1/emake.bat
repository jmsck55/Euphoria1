@echo off
if not exist main-.c goto nofiles
echo compiling with WATCOM
echo main-.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s main-.c
echo test.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s test.c
echo init-.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s init-.c
echo linking
wlink FILE test.obj @objfiles.lnk
del *.obj > NUL
if not exist test.exe goto done
echo you can now execute: test.exe
del main-.c
del main-.h
del init-.c
del objfiles.lnk
del test.c
goto done
:nofiles
echo Run the translator to create new .c files
:done
