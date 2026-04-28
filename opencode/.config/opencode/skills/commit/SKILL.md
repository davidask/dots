---
name: commit
description: Stages changes and generates a Conventional Commit message based on the diff.
compatibility: opencode
---

# Commit Workflow
Use this skill to stage changes and create a semantic commit.

## Step-by-Step Execution
1. **Stage**: Run `git add .` (unless the user specified specific files).
2. **Analyze**: Run `git diff --cached` to analyze the staged changes.
3. **Commit**: 
   - Generate a concise **Conventional Commit** message based on the analysis. Focus on the 'why' rather than just the 'what'.
   - Run `git commit -m "<message>"`.