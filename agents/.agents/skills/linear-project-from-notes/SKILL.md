---
name: linear-project-from-notes
description: Turn rough project notes into a concise Linear-ready project brief with a problem statement, outcome-oriented objectives, and concrete deliverables.
---

# Linear Project From Notes

Use this skill when the user has rough notes, partial framing, or unclear planning language and wants help turning it into a clean project description. Treat this as a writing-and-structuring skill, not just a paraphrasing skill.

## Activation Rule
- Use when the user wants to draft or refine a Linear project brief.
- Prefer this skill when the user needs help separating background, problem, objectives, and deliverables.
- Do not assume the first draft is well-structured. Refinement is part of the task.

## Output Shape
Produce a concise draft with these headings:
- `Problem statement`
- `Objectives`
- `Outline of deliverables`

Add these sections when they materially improve clarity for reorganization, migration, consolidation, or architecture-heavy projects:
- `Target structure`
- `Migration mapping`

## Step-by-Step Execution

1. Resolve the raw inputs:
   - Use the current conversation as the default source of truth.
   - If the brief is too vague, ask the user for the project name and rough notes.
   - Ask or infer the project phase: discovery, validation, pilot, or delivery.
   - Ask or infer tone constraints: executive, neutral, technical, direct, or low-drama.

2. Separate the input into planning layers:
   - Background or context
   - Actual problem
   - Scope and phase
   - Objectives
   - Deliverables
   - Dependencies and assumptions

3. Draft the problem statement carefully:
   - Name what is currently unclear, missing, or preventing confident action.
   - Explain why resolving that matters.
   - Do not write a project summary disguised as a problem statement.
   - If the draft is actually rationale or background, rewrite it.
   - If the project depends on another project, team, or enabling effort, state that explicitly.

4. Draft objectives aligned to the phase:
   - For discovery work, focus on assessing, exploring, evaluating, identifying, and prioritizing.
   - For later phases, allow more implementation-oriented language.
   - Keep objectives outcome-oriented but realistic for the phase.
   - Objectives should describe business, operational, or team impact rather than implementation steps.
   - Prefer measurable or at least observable success conditions when the user provides enough context.

5. Draft deliverables as concrete artifacts:
   - Use outputs such as assessments, hypothesis sets, shortlists, frameworks, recommendations, or pilot proposals.
   - Do not present full implementation or productionization as a deliverable unless the phase clearly requires it.
   - For execution-oriented projects, prefer concrete outputs: target structures, migration plans, rollout sequencing, dependency maps, ownership conventions, or operating model changes.
   - When the work is about reorganization or consolidation, show the future state as explicitly as possible.

6. Critique and refine:
   - Check whether each section has a distinct role.
   - Ensure the problem statement is not just context.
   - Ensure objectives are outcomes, not workstreams.
   - Ensure deliverables are outputs or changes, not outcomes.
   - Remove names, org-history, and unnecessary backstory unless explicitly requested.
   - Prefer the real system shape over inherited repository names or historical wrappers when describing target state.
   - Tighten wording for concise Linear-style readability.

## Heuristics
- If the problem statement begins with "we now have", it is likely background rather than a problem.
- If objectives for a discovery project sound like commitments to build or launch, soften them toward exploration and prioritization.
- If deliverables describe business outcomes instead of project outputs, convert them into artifacts.
- If objectives read like tasks or migrations, rewrite them as outcomes or success conditions.
- If the proposed target structure simply mirrors source repositories, question whether those boundaries are meaningful in the target state.
- If another project is a real dependency, name it explicitly rather than leaving it implicit.
- If the target state is hard to visualize, add a structure section or mapping section.
- Prefer constructive language over dramatic or threatening framing unless the user explicitly wants sharper risk language.

## Linear Formatting
- Optimize for how Linear renders markdown, not for generic markdown elegance.
- Keep formatting simple and robust.
- Use fenced code blocks for target structures, tree layouts, or configuration-like examples.
- Prefer numbered lists for durable list rendering in major sections.
- Avoid overusing nested bullets if the same content can be made clearer with short paragraphs, numbered lists, or code blocks.

## Safety Rails
- Do not invent domain facts that were not provided.
- If the project phase is ambiguous and materially affects the framing, ask before finalizing.
- If the user asks for a "problem statement", treat that as a request to identify the actual gap or uncertainty, not to summarize the initiative.
- Do not preserve legacy repository wrappers, naming, or structure in the target state without checking whether they still serve a purpose.
- Keep the result concise and easy to paste into Linear.
- The final text must be proofread and approved by the user before creating or updating a Linear project.

## Next Steps
- Once the project brief is approved, offer to break down the first phase of deliverables into trackable issues using the `linear-issue-from-plan` skill.
