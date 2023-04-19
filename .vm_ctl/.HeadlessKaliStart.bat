for /f "delims=" %%a in ('vagrant status ^| findstr /v birdeeKali ^| findstr running ^| find /c /v ""') do @set birdeeKaliRunning=%%a
IF %birdeeKaliRunning%==0 (vagrant up)
ssh -p 2202 vagrant@127.0.0.1