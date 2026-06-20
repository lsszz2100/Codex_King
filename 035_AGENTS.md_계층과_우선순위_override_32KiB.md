# 035. AGENTS.md 계층과 우선순위 (override, 32KiB)

AGENTS.md는 한 개만 두는 게 아닙니다. 여러 계층으로 두고, 가까운 것이 먼 것을 덮는 구조입니다. 이 메커니즘을 정확히 알면 대규모 프로젝트도 깔끔하게 통제할 수 있습니다.

## 세 계층의 탐색 순서

Codex는 지시문을 다음 순서로 모읍니다.

1. 글로벌(유저): `~/.codex/AGENTS.override.md` 가 있으면 그것, 없으면 `~/.codex/AGENTS.md`
2. 프로젝트: 프로젝트 루트를 찾은 뒤, 루트 → 현재 작업 폴더까지 각 디렉터리에서
   - `AGENTS.override.md` → `AGENTS.md` → (설정된 fallback 파일명) 순으로 탐색
3. 병합: 루트에서 아래로 이어 붙이며(concatenate), 현재 폴더에 가까운 파일이 나중에 와서 우선 적용

```text
~/.codex/AGENTS.md                  (전역 기본)
└─ myproject/AGENTS.md              (프로젝트 공통)
   └─ myproject/services/AGENTS.md  (서비스별)
      └─ .../payments/AGENTS.override.md  (가장 구체적 → 최우선)
```

> 핵심: 루트 → 하위로 갈수록 우선순위가 높아진다. 가까운 규칙이 먼 규칙을 이깁니다.

## `AGENTS.override.md`의 용도

같은 폴더에서 `AGENTS.override.md`는 `AGENTS.md`보다 먼저 선택됩니다. 특정 하위 영역에서 상위 규칙을 강하게 덮어쓸 때 씁니다.

예: 전사 규칙은 "테스트는 `npm test`"인데, 결제 서비스만 "`make test-payments`"를 써야 한다면:

```markdown
<!-- services/payments/AGENTS.override.md -->
## 결제 서비스 전용 규칙
- 테스트는 `npm test` 대신 `make test-payments` 를 사용한다.
- API 키 회전 시 반드시 보안팀에 통보한다.
```

> TIP 특수 규칙은 그 작업이 일어나는 폴더에 최대한 가깝게 두세요. Codex는 현재 작업 폴더까지만 탐색하므로, 가까울수록 확실히 적용됩니다.

## 병합 방식 자세히

- 파일들은 빈 줄과 구분자로 이어 붙여져 모델에게 전달됩니다.
- 빈 파일은 건너뜁니다.
- 즉, 여러 계층의 규칙이 합쳐진 하나의 지시문으로 Codex에게 주어집니다. (상충하면 가까운 것이 우선)

## 크기 제한: 32 KiB

기본적으로 모든 AGENTS.md의 합산 크기는 32 KiB(`32 * 1024` 바이트)로 제한됩니다. 설정 키는 `project_doc_max_bytes` 입니다.

```toml
# 한도를 늘리고 싶을 때 (보통은 불필요)
project_doc_max_bytes = 65536
```

한도에 도달하면 그 이후 파일은 더해지지 않습니다.

> AGENTS.md를 너무 길게 쓰지 마세요. 길면 한도에 걸리고, 컨텍스트도 잡아먹습니다. 핵심 규칙만 간결하게, 길면 하위 폴더로 나누는 게 좋습니다.

## fallback 파일명 (고급)

다른 이름의 지시 파일(예: 타 도구의 규칙 파일)을 함께 읽게 하려면 설정에 추가합니다.

```toml
project_doc_fallback_filenames = ["CLAUDE.md", "CONVENTIONS.md"]
```

> 기본값은 빈 목록입니다. 즉 별도 설정 없이는 `AGENTS.md`(와 `AGENTS.override.md`)만 읽습니다. 다른 파일명을 쓰고 싶을 때만 추가하세요.

## 실습

```text
1. 프로젝트 루트에 AGENTS.md: "주석은 한국어로"
2. 하위 폴더 sub/ 에 AGENTS.override.md: "이 폴더에서는 주석을 영어로"
3. sub/ 안에서 코드를 만들게 한 뒤, 주석 언어가 무엇인지 확인
```

가까운 규칙(영어 주석)이 이기는지 직접 확인하세요.

## 정리

- AGENTS.md는 글로벌 → 프로젝트 루트 → 하위 폴더로 계층화
- 가까운 파일이 먼 파일을 덮는다 (override가 최우선)
- 합산 32 KiB 제한(`project_doc_max_bytes`)
- 다른 파일명은 `project_doc_fallback_filenames`로 추가 (기본은 빈 목록)

---

다음 절에서 우리 프로젝트 TaskFlow를 위한 실전 AGENTS.md를 직접 작성합니다.
