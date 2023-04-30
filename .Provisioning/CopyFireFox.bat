for /f "delims=" %%a in ('type "%APPDATA%\Mozilla\Firefox\profiles.ini" ^| findstr "Default=Profiles/*"') do @set profileline=%%a
for /f "tokens=2 delims=/" %%h in ("%profileline%") do set profilepath=%%h
FOR /F "tokens=* delims=" %%x in (.Provisioning\FFoxProDirs.txt) DO xcopy /i /e /h /y "%APPDATA%\Mozilla\Firefox\Profiles\%profilepath%\%%x" ".Provisioning\firefox\%%x"
FOR /F "tokens=* delims=" %%g in (.Provisioning\FFoxProFiles.txt) DO xcopy /h /y "%APPDATA%\Mozilla\Firefox\Profiles\%profilepath%\%%g" .Provisioning\firefox\