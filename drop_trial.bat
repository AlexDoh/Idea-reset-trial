@echo off

SET IDEA_USER="C:\Users\%USERNAME%\.IntelliJIdea%1\config"
SET IDEA_EXE=idea.exe
SET IDEA_EXE64=idea64.exe

if [%1]==[] (
	echo You have not specified version for IntelliJ Idea.
	exit /b
)
echo %IDEA_USER%
IF EXIST %IDEA_USER% (
echo Your user directory: %IDEA_USER%
) ELSE (
echo You have specified wrong version of IntelliJ Idea, or it is not installed in your system.
exit /b
)
echo Closing idea 32x...
taskkill /f /im "idea.exe"
echo Closing idea 64x...
taskkill /f /im "idea64.exe"
:CLOSING
tasklist | findstr /I %IDEA_EXE64% | findstr /I %IDEA_EXE% >nul 2>&1
IF ERRORLEVEL 1 (
  GOTO CONTINUE
) ELSE (
  ECHO Closing idea...
  SLEEP 5
  GOTO CLOSING
)
:CONTINUE
echo Cleaning evaluation key...
rmdir /s /q %IDEA_USER%\eval
echo Reseting evaluation info...
sed -i '/evlsprt/d' %IDEA_USER%\options\options.xml
echo Cleaning registry...
reg delete "HKEY_CURRENT_USER\Software\JavaSoft\Prefs\jetbrains\idea" /f
echo Done!
echo Now you can open IntelliJ Idea.