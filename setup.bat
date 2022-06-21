@echo off

set sPID_FNAME=sPID.txt

IF EXIST %sPID_FNAME% (
	set /p PID=<%sPID_FNAME% 
)
@taskkill /PID %PID%
@taskkill /PID %PID%

set T=%TEMP%\sthUnique.tmp
wmic process where (Name="WMIC.exe" AND CommandLine LIKE "%%%TIME%%%") get ParentProcessId /value | find "ParentProcessId" >%T%
set /P A=<%T%
set PID=%A:~16%

echo %PID%> %sPID_FNAME%
@echo on
@echo pid: %PID%

@title  sTerminal
copy /Y F:\server_mcraft\plug_proj\pluginManager\build\libs\pluginManager-1.0-SNAPSHOT.jar .
copy /Y F:\server_mcraft\plug_proj\logger\build\libs\logs-1.0-SNAPSHOT.jar .
@cd ..
@java -Xmx1G -jar paper-1.18.2-379.jar -nogui
