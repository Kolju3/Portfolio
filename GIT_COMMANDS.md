# 📘 Git Commands Reference

Your essential guide to Git – from setup to advanced tricks.  
*Last updated: June 2026*

---

## 📋 Table of Contents

1. [📁 Repository Setup](#-repository-setup)
2. [📝 Basic Workflow](#-basic-workflow)
3. [🌿 Branching](#-branching)
4. [🌐 Remote Repositories](#-remote-repositories)
5. [📊 Viewing History & Status](#-viewing-history--status)
6. [↩️ Undoing Changes](#️-undoing-changes)
7. [🔑 SSH & Authentication](#-ssh--authentication)
8. [🛠️ Troubleshooting](#️-troubleshooting)
9. [⚡ Quick Cheat Sheet](#-quick-cheat-sheet)
10. [📚 Pro Tips](#-pro-tips)

---

## 📁 Repository Setup

Commands to initialize or clone a repository and configure your environment.

| Command | Explanation |
|---------|-------------|
| `git init` | Initializes a new Git repository in the current folder (creates a hidden `.git` directory). |
| `git clone <url>` | Downloads a remote repository to your local machine. Supports HTTPS, SSH, or GitHub CLI URLs. |
| `git config --global user.name "Your Name"` | Sets your global username for all commits on this machine. |
| `git config --global user.email "you@example.com"` | Sets your global email for all commits. |
| `git config --global core.editor "code --wait"` | Sets VS Code as your default Git editor (replace with `nano`, `vim`, etc.). |
| `git config --list` | Shows all current Git configuration settings. |

---

## 📝 Basic Workflow

The everyday cycle of saving your work.

| Command | Explanation |
|---------|-------------|
| `git status` | Shows the current state of your working directory and staging area. |
| `git add <file>` | Stages a specific file for the next commit. |
| `git add .` | Stages all changes (new, modified, and deleted files) in the current directory. |
| `git add -p` | Interactively stages parts of a file (hunks) – great for splitting changes. |
| `git commit -m "message"` | Creates a commit with a short, descriptive message. |
| `git commit -am "message"` | Stages all tracked files **and** commits in one step (skips `git add` for tracked files). |
| `git rm <file>` | Removes a file from both your working directory and staging area. |
| `git mv <old> <new>` | Renames a file and stages the change. |
| `git restore <file>` | Discards unstaged changes in a file (restores it to the last commit). |
| `git restore --staged <file>` | Unstages a file (keeps your changes, but moves them out of staging). |

---

## 🌿 Branching

Create, switch, and manage parallel development lines.

| Command | Explanation |
|---------|-------------|
| `git branch` | Lists all local branches. The current branch is marked with `*`. |
| `git branch <name>` | Creates a new branch at your current commit. |
| `git branch -d <name>` | Deletes a local branch (safe – only if merged). |
| `git branch -D <name>` | Force-deletes a local branch (even if unmerged). |
| `git switch <branch>` | Switches to an existing branch (newer, safer alternative to `checkout`). |
| `git switch -c <new-branch>` | Creates a new branch and switches to it immediately. |
| `git checkout <branch>` | Traditional way to switch branches (still widely used). |
| `git checkout -b <new-branch>` | Creates and switches to a new branch (classic). |
| `git merge <branch>` | Merges the specified branch into your current branch. |
| `git merge --abort` | Cancels a merge that resulted in conflicts. |
| `git rebase <base>` | Reapplies your commits on top of another branch (creates a linear history). |
| `git rebase --continue` | Continues rebasing after resolving conflicts. |
| `git rebase --abort` | Cancels the rebase operation. |

---

## 🌐 Remote Repositories

Interact with hosted versions (GitHub, GitLab, Bitbucket, etc.).

| Command | Explanation |
|---------|-------------|
| `git remote -v` | Lists all remote repositories with their URLs (fetch & push). |
| `git remote add <name> <url>` | Adds a new remote (conventionally named `origin`). |
| `git remote remove <name>` | Removes a remote connection. |
| `git remote rename <old> <new>` | Renames an existing remote. |
| `git push <remote> <branch>` | Uploads your local branch commits to the remote. |
| `git push -u <remote> <branch>` | Pushes and sets the upstream tracking (so future `git push` works without arguments). |
| `git push --force` | Force-pushes (overwrites remote history – use with extreme caution!). |
| `git push --force-with-lease` | Safer force-push – only overwrites if your remote ref is up-to-date. |
| `git pull` | Fetches remote changes and merges them into your current branch (same as `fetch` + `merge`). |
| `git pull --rebase` | Fetches remote changes and rebases your local commits on top (cleaner history). |
| `git fetch` | Downloads remote changes without merging them (updates your remote-tracking branches). |
| `git fetch --prune` | Removes remote-tracking references that no longer exist on the remote. |

---

## 📊 Viewing History & Status

Inspect commits, diffs, and logs.

| Command | Explanation |
|---------|-------------|
| `git log` | Shows the full commit history (use `q` to quit). |
| `git log --oneline` | Displays a condensed history (one line per commit – hash + message). |
| `git log --graph --oneline --all` | Shows a visual graph of all branches with commit messages. |
| `git log -p <file>` | Shows the patch (detailed diff) for every commit affecting that file. |
| `git diff` | Shows unstaged changes (working directory vs staging). |
| `git diff --staged` | Shows staged changes (staging vs last commit). |
| `git diff <branch1>..<branch2>` | Compares two branches. |
| `git show <commit-hash>` | Displays details (metadata + diff) of a specific commit. |
| `git shortlog -sn` | Lists all contributors sorted by number of commits. |
| `git blame <file>` | Shows who last modified each line of a file (line‑by‑line). |

---

## ↩️ Undoing Changes

Fix mistakes at every stage – from uncommitted edits to pushed commits.

| Command | Explanation |
|---------|-------------|
| `git restore <file>` | Discard uncommitted changes in a file (revert to last commit). |
| `git restore --staged <file>` | Unstage a file (keep your edits, but move them out of staging). |
| `git reset <commit-hash>` | Moves the current branch pointer to a specific commit (keeps changes in working directory – `--mixed` default). |
| `git reset --hard <commit-hash>` | Moves the branch pointer **and** discards all changes after that commit (dangerous – loses work). |
| `git reset --soft <commit-hash>` | Moves the branch pointer but keeps all changes staged (ready to recommit). |
| `git revert <commit-hash>` | Creates a **new** commit that undoes the changes of a previous commit (safe for shared history). |
| `git commit --amend -m "new message"` | Modifies the most recent commit (change message or add forgotten files). |
| `git commit --amend --no-edit` | Amend without changing the message (adds staged changes to the last commit). |
| `git clean -fd` | Removes untracked files and directories from your working tree (permanent!). |
| `git reflog` | Shows a log of all movements of HEAD – a safety net to recover lost commits. |

---

## 🔑 SSH & Authentication

Set up secure connections to remote hosts.

| Command | Explanation |
|---------|-------------|
| `ssh-keygen -t ed25519 -C "your_email@example.com"` | Generates a new SSH key pair (Ed25519 is modern and secure). |
| `ssh-keygen -t rsa -b 4096 -C "your_email"` | Alternative RSA key generation (4096 bits). |
| `eval "$(ssh-agent -s)"` | Starts the SSH agent in the background. |
| `ssh-add ~/.ssh/id_ed25519` | Adds your private key to the SSH agent. |
| `cat ~/.ssh/id_ed25519.pub` | Displays your public key – copy this to your GitHub/GitLab settings. |
| `ssh -T git@github.com` | Tests your SSH connection to GitHub (should show a welcome message). |
| `git config --global credential.helper cache` | Caches your HTTPS password for a while (default 15 min). |
| `git config --global credential.helper "cache --timeout=3600"` | Caches credentials for 1 hour. |
| `git config --global credential.helper store` | Stores credentials in plain text (not recommended – use cache or manager). |

---

## 🛠️ Troubleshooting

Common issues and how to resolve them.

| Command | Explanation |
|---------|-------------|
| `git status` | **Always start here** – it tells you exactly what Git is thinking. |
| `git fsck` | Checks the integrity of your Git filesystem (finds corrupted objects). |
| `git gc` | Garbage collection – compresses your repository and cleans up unnecessary files. |
| `git log --merge` | Shows the commit history that caused a merge conflict. |
| `git checkout --ours <file>` | During a conflict, keeps your version of the file. |
| `git checkout --theirs <file>` | During a conflict, keeps the incoming (other branch) version. |
| `git diff --check` | Identifies whitespace errors (trailing spaces, etc.) before committing. |
| `git blame -L <start>,<end> <file>` | Checks who changed specific lines (e.g., `git blame -L 10,20 app.js`). |
| `git reset --hard ORIG_HEAD` | After a failed merge or pull, resets back to the previous state. |
| `git rev-parse --show-toplevel` | Finds the root directory of the current Git repository. |

---

## ⚡ Quick Cheat Sheet

A condensed summary for daily reference.

| Category | Most used commands |
|----------|---------------------|
| **Start** | `git init` / `git clone <url>` |
| **Status** | `git status` / `git log --oneline` |
| **Stage** | `git add .` / `git add <file>` |
| **Commit** | `git commit -m "msg"` / `git commit -am "msg"` |
| **Branch** | `git branch` / `git switch -c <new>` / `git merge <branch>` |
| **Remote** | `git push -u origin main` / `git pull --rebase` |
| **Undo** | `git restore <file>` / `git reset --soft HEAD~1` / `git revert <hash>` |
| **Diff** | `git diff` / `git diff --staged` |

---

## 📚 Pro Tips

Advanced habits that make you a Git power‑user.

1. **Write atomic commits** – each commit should do one logical thing. Makes reverting and reviewing much easier.

2. **Master interactive rebase** – `git rebase -i HEAD~n` lets you squash, reword, drop, or reorder commits before pushing.

3. **Always pull with rebase** – `git pull --rebase` avoids unnecessary merge commits and keeps your history clean.

4. **Use aliases** to save typing. Add to your `~/.gitconfig`:
   ```ini
   [alias]
       co = checkout
       br = branch
       ci = commit
       st = status
       unstage = restore --staged
       last = log -1 HEAD
       tree = log --graph --oneline --all