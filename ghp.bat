@echo off

git add .
git status

set /p msg="Commit message: "
if "%msg%"=="" set msg=updated license and rights

git commit -m "%msg%"

git push

git log -p --stat

q