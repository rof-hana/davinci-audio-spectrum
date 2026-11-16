@echo off
setlocal
chcp 65001 >nul

set "SCRIPT_DIR=%~dp0"
set "FUSION_DIR=%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion"
set "FUSES_DIR=%FUSION_DIR%\Fuses"
set "EFFECTS_DIR=%FUSION_DIR%\Templates\Edit\Effects"
set "GENERATORS_DIR=%FUSION_DIR%\Templates\Edit\Generators"

if not exist "%FUSES_DIR%" mkdir "%FUSES_DIR%"
if not exist "%EFFECTS_DIR%" mkdir "%EFFECTS_DIR%"
if not exist "%GENERATORS_DIR%" mkdir "%GENERATORS_DIR%"

copy /Y "%SCRIPT_DIR%AudioSpectrumAnalyzer.fuse" "%FUSES_DIR%\" >nul
if errorlevel 1 (
    echo [ERROR] Failed to copy AudioSpectrumAnalyzer.fuse
    pause
    exit /b 1
)

copy /Y "%SCRIPT_DIR%drfx_src\Edit\Effects\Audio Spectrum Analyzer.setting" "%EFFECTS_DIR%\" >nul
if errorlevel 1 (
    echo [ERROR] Failed to copy Edit Effect template
    pause
    exit /b 1
)

copy /Y "%SCRIPT_DIR%drfx_src\Edit\Generators\Audio Spectrum Analyzer.setting" "%GENERATORS_DIR%\" >nul
if errorlevel 1 (
    echo [ERROR] Failed to copy Edit Generator template
    pause
    exit /b 1
)

echo Installed Audio Spectrum Analyzer successfully!
echo   Fuse:      %FUSES_DIR%\AudioSpectrumAnalyzer.fuse
echo   Effect:    %EFFECTS_DIR%\Audio Spectrum Analyzer.setting
echo   Generator: %GENERATORS_DIR%\Audio Spectrum Analyzer.setting
echo.
echo Please restart DaVinci Resolve if it is currently running.
pause
