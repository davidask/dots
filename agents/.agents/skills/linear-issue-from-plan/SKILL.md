---
name: linear-issue-from-plan
description: Create a Linear issue from planning conversations. Use when git status is clean and you're discussing features, architecture, or new ideas. The conversation drives the issue. Not for uncommitted code — use linear-issue-from-git for that.
---

# Linear Issue From Planning

## When to Use

- You want to create a Linear issue from a conversation, feature request, or architectural discussion.
- Your working tree is clean (no uncommitted changes).
- You're in planning mode: "let's draft a ticket", "I have an idea for...", "we should..."

**Not** when you already have code changes. If `git status` shows a dirty tree, redirect to `linear-issue-from-git` — code changes already tell the story.

## Mandatory Rules

- **Problem-Oriented Description**: The issue description must only be the Problem or Opportunity statement.
- **Solution Placement**: The technical plan (how you intend to solve it) must go in an Issue Comment or initial PR description.
- **Clarify via grill-me**: If the request is vague or ambiguous (e.g., "Add a button", "We need better caching"), load the `grill-me` skill to stress-test and clarify before creating. If the conversation already contains a clear, well-understood plan, skip this — no extra ceremony.
- **Proofreading**: Do not ask for explicit proofreading. The conversation + grill-me session is sufficient.
- **Assignee**: Do not ask. Leave unassigned.
- **Team Resolution**: The Linear team is never hard-coded. Determine it like this:
  1. Check if the repo's AGENTS.md specifies a default Linear team. If found, use it silently — no asking.
  2. Otherwise, run `linear_list_teams`, present the options to the user via the `question` tool. Ask once per session and reuse.
- **Git State Safety**: Before starting, check for uncommitted changes. If any exist, inform the user that `linear-issue-from-git` is the correct tool for tracking current work and redirect to it.
- **No Master Commits**: Never propose or perform a commit on `main` or `master`. If on main/master, proactively offer to create a feature branch before continuing.

## Execution Steps

1. **Validate Context**: Run `git status`. If the working tree is dirty, redirect to `linear-issue-from-git`.
2. **Resolve Team**: Determine the Linear team (see Team Resolution above). Ask once and reuse for the session.
3. **Clarify (if needed)**: If the user's request is vague, load `grill-me` to sharpen it. If the plan is already clear, proceed directly.
4. **Search**: Load and execute the `linear-search` skill to identify duplicates or existing issues.
5. **Create**: Use `linear_save_issue` with `title`, `team`, `description`. Do not pass `assignee` or `id`.
6. **Onboard**: Proactively offer to checkout a new branch (from `main` or `master`) and begin implementation.
