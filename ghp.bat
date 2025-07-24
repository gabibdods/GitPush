@echo off

git add .
git status

set /p msg="Commit message: "
git commit -m "%msg%"

git push