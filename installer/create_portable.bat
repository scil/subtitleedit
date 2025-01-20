@echo off
set OUTPUT_DIR=..\SubtitleEdit_Portable
set BIN_DIR=..\src\ui\bin\Release\net48

:: Create directories
mkdir "%OUTPUT_DIR%"
mkdir "%OUTPUT_DIR%\Dictionaries"
mkdir "%OUTPUT_DIR%\Languages"
mkdir "%OUTPUT_DIR%\Icons"
mkdir "%OUTPUT_DIR%\Tesseract302"
mkdir "%OUTPUT_DIR%\Tesseract302\tessdata"
mkdir "%OUTPUT_DIR%\x86"
mkdir "%OUTPUT_DIR%\x64"

:: Copy main executable and DLLs
copy "%BIN_DIR%\SubtitleEdit.exe" "%OUTPUT_DIR%\"
copy "%BIN_DIR%\*.dll" "%OUTPUT_DIR%\"

:: Copy dictionaries
copy "..\Dictionaries\*.xml" "%OUTPUT_DIR%\Dictionaries\"
copy "..\Dictionaries\*.dic" "%OUTPUT_DIR%\Dictionaries\"
copy "..\Dictionaries\*.aff" "%OUTPUT_DIR%\Dictionaries\"

:: Copy languages
copy "%BIN_DIR%\Languages\*.xml" "%OUTPUT_DIR%\Languages\"

:: Copy icons
copy "..\src\ui\Icons\*.ico" "%OUTPUT_DIR%\Icons\"

:: Copy Tesseract files
copy "..\Tesseract302\tessdata\configs\hocr" "%OUTPUT_DIR%\Tesseract302\tessdata\configs\"
copy "..\Tesseract302\tessdata\*.traineddata" "%OUTPUT_DIR%\Tesseract302\tessdata\"
copy "..\Tesseract302\*.exe" "%OUTPUT_DIR%\Tesseract302\"
copy "..\Tesseract302\*.dll" "%OUTPUT_DIR%\Tesseract302\"

:: Copy x86/x64 specific files
copy "%BIN_DIR%\x86\*.dll" "%OUTPUT_DIR%\x86\"
copy "%BIN_DIR%\x64\*.dll" "%OUTPUT_DIR%\x64\"

:: Copy documentation
copy "..\Changelog.txt" "%OUTPUT_DIR%\"
copy "..\LICENSE.txt" "%OUTPUT_DIR%\"

:: Create readme file
echo This is a portable version of Subtitle Edit. > "%OUTPUT_DIR%\README.txt"
echo Just extract and run SubtitleEdit.exe >> "%OUTPUT_DIR%\README.txt"

:: Optional: Create zip file using 7-Zip (if installed)
if exist "C:\Program Files\7-Zip\7z.exe" (
    "C:\Program Files\7-Zip\7z.exe" a -tzip "SubtitleEdit_Portable.zip" "%OUTPUT_DIR%\*"
)

:: 创建便携式配置
echo ^<?xml version="1.0" encoding="utf-8"?^> > "%OUTPUT_DIR%\Settings.xml"
echo ^<Settings^> >> "%OUTPUT_DIR%\Settings.xml"
echo   ^<General^> >> "%OUTPUT_DIR%\Settings.xml"
echo     ^<PortableMode^>true^</PortableMode^> >> "%OUTPUT_DIR%\Settings.xml"
echo   ^</General^> >> "%OUTPUT_DIR%\Settings.xml"
echo ^</Settings^> >> "%OUTPUT_DIR%\Settings.xml"

echo Done!
pause