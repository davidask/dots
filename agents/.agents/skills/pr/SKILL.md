---
name: pr
description: Push the current branch and open a GitHub PR. Responds to: "create a PR", "open a pull request".
---

# PR Workflow

Use this skill only when the user explicitly requests to push or open a PR in the current turn.

## Mandatory Rules
- **Explicit Authorization Only**: Never push a branch or create a PR unless explicitly instructed in the current message. If asked to create a PR but pushing is unauthorized, stop and ask: `Do you want me to push this branch and open the PR?`
- **Sanity Checks**: Never open a PR from `main` or `master`. Never use force push (`-f`).
- **Standardized PR Title**: PR titles must be plain-English and start with an imperative action verb.
  - *With linked issue*: `<ISSUE-ID>: <Imperative Action> <summary>` (e.g., `TEC-123: Simplify and modularize agent skills`). Detect the issue ID from the branch name or from a linked Linear issue.
  - *Without linked issue*: `<Imperative Action> <summary>` (e.g., `Simplify and modularize agent skills`).
- **No Raw Output**: Never paste raw test logs, command output, stack traces, build dumps, or terminal transcripts into the PR body.
- **Fresh Diff Only for PR Body**: The PR body MUST be written from a fresh `git diff <base>...HEAD` (3-dot) run during this skill's execution. Never reuse, summarize, or paraphrase earlier issue descriptions, solution comments, or any analysis done by a prior skill. The Linear issue description may cover a broader scope than what's actually committed — the PR body must only describe changes visible in the fresh diff.

## PR Body Format
Keep the body brief, code-focused, and written by you (not copied from a terminal). Use exactly these two sections:

```
## Summary
- <what changed and why, 1-3 bullets>

## Testing
- <list of checks performed, one line each>
```

- `## Summary`: 1-3 bullets describing what changed and why.
- `## Testing`: a short bullet list of checks performed. No pasted output.

## Step-by-Step Execution
1. **Inspect branch state**:
   - Run `git status` to understand the current worktree.
   - Determine the current branch and stop if it is `main` or `master`.
   - Check whether the branch already tracks a remote branch and whether it is ahead, behind, or up to date.
2. **Detect linked issue**: Check the branch name for a `<TEAM-KEY>-<NUMBER>` pattern. If found, use it in the PR title.
3. **Analyze the full branch**:
   - Identify the base branch (usually `master` or `main`).
   - Compute `MERGE_BASE=$(git merge-base "$BASE" HEAD)`.
   - Run `git diff $MERGE_BASE...HEAD` (3-dot — committed changes only). This is the **only** diff that may inform the PR body. Ignore uncommitted changes.
   - Review all commits on the branch with `git log $MERGE_BASE..HEAD --oneline`, not just the latest.
4. **Draft the PR content**:
   - Write a concise title following the standardized format above.
   - Write a specific body from the fresh diff only. If something appeared in the Linear issue but is absent from `git diff $MERGE_BASE...HEAD`, omit it — it was not part of this PR.
5. **Push if needed**:
   - Only push when the current user message explicitly authorizes pushing.
   - If the user requested a PR but did not explicitly authorize pushing, stop and ask for confirmation before any push.
   - If the remote branch does not exist, use `git push -u origin HEAD`.
   - Otherwise, use `git push origin HEAD`.
6. **Create the PR**:
   - Use `gh pr create --title "<title>" --body "<body>"`.
   - Prefer an explicit title and body over `--fill`.
7. **Offer to view the PR**:
   - After creating the PR, ask whether the user wants to view it in the browser. If yes, run `gh pr view --web`.
8. **Request Reviews**:
   - If the user specifies reviewers, load the `request-pr-review` skill once the PR has been opened. Use the `collaborators` skill to resolve friendly names to GitHub usernames.
