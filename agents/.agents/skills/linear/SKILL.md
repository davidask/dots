---
name: linear
description: Decision guide for Linear skills. Use to pick the right workflow: `linear-issue-from-git` (dirty tree), `linear-issue-from-plan` (clean tree, planning), `linear-search` (dedup), `linear-project-from-notes` (structuring). Or use Linear MCP tools directly for general CRUD.
---

# Linear

Structured workflow for managing issues, projects, and team workflows in Linear via the Linear MCP server.

## Prerequisites

Linear MCP server must be accessible. Confirm connectivity before using Linear tools.

## Required Workflow

### Step 1: Clarify
Confirm the user's goal and scope (issue triage, sprint planning, documentation audit, workload balance). Verify team, project, priority, labels, cycle, and due dates as needed.

### Step 2: Select Workflow

Pick the right skill based on intent. The choice is mechanical — the agent decides, not the user.

| Intent | Skill |
|---|---|
| I have uncommitted code to track | `linear-issue-from-git` |
| Let's plan a feature / draft a ticket | `linear-issue-from-plan` |
| Search for existing issues (dedup) | `linear-search` |
| Structure rough project notes | `linear-project-from-notes` |
| General CRUD (read, update, comment) | Use Linear MCP tools directly |

**Decision shortcut**: Run `git status` first.
- Dirty working tree → `linear-issue-from-git` (diff drives the issue, auto-pilot to commit + PR)
- Clean tree → `linear-issue-from-plan` (conversation drives the issue, may sub into `grill-me`)

The composability chain is: `linear-project-from-notes` → `linear-issue-from-plan` (+ `grill-me` for vague requests) → `linear-issue-from-git` → `git-commit` → `pr`.

### Step 3: Execute
Execute Linear MCP tool calls in logical order:
- Read first (list/get/search) to build context.
- Create or update next with all required fields.
- For bulk operations, explain grouping before applying.

### Step 4: Summarize
Summarize results, call out remaining gaps or blockers, and propose next actions.

## Available Tools

Issue Management: `linear_list_issues`, `linear_get_issue`, `linear_save_issue`, `linear_list_issue_statuses`, `linear_list_issue_labels`, `linear_create_issue_label`

Project & Team: `linear_list_projects`, `linear_get_project`, `linear_save_project`, `linear_list_teams`, `linear_get_team`, `linear_list_users`

Documentation & Collaboration: `linear_list_documents`, `linear_get_document`, `linear_search_documentation`, `linear_list_comments`, `linear_save_comment`, `linear_list_cycles`

## Practical Workflows

- Sprint Planning: Review open issues for a team, pick top items by priority, create a cycle with assignments.
- Bug Triage: List critical/high-priority bugs, rank by impact, move top items to In Progress.
- Documentation Audit: Search documentation, then open labeled issues for gaps or outdated sections.
- Team Workload Balance: Group active issues by assignee, flag overloaded members, suggest redistributions.
- Release Planning: Create a project with milestones (feature freeze, beta, docs, launch) and generate tracked issues.
- Cross-Project Dependencies: Find all blocked issues, identify blockers, create linked issues if missing.
- Smart Labeling: Analyze unlabeled issues, suggest or apply labels, create missing categories.
- Sprint Retrospectives: Generate a report for the last completed cycle, note completed vs. pushed work, open discussion issues for patterns.

## Tips

- Batch operations for related changes.
- Use natural queries when possible.
- Leverage context: reference prior issues in new requests.
- Break large updates into smaller batches.
