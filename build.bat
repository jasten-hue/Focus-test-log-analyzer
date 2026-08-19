@echo off

title FOCUS TEST LOG ANALYZER - BUILD

echo.
echo ==========================================
echo   FOCUS TEST LOG ANALYZER
echo   OFFLINE APP BUILDER
echo ==========================================
echo.

echo Checking Python...

python --version

if errorlevel 1 (
    echo.
    echo ERROR: Python is not installed.
    echo.
    pause
    exit /b 1
)

echo.
echo Installing PyInstaller...

python -m pip install --upgrade pyinstaller

if errorlevel 1 (
    echo.
    echo ERROR: Could not install PyInstaller.
    echo.
    pause
    exit /b 1
)

echo.
echo Building application...

python -m PyInstaller ^
    --noconfirm ^
    --clean ^
    --onedir ^
    --windowed ^
    --name "FocusTestLogAnalyzer" ^
    app.py

if errorlevel 1 (
    echo.
    echo ==========================================
    echo BUILD FAILED
    echo ==========================================
    echo.
    pause
    exit /b 1
)

echo.
echo Copying application files...

copy /Y index.html dist\FocusTestLogAnalyzer\index.html

if exist chart.umd.js (
    copy /Y chart.umd.js dist\FocusTestLogAnalyzer\chart.umd.js
) else (
    echo.
    echo WARNING:
    echo chart.umd.js was not found.
    echo The graph will not work until you place
    echo chart.umd.js in the application folder.
)

echo.
echo ==========================================
echo BUILD COMPLETE
echo ==========================================
echo.
echo Your application is here:
echo.
echo dist\FocusTestLogAnalyzer\
echo.
echo Run:
echo.
echo dist\FocusTestLogAnalyzer\FocusTestLogAnalyzer.exe
echo.
pause
