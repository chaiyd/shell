@ECHO OFF&PUSHD %~DP0

setlocal EnableDelayedExpansion&color 3e & cd /d "%~dp0"

title officeϵ��vl�漤��

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

echo ѡ�񼤻��office�汾���

echo.

echo --------------------------------------------------------------------------------

echo 1. ���� Office 2016

echo.

echo 2. ���� Office 2013

echo.

echo. --------------------------------------------------------------------------------

set /p tsk="��������Ҫ�����office�汾�š��س���ȷ�ϣ�1-2������ʵ�������伸�������һ����: "

if not defined tsk goto:err

if %tsk%==1 goto:1

if %tsk%==2 goto:1

:err

goto:WH
:1

cls

echo ���ڼ���office...
echo ��˵���ڼ�������ڼ���߹??????

echo ��ǰĿ¼�ǣ�%cd%
echo  ------------------------------------------------------
cscript OSPP.VBS /sethst:kms.03k.org
cscript OSPP.VBS /act

goto :e

echo.

echo ������ɣ���������˳���

pause >nul

exit
