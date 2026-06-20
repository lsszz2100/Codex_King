# 부록 — 이미지 생성 프롬프트 모음 (gpt-image-2)

> 본 책의 그림은 gpt-image-2로 생성하도록 설계되었습니다.
> 아래 프롬프트를 그대로 이미지 생성에 입력한 뒤, 결과를 `book/images/` 에 같은 파일명으로 저장하세요.
> 공통 스타일을 일관되게 유지하려면 각 프롬프트 끝에 [공통 스타일] 문장을 함께 붙이세요.

[공통 스타일]
> Clean modern flat-illustration / isometric tech style, soft gradient background (teal-to-indigo, no purple-on-white cliché), bold but friendly, minimal text in English labels only, high contrast, 16:9, suitable for a programming book. Avoid clutter and "AI slop" generic look.

---

## 표지
- 파일명: `images/cover.png`
- 프롬프트: A striking book cover illustration for "GPT & Codex from Beginner to Advanced 100". A developer and a glowing AI agent robot pair-programming at a terminal, lines of code flowing into a finished web app. Title space at top. Confident, premium, modern. [공통 스타일]

## Part 0
- `images/001_intro.png` — A human and an AI agent collaboratively coding; the AI reads files, edits code, runs tests, shown as a friendly loop of arrows. Sense of partnership. [공통 스타일]
- `images/002_roadmap.png` — A staircase roadmap rising from "Beginner" to "Intermediate" to "Advanced" to "Real Project", each step labeled, a climber ascending. [공통 스타일]
- `images/003_taskflow_preview.png` — A clean mockup of a to-do SaaS web app called "TaskFlow": task list with checkboxes, due dates, an AI "Suggest priority" button highlighted. [공통 스타일]
- `images/004_glossary.png` — A neat grid of icon-labeled concept cards: Token, Context Window, Agent, Sandbox, MCP, Skill, Hook. Dictionary/glossary feel. [공통 스타일]

## Part 1 (초급)
- `images/005_llm.png` — Visualization of a language model predicting the next word: a sentence with a glowing blank being filled, probability bars. [공통 스타일]
- `images/006_gpt55.png` — A radar/strength chart for "GPT-5.5" with axes: Coding, Reasoning, Tool Use, Computer Use, Long tasks. Flagship, powerful vibe. [공통 스타일]
- `images/007_model_select.png` — A decision diagram matching tasks to models (gpt-5.5 / 5.4 / mini / spark) along a triangle of Quality–Speed–Cost. [공통 스타일]
- `images/008_tokens.png` — A sentence being chopped into token pieces flowing into a bounded box labeled "Context Window", a meter showing it filling up. [공통 스타일]
- `images/009_three_ways.png` — Three side-by-side panels: "ChatGPT (chat)", "API (building block)", "Codex (agent with hands)". Clear contrast. [공통 스타일]
- `images/010_codex.png` — A coding agent robot with hands actively reading a file, editing code, and running a terminal, arranged in a cycle. [공통 스타일]
- `images/011_four_faces.png` — Four faces of Codex: CLI (terminal), App (desktop window), IDE (editor), Cloud (server/github), all sharing one central "brain". [공통 스타일]

### Part 1 (초급 · 설치~마무리)
- `images/012_setup.png` — A checklist of prerequisites: OpenAI account, paid plan/API key, terminal window, ready to go. [공통 스타일]
- `images/013_install.png` — Three installation paths (script, package manager, direct download) leading to a single installed CLI badge, OS logos (mac/linux/windows). [공통 스타일]
- `images/014_login.png` — A login flow: terminal `codex login` → browser ChatGPT auth → success checkmark back in terminal. [공통 스타일]
- `images/015_hello.png` — A first friendly chat between a user and the Codex agent in a terminal, a file being created. [공통 스타일]
- `images/016_tui.png` — An annotated diagram of the Codex terminal UI: conversation area, status bar (model/tokens/cwd), input box. [공통 스타일]
- `images/017_firstcode.png` — The loop "instruct → generate → run → improve" around a small python script. [공통 스타일]
- `images/018_edit.png` — An agent precisely editing a file, highlighting only the changed lines (apply_patch concept). [공통 스타일]
- `images/019_approval.png` — A safety approval prompt before running a terminal command, with allow/deny choices. [공통 스타일]
- `images/020_diff.png` — A side-by-side diff view with red (removed) and green (added) lines. [공통 스타일]
- `images/021_session.png` — Session management icons: clear (new), compact (summarize), resume (continue tomorrow). [공통 스타일]
- `images/022_slash.png` — A floating command palette of slash commands (/diff, /compact, /model, /review...). [공통 스타일]
- `images/023_image_input.png` — A user attaching a design mockup screenshot to the agent to reproduce a UI. [공통 스타일]
- `images/024_clear_prompt.png` — Split image: a vague request producing chaos vs a clear structured request producing a clean result. [공통 스타일]
- `images/025_decompose.png` — A big task box being split into small vertical slices, each independently testable. [공통 스타일]
- `images/026_verify.png` — An agent self-verifying via a test loop (write → test → fail → fix → pass). [공통 스타일]
- `images/027_calculator.png` — A simple command-line calculator with a passing test checklist beside it. [공통 스타일]
- `images/028_webpage.png` — A polished personal landing webpage (gradient bg, expressive type) avoiding generic gray "AI slop". [공통 스타일]
- `images/029_mistakes.png` — Ten common beginner pitfalls as warning-sign icons in a grid. [공통 스타일]
- `images/030_part1_done.png` — A celebratory "Part 1 complete" milestone flag at the top of the first staircase. [공통 스타일]

### Part 2 (중급)
- `images/031_config.png` — A config.toml file as a control panel with dials for model, sandbox, approval. [공통 스타일]
- `images/032_config_layers.png` — Two stacked layers "user (~/.codex)" and "project (.codex)", project overriding user. [공통 스타일]
- `images/033_model_effort.png` — Two dials: model selector and reasoning-effort gauge (low→high). [공통 스타일]
- `images/034_agentsmd.png` — An AGENTS.md document injecting rules into the agent before work. [공통 스타일]
- `images/035_agentsmd_hierarchy.png` — Nested folders each with AGENTS.md, merging root→down, closest wins. [공통 스타일]
- `images/036_taskflow_agentsmd.png` — A TaskFlow project AGENTS.md with rule sections. [공통 스타일]
- `images/037_memories.png` — Memory notes carried from one session to the next across a timeline. [공통 스타일]
- `images/038_sandbox.png` — An AI agent inside a protective fenced sandbox, system outside the fence. [공통 스타일]
- `images/039_sandbox_modes.png` — Three sandbox modes: read-only / workspace-write / full-access with lock levels. [공통 스타일]
- `images/040_approval_policy.png` — A spectrum from untrusted → on-request → never → granular. [공통 스타일]
- `images/041_permissions.png` — Permission profile with path read/write/deny and network allowlist. [공통 스타일]
- `images/042_context.png` — Good context (files, examples, constraints) feeding a precise result. [공통 스타일]
- `images/043_threads.png` — Multiple parallel work threads, with a warning against editing the same file. [공통 스타일]
- `images/044_goal.png` — An agent pursuing a measurable goal across many turns with a completion-audit checkmark. [공통 스타일]
- `images/045_review.png` — An AI code reviewer flagging bugs/risks by severity with file:line. [공통 스타일]
- `images/046_plan.png` — A step-by-step plan checklist being executed and updated. [공통 스타일]
- `images/047_mcp.png` — MCP as a USB-like standard connecting external tools to the agent. [공통 스타일]
- `images/048_mcp_add.png` — Terminal `codex mcp add` wiring a server into the agent. [공통 스타일]
- `images/049_mcp_popular.png` — Three MCP servers (GitHub, Playwright, Context7) feeding the agent. [공통 스타일]
- `images/050_skills.png` — Reusable skill packages (manuals/checklists) on a shelf, loaded on demand. [공통 스타일]
- `images/051_skillmd.png` — A SKILL.md file with name/description front matter and steps. [공통 스타일]
- `images/052_custom_skill.png` — Building and invoking a custom "release-notes" skill. [공통 스타일]
- `images/053_plugins.png` — A plugin bundling skills + MCP + config, installed from a marketplace. [공통 스타일]
- `images/054_web_search.png` — The agent searching the live web to ground answers in current info. [공통 스타일]
- `images/055_exec.png` — `codex exec` running headless inside a script/CI pipeline. [공통 스타일]
- `images/056_git.png` — Safe collaboration between Codex and Git (branches, small commits, safety net). [공통 스타일]
- `images/057_ide.png` — Codex inside a code editor using open-file/selection as context. [공통 스타일]
- `images/058_todo_api.png` — A FastAPI To-Do REST API with passing tests and Swagger docs. [공통 스타일]
- `images/059_mid_mistakes.png` — Ten intermediate pitfalls as warning icons. [공통 스타일]
- `images/060_part2_done.png` — "Part 2 complete" milestone flag on the second staircase. [공통 스타일]

### Part 3 (고급)
- `images/061_architecture.png` — High-level Codex architecture: UI → engine(core) → model + safety layers → real actions. [공통 스타일]
- `images/062_sq_eq.png` — Engine and UI exchanging messages over two queues SQ (UI→engine) and EQ (engine→UI). [공통 스타일]
- `images/063_lifecycle.png` — Nested layers Session > Task > Turn with a self-correction loop arrow. [공통 스타일]
- `images/064_websocket.png` — A turn-scoped WebSocket session reusing one connection with prewarm. [공통 스타일]
- `images/065_compaction.png` — A long conversation compacted into a handoff summary passed to the next LLM. [공통 스타일]
- `images/066_system_prompt.png` — A shipped system prompt scroll listing behavior rules (rg, git guardrails, anti-slop). [공통 스타일]
- `images/067_apply_patch.png` — An apply_patch diff envelope with +/- lines and @@ context markers. [공통 스타일]
- `images/068_execpolicy.png` — Commands sorted into Allow / Prompt / Forbidden by a Starlark policy. [공통 스타일]
- `images/069_four_layers.png` — Four independent defense layers: execpolicy, approval, sandbox, permissions. [공통 스타일]
- `images/070_native_sandbox.png` — OS-native sandboxes: macOS Seatbelt, Linux bwrap+landlock+seccomp, Windows token. [공통 스타일]
- `images/071_subagents.png` — A main agent conducting several named subagents returning summaries. [공통 스타일]
- `images/072_parallel_explore.png` — Parallel subagents exploring different folders, results synthesized. [공통 스타일]
- `images/073_hooks.png` — Hook checkpoints inserted at points along the agent loop conveyor. [공통 스타일]
- `images/074_hook_events.png` — A timeline of hook lifecycle events (SessionStart, PreToolUse,... Stop). [공통 스타일]
- `images/075_security_hook.png` — A PreToolUse hook blocking a dangerous command. [공통 스타일]
- `images/076_personality.png` — Choosing a personality: friendly vs pragmatic vs none. [공통 스타일]
- `images/077_sdk_ts.png` — TypeScript code controlling Codex via the SDK. [공통 스타일]
- `images/078_sdk_py.png` — Python code controlling Codex via the SDK. [공통 스타일]
- `images/079_agent_app.png` — A custom pre-commit review bot built with the SDK. [공통 스타일]
- `images/080_appserver.png` — app-server (JSON-RPC) as the hub all clients connect to. [공통 스타일]
- `images/081_cloud.png` — Work running in isolated cloud containers in parallel, producing PRs. [공통 스타일]
- `images/082_github_codex.png` — A GitHub issue mentioning @codex generating a pull request. [공통 스타일]
- `images/083_actions.png` — A CI pipeline running Codex on every PR as a gate. [공통 스타일]
- `images/084_security.png` — Security and governance shield: prompt-injection defense, secrets, audit. [공통 스타일]
- `images/085_part3_done.png` — "Part 3 complete" milestone flag on the third staircase. [공통 스타일]

### Part 4 (실전 프로젝트)
- `images/086_taskflow_arch.png` — TaskFlow architecture: browser → FastAPI (+AI module) → database. [공통 스타일]
- `images/087_requirements.png` — Turning requirements into AGENTS.md rules and a measurable Goal. [공통 스타일]
- `images/088_backend.png` — Pair-programming a FastAPI backend with an AI priority module and fallback. [공통 스타일]
- `images/089_frontend.png` — A polished, bold TaskFlow web UI (teal gradient) avoiding generic design. [공통 스타일]
- `images/090_db_auth.png` — Database and per-user authentication with JWT and access control. [공통 스타일]
- `images/091_testing.png` — A green automated test/verification loop guarding the project. [공통 스타일]
- `images/092_accelerate.png` — Accelerating dev with MCP + subagents + skills + hooks. [공통 스타일]
- `images/093_deploy.png` — Dockerized app going through a CI gate to cloud deployment. [공통 스타일]
- `images/094_refactor.png` — Review and refactor round polishing the codebase, tests as safety net. [공통 스타일]
- `images/095_launch.png` — A celebratory launch of TaskFlow v1.0.0 to real users. [공통 스타일]

### Part 5 (부록 & 마무리)
- `images/096_slash_ref.png` — A slash-command cheat sheet card grid. [공통 스타일]
- `images/097_config_ref.png` — A config.toml settings map with grouped sections. [공통 스타일]
- `images/098_cli_ref.png` — A codex CLI subcommand map. [공통 스타일]
- `images/099_troubleshooting.png` — A friendly troubleshooting flowchart / FAQ board. [공통 스타일]
- `images/100_epilogue.png` — A developer stepping forward into a bright AI-assisted future, new beginning. [공통 스타일]

---

> 총 100개 절 + 표지의 이미지 프롬프트 완비. 각 프롬프트를 gpt-image-2에 입력해 `book/images/`에 같은 파일명으로 저장하세요.
