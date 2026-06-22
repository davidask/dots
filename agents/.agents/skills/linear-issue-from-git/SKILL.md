---
name: linear-issue-from-git
description: Create or sync a Linear issue from code changes relative to master. Diff and commit log drive the issue title, description, and solution comment. Not for planning discussions — use linear-issue-from-plan for that.
---

# Linear Issue From Git

## When to Use

- You have code changes — uncommitted, staged, or committed ahead of master — and want a Linear issue from them.
- You're mid-coding and need to track what you've built.
- You've been told to "create a ticket for this."

**Not** when you're just planning with no code. If there's no diff from master and you're discussing ideas, use `linear-issue-from-plan` instead.

## Mandatory Rules

- **Auto-Pilot Flow**: Once the issue is created, commit via `git-commit` then load `pr`. No "want to commit/PR?" prompt — this is the expected path. Do not loop back to ask for permission.

- **Branch Check**:
  1. Run `git merge-base --is-ancestor HEAD master` to detect if HEAD is already in master history.
  2. If HEAD is an ancestor of master (no unique commits on branch), or we're on `main`/`master`: create the issue, then branch off using the returned `gitBranchName` before committing.
  3. If we're on a feature branch with commits ahead of master: fetch existing issue details if a Linear ID is present in the branch name (match any `<TEAM-KEY>-<NUMBER>` pattern). Update the existing issue instead of creating a new one.

- **Separation of Problem and Solution**:
  - The issue **Description** must contain only the Problem statement.
  - The technical **Solution** must go into an issue **Comment**.

- **Proofreading Gate**: Do NOT ask the user to proofread the draft by default. Only ask if the diff touches multiple unrelated concerns (e.g., refactor + dep bump + typo fix). In that case, present the grouped options and let the user decide how to split.

- **Team Resolution**: The Linear team is never hard-coded. Determine it like this:
  1. Check if the repo's AGENTS.md specifies a default Linear team. If found, use it silently — no asking.
  2. Otherwise, run `linear_list_teams`, present the options to the user via the `question` tool. Ask once per session and reuse.

- **Assignee**: Do not ask. Leave unassigned. The user can assign at review time.

## Step-by-Step Execution

1. **Verify Branch**: Identify the current branch. Determine if HEAD has commits ahead of master using `git merge-base --is-ancestor HEAD master`.
2. **Resolve Team**: Determine the Linear team (see Team Resolution above).
3. **Get Git Diff & Log**:
   - Compute `MERGE_BASE=$(git merge-base master HEAD 2>/dev/null || git merge-base main HEAD)`.
   - Run `git diff $MERGE_BASE` as the primary diff; fall back to `git diff master` or `git diff`.
   - Run `git log $MERGE_BASE..HEAD --oneline` to collect commit messages for context.
   - Use the full diff + commit log to draft the issue content.
4. **Draft Description & Comment**: Draft a Problem description and a Technical Solution comment from the diff and commit log.
5. **Check for Multi-Concern Diff**: If the diff touches clearly unrelated areas, use the `question` tool to ask the user how to group into issues. Otherwise skip to step 6.
6. **Create or Update Issue**:
   - If an existing Linear ID was found in the branch name (step 3 of Branch Check), update it with `linear_save_issue` passing `id`.
   - Otherwise, create a new issue with `linear_save_issue` using `title`, `team`, `description`. Do not pass `assignee`.
7. **Add Solution Comment**: Take the returned issue ID and call `linear_save_comment` with the technical solution.
8. **Branch & Commit**:
   - If HEAD is an ancestor of master (no unique commits), create a branch with `git checkout -b <gitBranchName>`.
   - If working tree is dirty, run `git-commit`. Skip if already clean.
   - Load the `pr` skill.
   - **Handoff note**: The issue description (step 4) was written from `git diff $MERGE_BASE` which includes all changes (staged, unstaged, committed). The `pr` skill MUST derive the PR body from a fresh `git diff $MERGE_BASE...HEAD` (committed changes only), NOT from this issue description. Unstaged work in the original diff may not be part of the PR.
