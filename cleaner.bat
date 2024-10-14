@echo off
setlocal enabledelayedexpansion

color 0A

set isAdmin=false

net session >nul 2>&1
if !ErrorLevel! == 0 (
    set isAdmin=true
)

if /I "!isAdmin!" == "true" (
    set console_output=true
    set clear_desktop=true
    set save_logs=true

    if /I "!console_output!" == "true" (
        echo Cleaning history of recent ran programs..
    )

    del /q "%APPDATA%\Microsoft\Windows\Recent\*"

    if /I "!console_output!" == "true" (
        echo Cleaning temp files..
    )

    del /q "%TEMP%\*" >nul 2>&1
    del /q "%USERPROFILE%\AppData\Local\Temp\*" >nul 2>&1

    if /I "!console_output!" == "true" (
        echo Cleaning Windows search history..
    )

    del /q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*"
    del /q "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*"

    if /I "!console_output!" == "true" (
        echo Cleaning event viewer logs..
    )

    wevtutil cl Application
    wevtutil cl Security
    wevtutil cl System

    if /I "!console_output!" == "true" (
        echo Cleaning windows update history..
    )
    del /q "C:\Windows\SoftwareDistribution\Download\*"

    if /I "!console_output!" == "true" (
        echo Cleaning user files, logs and photos..
    )

    if exist "%USERPROFILE%\Documents\*.log" (
        del /q "%USERPROFILE%\Documents\*.log"
    )

    del /q "%USERPROFILE%\Documents\*.rdp" 2>nul

    if exist "%USERPROFILE%\Documents\*.log" (
        del /q "%USERPROFILE%\*.log"
    )

    del /q "%USERPROFILE%\Pictures\Screenshots\*" 2>nul
    del /q "%USERPROFILE%\Videos\*" 2>nul
    del /q "%USERPROFILE%\Searches\*" 2>nul
    rd /s /q "%USERPROFILE%\Searches" 2>nul
    del /q "%USERPROFILE%\Downloads\*" 2>nul

    if /I "!clear_desktop!" == "true" (
        if /I "!console_output!" == "true" (
            echo Cleaning all files/folders from desktop except Recycle Bin
        )

        :: Delete all files on the desktop except Recycle Bin
        for %%F in ("%USERPROFILE%\Desktop\*.*") do (
            if /I not "%%~nxF"=="Recycle Bin.lnk" (
                del "%%F" /Q
            )
        )

        :: Delete all folders on the desktop except Recycle Bin
        for /D %%D in ("%USERPROFILE%\Desktop\*") do (
            if /I not "%%~nxD"=="Recycle Bin" (
                rd /s /q "%%D"
            )
        )
    )

    if /I "!console_output!" == "true" (
        echo Cleaning Recycle Bin..
    )
    if exist "C:\$Recycle.Bin" (
        rd /s /q C:\$Recycle.Bin
    )

    if /I "!console_output!" == "true" (
        echo Cleaning Windows Update cache..
    )
    del /q "C:\Windows\SoftwareDistribution\Download\*"

    if /I "!console_output!" == "true" (
        echo Cleaning Error Report logs...
    )
    del /q "C:\ProgramData\Microsoft\Windows\WER\ReportArchive\*"

    if /I "!console_output!" == "true" (
        echo Cleaning history of Command Prompt..
    )

    if exist "%APPDATA%\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" (
        del /q "%APPDATA%\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
    )

    if /I "!console_output!" == "true" (
        echo Cleaning prefetch files..
    )
    del /q "C:\Windows\Prefetch\*"

    if /I "!console_output!" == "true" (
        echo Cleaning RDP history..
    )
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client\Default" /f

    if /I "!console_output!" == "true" (
        echo Cleaning SSH history..
    )
    if exist "%USERPROFILE%\.ssh\known_hosts" (
        del /q "%USERPROFILE%\.ssh\known_hosts"
    )
    if exist "%USERPROFILE%\.bash_history" (
        del /q "%USERPROFILE%\.bash_history"
    )
    if exist "%USERPROFILE%\.ssh\.known_hosts.old" (
        del /q "%USERPROFILE%\.ssh\.known_hosts.old"
    )

    if /I "!console_output!" == "true" (
        echo Cleaning Telnet history..
    )
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Telnet\Client" /f

    if /I "!console_output!" == "true" (
        echo Cleaning FTP history..
    )
    if exist "%APPDATA%\Microsoft\Windows\FTP\*.ftp" (
        del /q "%APPDATA%\Microsoft\Windows\FTP\*.ftp"
    )

    if /I "!save_logs!" == "true" (
        set LOGFILE=%~dp0cleaner.txt

        for /f "tokens=1,2 delims= " %%a in ('echo %date%') do set DATE=%%a
        for /f "tokens=1-4 delims=: " %%a in ("%time%") do (
            set TIME=%%a:%%b:%%c
        )

        set FORMATTED_MESSAGE=[%DATE% - %TIME%] user %username% is successfully cleaned

        echo !FORMATTED_MESSAGE! >> !LOGFILE!
    )

    if /I "!console_output!" == "true" (
        echo ---------------------------------------------------------
        echo.
        echo Cleaning done!
    )
	if /I "!console_output!" == "true" (
    	pause
	)
) else (
    echo Admin permissions are required.
    pause
)

:: By Zile42O
:: github.com/zile42O
:: Version: 1.0
:: This is made for automatic task schedulers to work with windows, to keep some privacy and protect your data
:: on windows from unauthorized attackers, using this script you are agreed to script modify and delete files from your computer.
