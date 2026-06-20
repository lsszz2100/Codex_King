# 부록 — 하네스 엔지니어링과 Codex 함께 쓰기

본문에서 우리는 Codex 하나를 잘 다루는 법을 배웠습니다. 이 부록은 한 걸음 더 나아가, **여러 에이전트를 하나의 "팀"으로 설계하는 공학** — 하네스 엔지니어링(Harness Engineering)을 소개하고, 이를 Codex와 함께 쓰면 무엇이 좋아지는지를 정리합니다.

> 참고 도구: [revfactory/harness](https://github.com/revfactory/harness) (Claude Code용 메타스킬) · Codex 포트 [SaehwanPark/meta-harness](https://github.com/SaehwanPark/meta-harness) · 연구 저장소 [revfactory/claude-code-harness](https://github.com/revfactory/claude-code-harness)

---

## 1. 하네스 엔지니어링이란

총(모델)을 잘 쏘는 것과, 총을 안정적으로 받쳐 주는 거치대(하네스)를 잘 만드는 것은 다른 일입니다. **하네스**는 에이전트가 일을 잘하도록 둘러싼 모든 구조 — 규칙, 도구, 권한, 역할 분담, 검증 게이트 — 를 뜻합니다. 본문에서 다룬 `AGENTS.md`, 샌드박스, 승인 정책, MCP, Skills, 서브에이전트, Hooks가 모두 "하네스의 부품"입니다.

**하네스 엔지니어링**은 이 부품들을 즉흥적으로 쓰는 대신, **하나의 팀 아키텍처로 설계·생성·검증하는 공학**입니다. revfactory/harness는 이를 자동화한 도구로, 스스로를 이렇게 설명합니다:

> **"도메인 설명 → 에이전트 팀 + 스킬"**

즉 "이 프로젝트를 위한 하네스를 구성해줘"라고 말하면, 도메인을 분석해 **여러 전문 에이전트 정의와 스킬 파일을 자동으로 생성**합니다. 단순한 설정 생성이 아니라, 에이전트들이 서로 협력하는 **구조**(역할·메시지 흐름·검증 단계)를 만드는 것이 핵심입니다.

### 어디에 위치하는가 (L3 메타-팩토리)

하네스는 "에이전트를 만드는 에이전트" 계층(L3 메타-팩토리)에 속하며, 그중에서도 **팀 아키텍처 팩토리(Team-Architecture Factory)** 역할입니다. 이웃 도구 **Archon**(런타임 설정을 결정론적으로 생성하는 Runtime-Configuration Factory)과 상호 보완적으로 조합할 수 있습니다.

---

## 2. 6가지 팀 아키텍처 패턴

하네스가 도메인에 따라 골라 쓰는 협력 구조입니다. Codex의 서브에이전트(본문 071)·Goal(044)·plan(046)과 직접 대응됩니다.

| 패턴 | 언제 쓰나 | Codex로 옮기면 |
| --- | --- | --- |
| **Pipeline** | 순차 의존 작업 (A→B→C) | 단계별 작업을 순서대로 위임 |
| **Fan-out / Fan-in** | 병렬 독립 작업 후 취합 | 서브에이전트로 폴더별 병렬 탐색(본문 072) |
| **Expert Pool** | 맥락에 따라 전문가 선택 호출 | 역할별 스킬/프로필을 상황에 맞게 호출 |
| **Producer-Reviewer** | 생성 후 품질 검수 | 작성 에이전트 + `/review` 리뷰 분리 |
| **Supervisor** | 중앙이 동적으로 분배 | 메인 에이전트가 작업을 조율 |
| **Hierarchical Delegation** | 하향식 재귀 위임 | 상위 작업을 하위로 쪼개 위임 |

핵심 발상은 **"한 에이전트에게 전부 시키지 말고, 역할을 나누고 그 사이에 검증 게이트를 두라"**는 것입니다. 이는 본문 025(작업 쪼개기)·026(검증 포함)·071(서브에이전트)의 사고를 팀 단위로 확장한 것입니다.

---

## 3. Codex와 함께 쓰면 좋은 점

하네스(또는 Codex 포트 meta-harness)로 팀 구조를 설계하고, 실제 코딩 실행은 Codex가 맡는 조합의 이점입니다.

1. **역할 분리로 품질이 오른다.** "작성자"와 "리뷰어"를 분리하면(Producer-Reviewer), 한 에이전트가 자기 코드를 검토할 때보다 결함이 더 잘 잡힙니다. Codex의 `/review`·`/codex:adversarial-review`가 리뷰어 역할에 그대로 맞습니다.
2. **검증 게이트가 표준화된다.** 단계마다 "테스트 통과·린트·보안 점검"을 게이트로 두면, 본문에서 강조한 "검증을 포함시키기"가 팀 전체의 규칙이 됩니다. Hooks(본문 073~075)와 결합하면 강제할 수도 있습니다.
3. **병렬화로 빨라진다.** Fan-out 패턴은 Codex 서브에이전트 병렬 탐색(072)과 직결됩니다. 단, **같은 파일 동시 편집을 피하도록 작업 영역을 나누는 설계**가 하네스의 몫입니다.
4. **재현성·일관성이 생긴다.** 즉흥 프롬프트 대신 팀 구조·스킬을 파일로 박아두면, 사람이 바뀌어도 같은 절차로 굴러갑니다. 출력 편차가 줄어듭니다.
5. **출력 편차·재작업이 감소한다.** 연구 저장소(claude-code-harness)의 저자 측정(n=15)에서는 품질 점수 49.5 → 79.3(약 60% 향상), 성공률 15/15, 출력 편차 약 32% 감소가 보고되었습니다(자체 측정치이므로 참고용). 효과는 작업이 복잡할수록 커지는 경향(기초 +23.8% → 전문가 +36.2%)이었다고 합니다.

> 주의: 위 수치는 도구 저자의 자체 측정이며 환경에 따라 달라집니다. "팀 구조 + 검증 게이트가 단독 에이전트보다 안정적"이라는 방향성의 근거로만 받아들이세요.

---

## 4. 실제로 적용하는 법

### A. Codex 네이티브로 "하네스 사고" 적용 (도구 없이도 가능)

하네스 도구를 설치하지 않아도, 본문 기능만으로 하네스 원칙을 구현할 수 있습니다.

```text
# 1) 팀 규칙을 AGENTS.md에 박는다 (역할·게이트 명문화)
# AGENTS.md
## 역할
- 구현은 작은 단위로, 각 단위마다 테스트를 먼저/같이 작성한다.
## 게이트 (통과 못 하면 다음 단계 금지)
- `pytest -q` 전부 통과
- `ruff check .` 무경고
## 금지
- main 직접 푸시 금지, 같은 파일 동시 편집 금지
```

```text
# 2) Producer-Reviewer: 작성과 리뷰를 분리
"기능을 구현해줘. 끝나면 변경을 스스로 비평적으로 리뷰하고(보안·엣지케이스),
발견한 문제를 수정한 뒤 최종 diff와 테스트 로그를 보여줘."
```

```bash
# 3) Fan-out: 서브에이전트로 영역을 나눠 병렬 탐색 (본문 071~072)
#    작업 영역을 분리해 충돌을 막는다
```

### B. 하네스 도구로 자동 생성

Claude Code 환경이라면 revfactory/harness를, **Codex 중심이라면 Codex 포트** meta-harness를 참고하세요.

```bash
# (Claude Code) 마켓플레이스로 설치
/plugin marketplace add revfactory/harness
/plugin install harness@harness-marketplace

# 또는 글로벌 스킬로 직접 설치
cp -r skills/harness ~/.claude/skills/harness
```

설치 후 자연어로 지시하면 6단계 워크플로(도메인 분석 → 팀 설계 → 에이전트 정의 → 스킬 생성 → 오케스트레이션 → 검증)를 거쳐 산출물을 만듭니다.

```text
"이 프로젝트를 위한 하네스를 구성해줘"
"이 도메인에 맞는 에이전트 팀을 설계해줘"
```

생성 결과 예시:

```
your-project/.claude/
├── agents/        # analyst.md, builder.md, qa.md ...
└── skills/        # analyze/SKILL.md, build/SKILL.md ...
```

> revfactory/harness의 팀 모드는 실험 플래그(`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`)가 필요할 수 있고, Codex에서의 대응 개념은 서브에이전트·스킬·AGENTS.md입니다. 도구 버전에 따라 명령이 바뀌므로 각 저장소 README를 확인하세요.

---

## 5. 한 줄 요약

> **모델을 바꾸기 전에 하네스를 먼저 고쳐라.** 역할을 나누고(팀), 단계마다 검증 게이트를 두고(품질), 충돌을 막게 영역을 나누면(설계), 같은 모델로도 결과가 더 안정적이고 재현 가능해집니다. Codex는 그 하네스 위에서 실제 코드를 만들어 내는 강력한 손입니다.

---

## 참고 링크

| 리소스 | 주소 |
| --- | --- |
| Harness (Claude Code 메타스킬) | https://github.com/revfactory/harness |
| meta-harness (Codex 포트) | https://github.com/SaehwanPark/meta-harness |
| claude-code-harness (연구·측정) | https://github.com/revfactory/claude-code-harness |
| Claude Code용 Codex 플러그인 | https://github.com/openai/codex-plugin-cc |

> 위 도구들은 서드파티(또는 타 에이전트 생태계) 프로젝트를 포함합니다. 설치 전 출처·라이선스·권한을 직접 확인하세요 — 도구는 곧 권한입니다(본문 084).
