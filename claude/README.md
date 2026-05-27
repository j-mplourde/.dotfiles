# Claude Code Configuration

My personal Claude Code setup: a lean `CLAUDE.md` plus a collection of on-demand skills.

The `CLAUDE.md` and the original `tdd` skill are adapted from [citypaul/.dotfiles](https://github.com/citypaul/.dotfiles). I've since trimmed them and added skills of my own.

## Skills

Claude Code auto-discovers these and loads them on demand when relevant. Each lives in [`.claude/skills/<name>/SKILL.md`](.claude/skills).

| Skill | Covers |
|-------|--------|
| [`tdd`](.claude/skills/tdd/SKILL.md) | Test-Driven Development workflow (RED–GREEN–REFACTOR) |
| [`testing`](.claude/skills/testing/SKILL.md) | Behavior-driven testing patterns and factories |
| [`test-design-reviewer`](.claude/skills/test-design-reviewer/SKILL.md) | Test-quality review via Dave Farley's 8 properties |
| [`mutation-testing`](.claude/skills/mutation-testing/SKILL.md) | Verifying test effectiveness; finding weak or missing tests |
| [`front-end-testing`](.claude/skills/front-end-testing/SKILL.md) | Framework-agnostic DOM Testing Library patterns |
| [`react-testing`](.claude/skills/react-testing/SKILL.md) | React Testing Library: components, hooks, context |
| [`python-testing`](.claude/skills/python-testing/SKILL.md) | Python testing patterns |
| [`typescript-strict`](.claude/skills/typescript-strict/SKILL.md) | TypeScript strict-mode patterns |
| [`functional`](.claude/skills/functional/SKILL.md) | Functional programming with immutable data |
| [`refactoring`](.claude/skills/refactoring/SKILL.md) | Refactoring assessment and patterns (post-GREEN) |
| [`cpp-coding-standards`](.claude/skills/cpp-coding-standards/SKILL.md) | Modern, safe C++ per the C++ Core Guidelines |
| [`planning`](.claude/skills/planning/SKILL.md) | Planning work in small, known-good increments |
| [`expectations`](.claude/skills/expectations/SKILL.md) | Capturing learnings and documentation practices |

## Disclaimer

These configs are my personal preferences, shared as-is. I don't guarantee anything: not correctness, not fitness for any purpose, not that they'll work for you. Review everything before using it and adapt it to your own workflow.

## Reviewing & installing skills

I use [skills.sh](https://www.skills.sh/) to review and install skills from other repositories. For example, to add a single skill from another repo:

```bash
npx skills add https://github.com/affaan-m/everything-claude-code --skill cpp-coding-standards
```
