---
name: pr
description: Pushes the current branch and creates a GitHub PR.
compatibility: opencode
---

# PR Workflow
Use this skill when work is committed and you are ready to push to the remote and open a PR.

## Step-by-Step Execution
1. **Branch Check**: 
   - If on `main` or `master`, stop and ask the user to switch to a feature branch. 
   - Otherwise, proceed.
2. **Push**: Run `git push origin HEAD` (if the remote branch doesn't exist, use `git push -u origin HEAD`).
3. **PR Creation**: 
   - Use the `gh pr create` command.
   - **Flags**: Use `--fill` to automatically pull titles/body from commits, or draft a quick summary based on the commit history of the branch.
   - Example: `gh pr create --title "feat: <summary>" --body "Automated PR via OpenCode pr skill."`

## Safety Rail
- Never force push (`-f`).
- If `gh` CLI is not installed, notify the user and provide the URL to the web-based PR creation instead.