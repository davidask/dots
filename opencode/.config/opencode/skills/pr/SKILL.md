---
name: pr
description: Pushes the current branch and creates a GitHub PR.
compatibility: opencode
---

# PR Workflow
Use this skill only when the user explicitly asks to create a PR in the current message. Skill usage is single-request scoped: after the PR workflow finishes, do not assume future messages also authorize PR creation or pushing.

## Activation Rule
- Do not create a PR unless the current user message explicitly requests a PR.
- Do not push any branch unless the current user message explicitly instructs you to push.
- Do not treat prior PR or push requests as ongoing authorization for later turns.
- After completing this workflow, return to normal editing behavior with no auto-PR or auto-push state.
- If the user asks to create a PR but does not explicitly authorize pushing, stop and ask: `Do you want me to push this branch and open the PR?`
- If the user gives new implementation instructions after a PR or push, make the changes but do not push or create another PR unless they explicitly ask again.

## Step-by-Step Execution
1. **Inspect branch state**:
   - Run `git status` to understand the current worktree.
   - Determine the current branch and stop if it is `main` or `master`.
   - Check whether the branch already tracks a remote branch and whether it is ahead, behind, or up to date.
2. **Analyze the full branch**:
   - Identify the base branch.
   - Run a diff from the base branch to `HEAD` to understand the full change set that will be reviewed.
   - Review the commits on the branch, not just the latest commit.
3. **Draft the PR content**:
   - Write a concise title based on the branch's overall purpose.
   - Write a specific PR body using the actual changes on the branch.
   - Keep the body code-focused and brief.
   - Use sections:
     - `## Summary`
     - `## Testing`
4. **Push if needed**:
   - Only push when the current user message explicitly authorizes pushing.
   - If the user requested a PR but did not explicitly authorize pushing, stop and ask for confirmation before any push.
   - If the remote branch does not exist, use `git push -u origin HEAD`.
   - Otherwise, use `git push origin HEAD` when the branch is ahead of remote.
5. **Create the PR**:
   - Use `gh pr create --title "<title>" --body "<body>"`.
   - Prefer an explicit title and body over `--fill`.

## Safety Rail
- Never force push (`-f`).
- Never open a PR from `main` or `master`.
- Never push to any remote without explicit user instruction in the current message.
- If `gh` CLI is not installed, notify the user and provide the URL to the web-based PR creation instead.
