@ECHO OFF&PUSHD %~DP0

setlocal EnableDelayedExpansion&color 3e & cd /d "%~dp0"

title windows激活

%1 %2

mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :runas","","runas",1)(window.close)&goto :eof

:runas


:WH

cls

echo.

echo 选择激活的windows版本序号

echo.

echo --------------------------------------------------------------------------------

echo 1. 激活 windows10

echo.

echo. --------------------------------------------------------------------------------

echo.--------------------本程序仅支持激活windows10-----------
 
set /p tsk="请输入需要激活的windows版本号【回车】确认（1-2），其实不管你输几结果都是一样的: "

if not defined tsk goto:err

if %tsk%==1 goto:1

:err

goto:WH
:1

cls

echo 正在激活windows....
echo 我说正在激活就是在激活吖??????

echo 当前目录是：%cd%
echo  ------------------------------------------------------
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX

slmgr /skms kms.03k.org

slmgr /ato

goto :e

echo.

echo 激活完成，按任意键退出！


pause >nul

exit
