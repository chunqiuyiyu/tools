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
echo.
@echo off
echo 请在游戏返回主菜单后使用以下按键
echo A 键回档，S 键手动存档，D 键手动回档
echo ============================
echo.


set Profile=1
set FileName=C:\Users\%USERNAME%\AppData\Roaming\Balatro\%Profile%\save.jkr
set FileTime=-
set ManuallyFileTime=-
for %%X in (C:\Users\%USERNAME%\Documents\BalatroSL\save-manually.jkr) do (
set ManuallyFileTime=%%~tX
)

echo 正在检查存档更新...

:loop
if exist "%FileName%" (
    for %%X in (%FileName%) do (
        if  "%FileTime%" NEQ "%%~tX" (
            rem copy the file to another location
            xcopy %FileName% C:\Users\%USERNAME%\Documents\BalatroSL\save.jkr* /Y
            echo 存档已更新于 %%~tX
            echo.
        )

        set FileTime=%%~tX
    )
)


rem press A to load the save
choice /c ASDB /t 3 /d B >nul 2>nul
if %errorlevel% == 1 (
     echo.
     echo 正在回档...更新于 %FileTime%
     xcopy C:\Users\%USERNAME%\Documents\BalatroSL\save.jkr C:\Users\%USERNAME%\AppData\Roaming\Balatro\%Profile%\ /Y
     echo 回档完成
     echo.
)
if %errorlevel% == 2 (
    echo.
    xcopy %FileName% C:\Users\%USERNAME%\Documents\BalatroSL\save-manually.jkr* /Y > null
    rem get the file time
    echo 正在手动存档...更新于 %ManuallyFileTime%
    echo.
)
if %errorlevel% == 3 (
    echo.
    echo 正在手动回档...更新于 %ManuallyFileTime%
    xcopy C:\Users\%USERNAME%\Documents\BalatroSL\save-manually.jkr C:\Users\%USERNAME%\AppData\Roaming\Balatro\%Profile%\save.jkr* /Y
    echo 回档完成
    echo.
)
if %errorlevel% == 4 (
   rem
)
rem wait 5 seconds before checking again
ping -n 6 localhost >nul 2>nul
goto :loop

