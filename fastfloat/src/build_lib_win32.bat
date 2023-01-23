@echo off

if not exist "..\lib" mkdir ..\lib

cl -nologo -MT -O2 -c fastfloat.cpp
lib -nologo fastfloat.obj -out:..\lib\fastfloat.lib

del *.obj
