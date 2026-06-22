---
name: linear-search
description: Search Linear issues, projects, and team metadata. Use for deduplication, checking labels, or finding existing work before creating new issues.
---

# Linear Search & Triage

Use this skill when you need to search for existing issues, verify if a task is already tracked, or look up team metadata like labels, statuses, or cycle information.

## Activation Rule
- Use when the user asks "Do we have a ticket for X?", "Search for Y", or "What labels can I use?".
- **Branch-Awareness**: Always prioritize results that match the current Git branch ID if one exists.
- This is the primary utility skill for deduplication before creating any new issues.

## Search Workflow
1. **Clarify**: Ask for keywords if the search is too vague.
2. **Execute**: Use `linear_list_issues` or `linear_search_documentation` (or project/team tools).
3. **Present**:
   - List the top 5 results in a numbered list (e.g., `1. [LIN-123] Title (State)`).
   - List options (e.g., `1. View Details`, `2. Refine Search`, `3. Use for Issue Creation`).
   - Call the `question` tool with these options.
4. **Detail View**: If requested, fetch full issue/project details using `linear_get_issue` or `linear_get_project`.

## Metadata Lookup
- To list labels, use `linear_list_issue_labels`.
- To list users, use `linear_list_users`.
- To list teams, use `linear_list_teams`.
- To check team status or cycle, use `linear_list_issue_statuses` or `linear_list_cycles`.
- Always present the output as a clean, numbered list followed by the next possible actions using the `question` tool.
