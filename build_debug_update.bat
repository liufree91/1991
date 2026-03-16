echo OFF

SET BUILD_TYPE="Debug"
SET local_dir="%~d0%~p0"
SET BUILD_DIR="%local_dir%/../../build/%BUILD_TYPE%_NGC"

REM Create the temporary file where all cmake files will be created
IF NOT EXIST %BUILD_DIR% MKDIR %BUILD_DIR%

ECHO Entering %BUILD_DIR%
PUSHD %BUILD_DIR%

REM Create the cmake build project. 
::cmake -G "Unix Makefiles" -DTESTING=OFF -DCMAKE_BUILD_TYPE=%BUILD_TYPE% %local_dir%
cmake -G Ninja -DTESTING=OFF -DCMAKE_BUILD_TYPE=%BUILD_TYPE% %local_dir%
PAUSE
Ninja >> build_log.txt
::findstr /i "fatal failed unresolved undefined cannot missing" build_log.txt > build_errors.txt
code build_log.txt
::start notepad build_errors.txt
PAUSE

IF %ERRORLEVEL% EQU 0 (
    CMD /k env.bat
) ELSE (
    ECHO Entering %local_dir%
    POPD
)
