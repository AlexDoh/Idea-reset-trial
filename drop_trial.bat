@echo off

set IDEA_USER="C:\Users\%USERNAME%\.IntelliJIdea%1\config"
set IDEA_EXE=idea.exe
set IDEA_EXE64=idea64.exe

if [%1]==[] (
    echo You have not specified version for IntelliJ Idea.
    exit /b
)

if exist %IDEA_USER% (
    echo Your user directory: %IDEA_USER%
) else (
    echo You have specified wrong version of IntelliJ Idea, or it is not installed in your system.
    exit /b
)
echo Closing idea 32x...
taskkill /f /im "idea.exe"
echo Closing idea 64x...
taskkill /f /im "idea64.exe"
echo Cleaning evaluation key...
rmdir /s /q %IDEA_USER%\eval
echo Reseting evaluation info...
sed -i '/evlsprt/d' %IDEA_USER%\options\options.xml
echo Cleaning registry...
reg delete "HKEY_CURRENT_USER\Software\JavaSoft\Prefs\jetbrains\idea" /f
echo Done!
echo Now you can open IntelliJ Idea.