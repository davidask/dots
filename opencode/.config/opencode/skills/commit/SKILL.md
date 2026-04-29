---
name: commit
description: Inspects repo state, stages intended changes, and creates a Conventional Commit.
compatibility: opencode
---

# Commit Workflow
Use this skill only when the user explicitly asks to create a commit in the current message. Skill usage is single-request scoped: after the commit workflow finishes, do not assume future messages also authorize commits.

## Activation Rule
- Do not create any commit unless the current user message explicitly requests a commit.
- Do not treat prior commit requests as ongoing authorization for later turns.
- After completing this workflow, return to normal editing behavior with no auto-commit state.
- If the user gives new implementation instructions after a commit, make the changes but do not commit them unless they explicitly ask again.
- If it is unclear whether the user wants a commit, ask: `Do you want me to commit these changes too?`

## Step-by-Step Execution
1. **Inspect repo state**:
   - Run `git status` to understand tracked, untracked, staged, and unstaged changes.
   - Run `git diff --cached` and `git diff` to understand what will be committed and what is still unstaged.
   - Run `git log --oneline -5` to follow the repository's recent commit style.
2. **Stage intentionally**:
   - If the user specified files, only stage those files.
   - Otherwise, stage only the changes that are clearly part of the requested work.
   - Do not blindly run `git add .` in a dirty worktree.
   - Do not stage files that likely contain secrets.
3. **Draft the commit message**:
   - Generate a concise Conventional Commit subject that describes the purpose of the change.
   - Focus on the reason for the change, not a file-by-file summary.
   - If the current branch name contains an issue identifier like `ENG-247`, keep the subject clean and add a footer such as `Refs ENG-247`.
4. **Commit**:
   - Run `git diff --cached` again before committing to verify the staged contents are correct.
   - Run `git commit -m "<subject>" -m "Refs ISSUE-ID"` when an issue reference is available.
   - If there is no issue reference, use a single `-m` message unless a body is genuinely helpful.
5. **Verify**:
   - Run `git status` after the commit completes.
   - If there is nothing to commit, stop and report that cleanly.

## Safety Rails
- Never commit unrelated changes just because they are present in the worktree.
- Never use `git add .` as the default staging strategy.
- Never amend a commit unless the user explicitly asks or a new commit created in the current session needs hook-generated fixes included and it is still safe to amend.
- If hooks fail, surface the failure and follow the repository workflow instead of forcing the commit through.
