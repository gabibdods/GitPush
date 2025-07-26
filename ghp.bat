@echo off

git add .
git status

set /p msg="Commit message: "
if "%msg%"=="" set msg=updated license and rights

git commit -m "%msg%"

git push

git --no-pager log -4 -p --stat
