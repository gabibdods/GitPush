@echo off
setlocal EnableDelayedExpansion

:: List
set "repos=NewRepositoryTemplate BeforeItsPrinted CforCube CO2hI ConfinedandUnbound DriveBack ElixirGate FirForge FolioFrame gabibdods GitPush GitStart GitTorial GrubBurst HashDrill HexRay iMirror LPM NucleoSuite NullVelope PacketVision PlayDuino PowerShield ProtoSwitch RoutePeel Serenio VeilScade VhsicHdl VirtuSetup VSB"

:: Build
set i=0
echo.
for %%R in (%repos%) do (
    set /a i+=1
    set "repo[!i!]=%%R"
    echo !i!. %%R
)
set /a max=%i%
echo.

:prompt
set /p sel="Repository? "

:: Verify
for /f "delims=0123456789" %%x in ("!sel!") do (
	echo Invalid input error.
	goto prompt
)
if %sel% lss 1 (
	echo Out of range error.
	goto prompt
)
if %sel% gtr %max% (
	echo Out of range error.
	goto prompt
)

:: Answer
set "project=!repo[%sel%]!"
if not defined project (
	echo Unknown repository error.
	goto prompt
)

:: Relocate
set "target=%USERPROFILE%\Documents\%project%"
if not exist "%target%" (
	set /p create="Directory '%target%' does not exist."
)
cd /d "%target%" 2>null || (
	echo Change directory error.
	exit 1
)
echo Working in "%target%"
echo.

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
	
	git --no-pager log -2 -p --stat
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
