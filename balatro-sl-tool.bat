@echo off

chcp 65001

if not defined FOO (
  set FOO=1
  start /min "" %~0
  exit /b
)

title Balatro S/L Tool

echo ============================
echo 欢迎使用 Balatro 存档同步工具
echo 工具每 5 秒检查一次存档更新
@echo off
echo 按 A 键回档
echo ============================
echo.


set Profile=1
set FileName=C:\Users\%USERNAME%\AppData\Roaming\Balatro\%Profile%\save.jkr
set FileTime=-

echo 正在检查存档更新...

:loop
if exist "%FileName%" (
    for %%X in (%FileName%) do (
        if  "%FileTime%" NEQ "%%~tX" (
            rem copy the file to another location
            xcopy %FileName% C:\Users\%USERNAME%\Documents\BalatroSL\save.jkr* /Y > null
            echo 存档已更新于 %%~tX
            echo.
        )

        set FileTime=%%~tX
    )
)


rem press A to load the save
choice /c AB /t 3 /d B > null
if %errorlevel% == 1 (
     echo.
     echo 正在回档...更新于 %FileTime%
     xcopy C:\Users\%USERNAME%\Documents\BalatroSL\save.jkr C:\Users\%USERNAME%\AppData\Roaming\Balatro\%Profile%\ /Y > null
     echo 回档完成
     echo.
)
if %errorlevel% == 2 (
   rem
)
rem wait 5 seconds before checking again
ping -n 6 localhost >nul 2>nul
goto :loop

