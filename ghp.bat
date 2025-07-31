@echo off
setlocal EnableDelayedExpansion

:: List
set "repos=FolioFrame BeforeItsPrinted NucleoSuite CforCube VhsicHdl GitPush GitStart PacketVision"

:: Choose
set "keys="
set i=0
echo.
echo Repository?
for %%R in (%repos%) do (
    set /a i+=1
    set "keys=!keys!!i!"
    echo !i!. %%R
)
echo.

:: Verify
choice /c !keys! /n /m "Select: "
set "selection=%errorlevel%"

:: Answer
set "i=0"
for %%R in (%repos%) do (
    set /a i+=1
    if "!i!"=="%selection%" (
        set "project=%%R"
        goto done
    )
)

:: Relocate
:done
cd "%USERPROFILE%\_%project%"
echo Working in %USERPROFILE%\_%project%
echo.

:: Submodule exception
if /I "%project%"=="BeforeItsPrinted" (

    echo Submodule detected
	cd "%USERPROFILE%\_FolioFrame\%project%"
	echo Working in %USERPROFILE%\_FolioFrame\%project%
	echo.
	
)

:: .gitignore Sanity test
git add .
git status

:: Nothing to commit
for /f "tokens=* delims=" %%A in ('git status') do (
    set "last=%%A"
)
:: Use !x! for variables inside blocks, instead of %x%
if "!last!"=="nothing to commit, working tree clean" (
    exit /b 0
) else (
    :: Commit message
	set /p msg="Commit message: "
	
	:: Exit early?
	if "!msg!"=="" exit 0
		
	:: Update repository
	git commit -S -m "!msg!"
	
	git push
	
	git --no-pager log -4 -p --stat
)

:: Check for GitLab repo
set "first="
for /f "delims=" %%A in ('git remote') do (
    if not defined first set "first=%%A"
)

:: Push if detected
if /I "!first!"=="gitlab" (

	echo.
	echo [%project%] Pushing to GitLab...
    git push gitlab main
)

endlocal
