# GitPush

# Interactive Git Automation Script for Windows

### Description

- GitStart is a lightweight batch script developed using Notepad++ that streamlines common Git operations for multiple repositories
- It presents an interactive menu to select a project, automatically stages changes, checks status, commits with a custom message, and pushes to both GitHub and GitLab (if configured)
- Designed for use with the Windows Command Prompt and tested on local environments

---

## NOTICE

- Please read through this `README.md` to better understand the project's source code and setup instructions
- Also, make sure to review the contents of the `License/` directory
- Your attention to these details is appreciated — enjoy exploring the project!

---

## Problem Statement

- Performing repetitive Git operations across multiple repositories manually can be time-consuming and error-prone, especially when switching between remote origins such as GitHub and GitLab
- Developers often forget to verify working tree cleanliness before committing or to include a message, leading to incomplete pushes

---

## Project Goals

### Streamline Git Workflow

- Create a script-driven interface that automates the repetitive sequence of staging, committing, and pushing to Git remotes

### Support Multi-Repo & Multi-Remote Projects

- Ensure seamless handling of nested submodules and dual remote targets like GitHub and GitLab

---

## Tools, Materials & Resources

### Command Prompt (CMD)

- The script is built entirely for use in native Windows terminal environments using standard batch syntax

### Notepad++

- Used as the development environment due to its fast syntax highlighting and ease of scripting for .bat files

### Git for Windows

- Git executable must be installed and available in the system's PATH

---

## Design Decision

### Batch Scripting for Portability

- Chose a `.bat` script to ensure compatibility with any standard Windows installation without requiring third-party software

### Interactive Menu via choice

- Uses the choice command to generate a compact, user-friendly selection interface for multiple repositories

### Smart Remote Detection

- Automatically detects if a `gitlab` remote exists and pushes accordingly after the standard `origin` push

---

## Features

### Interactive Repo Selection

- Dynamically lists available repositories using an indexed menu for intuitive navigation

### Commit Sanity Checks

- Verifies that changes exist before prompting for a commit message to avoid unnecessary commits

### Optional GitLab Push

- Pushes to GitLab only if the `gitlab` remote is explicitly configured, ensuring safe operation across different setups

---

## Block Diagram

```plaintext
                                  ┌──────────────────────────────┐
                                  │       GitStart Script        │
                                  └─────────────┬────────────────┘
                                                ↓
                          ┌────────────────────────────┐
                          │   Display Repo Menu List   │
                          └─────────────┬──────────────┘
                                        ↓
                           ┌─────────────────────────┐
                           │  Select Target Project  │
                           └─────────────┬───────────┘
                                         ↓
                 ┌──────────────────────────────────────────────┐
                 │ cd to %USERPROFILE%\_selectedProject         │
                 └─────────────┬────────────────────────────────┘
                               ↓
                      ┌─────────────────────┐
                      │ git add . & status  │
                      └─────────────┬───────┘
                                    ↓
                       ┌──────────────────────────────┐
                       │ If tree clean: exit          │
                       │ Else: prompt for commit msg  │
                       └─────────────┬────────────────┘
                                     ↓
                    ┌────────────────────────────────────┐
                    │ Commit with message and push origin│
                    └─────────────┬──────────────────────┘
                                  ↓
            ┌───────────────────────────────────────────────┐
            │ If remote=gitlab → push to gitlab main        │
            └───────────────────────────────────────────────┘

```

---

## Functional Overview

- Launch the script from the command prompt
- Select a repository from the interactive list
- Automatically navigates to the selected repository folder
- Stages all changes and checks for uncommitted work
- Prompts the user for a commit message if necessary
- Pushes to `origin` and optionally to `gitlab` if configured

---

## Challenges & Solutions

### Environment-Specific Paths Abstraction

- Used %USERPROFILE% to generalize repository paths across Windows user profiles

### Submodule Path Resolution

- Special handling for `BeforeItsPrinted` ensures the script can correctly access submodule paths nested under `FolioFrame`

---

## Lessons Learned

### Batch Scripting Can Be Powerful

- With delayed variable expansion and conditional logic, even complex workflows can be automated entirely in `.bat` scripts

### Git Remote Handling Varies

- It’s critical to detect remotes dynamically to avoid pushing to non-existent remotes or causing push failures

---

## Future Enhancements

- Add support for `git pull` prior to pushing to minimize conflicts
- Integrate logging to track commit history and timestamps per repository
- Refactor to PowerShell for greater flexibility, cross-platform support, and GUI prompt support
