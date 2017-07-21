if "%1" == "-configuration" if "%3" == "-prepareMachine" (  
  echo Downloading dotnet ...  
  powershell -NoProfile -ExecutionPolicy Bypass -Command "((New-Object System.Net.WebClient).DownloadFile('https://download.microsoft.com/download/B/9/F/B9F1AF57-C14A-4670-9973-CDF47209B5BF/dotnet-dev-win-x64.1.0.4.exe', '%~dp0artifacts\%2\tmp\dotnet-dev-win-x64.1.0.4.exe'))"
  
  echo Installing dotnet ...
  "%~dp0artifacts\%2\tmp\dotnet-dev-win-x64.1.0.4.exe" /install /quiet /norestart /log "%~dp0artifacts\%2\log\cli_install.log"
)

powershell -ExecutionPolicy ByPass %~dp0build\Build.ps1 -restore -deployDeps -build -deploy -integrationTest -ci %*
exit /b %ERRORLEVEL%

