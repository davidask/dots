---
name: request-pr-review
description: Request a PR review on GitHub using friendly teammate names. Responds to: "request a review from X", "ask Y to review", "add Z as reviewer".
---

# Request PR Review Workflow

Use this skill when the user asks to request a pull request review from one or more teammates for the current branch or a specific PR.

## Mandatory Rules
- **Identity Resolution**: Before calling any command, use the `collaborators` skill to resolve friendly names to their exact GitHub usernames.
- **If Unresolved**: If a name cannot be resolved, ask the user for their GitHub username.
- **Current Branch Focus**: By default, look up the active PR for the current local branch using `gh pr view --json number`.
- **Review Request Command**: To request a review, execute:
  ```bash
  gh pr edit --add-reviewer <resolved-github-username>
  ```
  *(or `gh pr edit <number> --add-reviewer <resolved-github-username>` if a specific PR is targeted)*

## Step-by-Step Execution
1. **Identify Target PR**: Check if the user specified a PR or URL. Otherwise, detect the current git branch and find its active pull request.
2. **Resolve Reviewers**: Map each requested name to their GitHub username using the `collaborators` skill.
3. **Execute**: Run the `gh pr edit` command to add the reviewers.
4. **Confirm**: Report the request clearly:
   `Requested review from <Name> (@<username>) on PR #<number>.`
