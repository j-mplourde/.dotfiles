# Development Guidelines for Claude

> v4.0.0 — Posture only. Language-specific patterns live in skills and load on demand.

## Core Philosophy

**TEST-DRIVEN DEVELOPMENT IS NON-NEGOTIABLE.** Every line of production code is written in
response to a failing test. No exceptions. This is not a preference — it is the practice that
makes every other rule here enforceable.

Work proceeds in small increments, each leaving the codebase in a working state.

## The Loop

- **RED** — write a failing test that states a behavior. No production code before it fails.
- **GREEN** — write the minimum code that passes. Nothing more.
- **REFACTOR** — assess. Refactor only when it adds value; "no change" is a valid outcome.

Never commit without my approval. Ask, every time.

## Testing

Test behavior, not implementation. Full coverage *through* business behavior, never by reaching
for internals.

- Exercise the public API exclusively. If a behavior is unreachable from outside, question why it exists.
- Build test data with factory functions taking overrides — not mutable fixtures reassigned in setup hooks.
- Use the real types and schemas the production code uses. Never redefine a shape inside a test.
- A test name states the expected business behavior, not the function it calls.
- No 1:1 mapping between test files and source files. Organize tests by behavior.

## Code

- Immutable data. Build new values; do not mutate arguments, fields, or shared state.
- Pure functions by default. Push side effects to the edges.
- No nested conditionals. Use early returns, guard clauses, or composition.
- Prefer declarative transformations over manual loops where the language offers them.
- Named options over long positional parameter lists.
- Self-documenting names.

### Type systems

Never escape the type system. No `any`, no unchecked casts or assertions, no `# type: ignore`,
no bare `interface{}`, no `unsafe` reached for out of convenience. If a type is genuinely
unknown, use the language's honest "unknown" and narrow it.

Validate at trust boundaries — parse external input into a known shape once, then rely on types
inside. Derive types from schemas rather than maintaining both by hand.

### Comments

A comment explains *why*: a constraint, an invariant, a bug being worked around.

Never reference planning artifacts in source code — no task numbers ("6.31"), no `design.md`,
`proposal.md`, or `spec.md`. Those get renumbered and archived; the comment rots. A comment
must make sense to someone who has never seen the plan. Commit messages and `tasks.md` are the
right place for task references.

## Languages

Load the skill matching the language you are working in before writing code in it.

When no skill exists for a language, every rule above still applies — express it in that
language's idiom, follow the ecosystem's dominant formatter and style guide without being
asked, and tell me the skill is missing so we can write one.

## Working With Me

- Think before acting. Read the surrounding code and match its idiom.
- Assess refactoring after every green.
- Capture learnings while context is fresh — gotchas, decisions, edge cases. Ask "what do I
  wish I'd known at the start?" after significant work, and propose updates to this file.
- For significant work, load the `planning` skill.

## Browser Automation

Use `agent-browser` when it is installed:
`open <url>` → `snapshot -i` (returns refs like `@e1`) → `click @e1` / `fill @e2 "text"` →
re-snapshot after the page changes. `agent-browser --help` for the rest.

If it is not installed, say so once and fall back to `WebFetch`, `curl`, or an MCP browser tool.
