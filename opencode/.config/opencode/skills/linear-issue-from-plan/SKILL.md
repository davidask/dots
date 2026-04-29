---
name: linear-issue-from-plan
description: Checks for matching open Linear issues, drafts a simple issue from the current session plan, and checks out the issue branch.
compatibility: opencode
---

# Linear Issue From Plan Workflow
Use this skill when the current OpenCode session has reached a settled implementation plan and you want to turn that plan into a Linear issue and local branch.

## Default Source Of Truth
- Use the current OpenCode session as the default source of the plan.
- Do not require the user to paste the plan again unless they explicitly want to override the source text.
- If the session is still brainstorming or the plan is ambiguous, stop and ask for a clearer plan instead of drafting an issue.

## Step-by-Step Execution
1. **Resolve the plan and metadata**:
   - Summarize the settled implementation plan from the current session.
   - Infer or ask for required metadata such as `team`.
   - Default the assignee to `me` when creating a new issue unless the user explicitly requests someone else or no assignee.
   - Inspect the repository where the skill is being used to suggest a small set of likely labels.
   - Base label suggestions on the active repository's structure, naming, touched files, package or workspace names, and other clear project-specific domains.
   - Prefer existing Linear labels when the repository context maps cleanly onto labels already used by the team.
   - Accept optional metadata such as `project`, `assignee`, `priority`, `labels`, or `state` when the user provides it.
2. **Check for matching open issues**:
   - Search open Linear issues for likely matches using the current plan.
   - Prefer the specified team when it is known.
   - Narrow by project if the user supplied one.
   - Show only the top likely matches with minimal context: issue ID, title, state, and a short reason it looks related.
   - Never auto-select an existing issue.
3. **Choose reuse or create**:
   - Ask the user whether to use an existing issue, create a new issue, or refine the search.
   - If the user chooses an existing issue, fetch its details and proceed to branch checkout.
4. **Draft a new issue when needed**:
   - Draft a concise, action-oriented title.
   - Draft a simple body from the settled plan.
   - Prefer a short paragraph.
   - Add a few short bullets only when the plan naturally breaks into concrete steps.
   - Avoid rigid templates and verbose section headers.
   - Include the suggested labels in the review step as recommendations, not automatic choices.
5. **Review before creation**:
   - Show the proposed title, body, resolved metadata, and suggested labels.
   - Ask for explicit confirmation before creating anything.
6. **Create the issue**:
   - Create the Linear issue only after the user confirms.
   - Assign the issue to `me` by default during creation unless the user chose a different assignee.
   - Apply the user-approved labels during creation.
   - Preserve the simple draft style instead of expanding it into a long template.
7. **Check out the associated branch**:
   - Fetch the issue details after creation or selection.
   - Read the associated branch name from the issue details.
   - If the branch does not exist locally, run `git checkout -b "<branch-name>"`.
   - If the branch already exists locally, run `git checkout "<branch-name>"`.
   - If no branch name is available from Linear, stop and ask instead of inventing one silently.

## Safety Rails
- Do not create a new issue if the plan is still ambiguous.
- Do not create a likely duplicate issue without showing the search results first.
- Search open issues only by default to avoid noisy historical matches.
- Default new issues to `me` as the assignee unless the user says otherwise.
- Suggest labels from the active repository context, but do not apply them without showing them first.
- If required metadata cannot be inferred safely, ask before proceeding.
