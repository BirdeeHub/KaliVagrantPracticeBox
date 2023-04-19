for /f "delims=" %%a in ('vagrant status ^| findstr /v birdeeKali ^| findstr running ^| find /c /v ""') do @set birdeeKaliRunning=%%a
IF %birdeeKaliRunning%==0 (vagrant up)
start "" "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm birdeeKali --type separate