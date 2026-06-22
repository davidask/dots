---
name: collaborators
description: Dynamically resolve teammate identities across GitHub and Linear. Use when skills need to look up assignees, reviewers, or team members without hard-coded mappings.
---

# Collaborators

Dynamic identity resolution. Works with any GitHub organization or Linear team. No hard-coded identity tables.

## GitHub Resolution

1. Detect the GitHub organization from the current repo:
   ```bash
   git remote get-url origin | sed -E 's|.*github\.com[:/]([^/]+)/.*|\1|'
   ```
2. Fetch organization members:
   ```bash
   gh api graphql -f query='query($org:String!) { organization(login:$org) { membersWithRole(first:50) { nodes { login name } } } }' -F org=<ORG>
   ```
3. Match user-provided name fragments against `login` and `name` fields.

## Linear Resolution

1. Determine the active Linear team (from project context or by asking `linear_list_teams`).
2. Call `linear_list_users` filtered by that team.
3. Match by `name`, `displayName`, or `email`.

## Cross-Referencing

When resolving a person for both platforms, cache the GitHub ↔ Linear mapping for the session.
