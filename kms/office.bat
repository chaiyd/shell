@ECHO OFF&PUSHD %~DP0

setlocal EnableDelayedExpansion&color 3e & cd /d "%~dp0"

title office系列vl版激活

%1 %2

mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :runas","","runas",1)(window.close)&goto :eof

:runas

if exist "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" cd /d "%ProgramFiles%\Microsoft Office\Office16"

if exist "%ProgramFiles(x86)%\Microsoft Office\Office16\ospp.vbs" cd /d "%ProgramFiles(x86)%\Microsoft Office\Office16"

if exist "%ProgramFiles%\Microsoft Office\Office15\ospp.vbs" cd /d "%ProgramFiles%\Microsoft Office\Office15"

if exist "%ProgramFiles(x86)%\Microsoft Office\Office15\ospp.vbs" cd /d "%ProgramFiles(x86)%\Microsoft Office\Office15"

:WH

cls

echo.

echo 选择激活的office版本序号

echo.

echo --------------------------------------------------------------------------------

echo 1. 激活 Office 2016

echo.

echo 2. 激活 Office 2013

echo.

echo. --------------------------------------------------------------------------------

set /p tsk="请输入需要激活的office版本号【回车】确认（1-2），其实不管你输几结果都是一样的: "

if not defined tsk goto:err

if %tsk%==1 goto:1

if %tsk%==2 goto:1

:err

goto:WH
:1

cls

echo 正在激活office...
echo 我说正在激活就是在激活吖??????

echo 当前目录是：%cd%
echo  ------------------------------------------------------
cscript OSPP.VBS /sethst:kms.03k.org
cscript OSPP.VBS /act

goto :e

echo.

echo 激活完成，按任意键退出！

pause >nul

exit
