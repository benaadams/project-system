setlocal enabledelayedexpansion

if "%1" == "-configuration" if "%3" == "-prepareMachine" (
  SET EXE_DIR=%~dp0artifacts\%2\tmp
  SET LOG_DIR=%~dp0artifacts\%2\log
  SET EXE=%EXE_DIR%\dotnet-dev-win-x64.1.0.4.exe
  SET LOG=%LOG_DIR%\cli_install.log

  mkdir "%EXE_DIR%"
  mkdir "%LOG_DIR%"
  
  echo Downloading dotnet ...  
  powershell -NoProfile -ExecutionPolicy Bypass -Command "((New-Object System.Net.WebClient).DownloadFile('https://download.microsoft.com/download/B/9/F/B9F1AF57-C14A-4670-9973-CDF47209B5BF/dotnet-dev-win-x64.1.0.4.exe', '%EXE%'))"
  
  echo Installing %EXE% ...
  "%EXE%" /install /quiet /norestart /log "%LOG%"
)

powershell -ExecutionPolicy ByPass %~dp0build\Build.ps1 -restore -deployDeps -build -deploy -integrationTest -ci %*
exit /b %ERRORLEVEL%

