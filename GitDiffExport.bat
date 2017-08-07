chcp 65001
@echo off
echo Eport GitDiff
set /p input1=Export Start Commit ID: 
set commitIdStart=%input1%
set /p input2=Export End Commit ID: 
if [%input2%] ==[] (set commitIdEnd=HEAD) else (set commitIdEnd=%input2%)
echo Start ID = %commitIdStart%
echo End ID = %commitIdEnd%

for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined DateTime set DateTime=%%x
echo %DateTime%
set exportFolder=%DateTime:~0,4%%DateTime:~4,2%%DateTime:~6,2%_%DateTime:~8,6%
echo %exportFolder%
for /f "usebackq tokens=*" %%A in (`git diff-tree -r --no-commit-id --name-only --diff-filter=ACMRT %commitIdStart% %commitIdEnd%`) do echo FA|xcopy "%%~fA" "GitExport\%exportFolder%\%%A"
set /p DUMMY =Hit Enter To Continue....