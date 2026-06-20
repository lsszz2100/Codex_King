# 097. `config.toml` 전체 레퍼런스

![그림 97-1. config.toml 설정 지도](images/097_config_ref.png)

Codex 설정의 주요 키를 한자리에 정리합니다. 위치는 `~/.codex/config.toml`(유저) 또는 `<프로젝트>/.codex/config.toml`(프로젝트, 신뢰된 경우)입니다(032번).

## 모델·추론

```toml
model = "gpt-5.5"                      # 기본 모델
model_provider = "openai"             # 제공자
model_reasoning_effort = "medium"     # minimal|low|medium|high|xhigh
model_context_window = 200000         # (보통 기본값)
```

## 인증

```toml
forced_login_method = "chatgpt"       # "chatgpt" | "api" (조직 강제용)
# model_providers.<id> 로 커스텀 제공자 정의 (엔터프라이즈/게이트웨이)
```

## 샌드박스 · 승인

```toml
sandbox_mode = "workspace-write"      # read-only | workspace-write | danger-full-access
approval_policy = "on-request"        # untrusted | on-request | never | granular

[sandbox_workspace_write]
# 쓰기 허용 루트, 네트워크 접근 등 세부 (고급)
```

### granular 승인 (세분화)
`approval_policy = "granular"`일 때 카테고리별 제어:
```text
sandbox_approval   - 권한 상승 프롬프트
rules              - 실행 정책 트리거
mcp_elicitations   - MCP 상호작용 요청
request_permissions- 도구 권한 요청
skill_approval     - 스킬 스크립트 승인
```

## 권한 프로필 (041번)

```toml
default_permissions = "dev"

[permissions.dev]
read = ["**"]
write = ["./src/**", "./tests/**"]
deny = ["./secrets/**"]
network_allow = ["api.openai.com", "pypi.org"]
# extends = "다른프로필"  # 상속
```

## 기능 토글 (features)

```toml
[features]
multi_agent = true        # 서브에이전트 (071)
memories = true           # 기억 (037)
hooks = true              # 훅 (073)
network_proxy = true      # 샌드박스 네트워크 프록시
unified_exec = true       # PTY 기반 실행
shell_snapshot = true     # 반복 명령 가속(환경 캐시)
```

## MCP 서버 (048번)

```toml
[mcp_servers.context7]
command = "npx"
args = ["-y", "@upstash/context7-mcp"]
# env = { KEY = "..." }, cwd = "...", 타임아웃, 도구 허용목록 등

[mcp_servers.remote_example]
url = "https://mcp.example.com"
bearer_token_env_var = "EXAMPLE_TOKEN"
```

## 도구 (tools)

```toml
[tools]
web_search = "live"       # disabled | cached | live (054번)
```

## AGENTS.md 관련 (035번)

```toml
project_doc_max_bytes = 32768                 # 기본 32 KiB
project_doc_fallback_filenames = []           # 기본 빈 목록
```

## 기록·로그·관측성

```toml
[history]
persistence = "save-all"  # save-all | none

log_dir = "..."           # 로그 위치
# [otel] OpenTelemetry 익스포터 (엔터프라이즈 관측성, 084번)
```

## ⚠️ 프로젝트 설정의 제한 (032번)

프로젝트 `.codex/config.toml`로는 **다음을 바꿀 수 없습니다**(보안):
- 모델 **제공자(provider)**
- **인증** 방식
- **알림/텔레메트리**

이들은 유저/관리 레벨에서만 설정됩니다.

## 확인 방법

```text
/debug-config     적용된 설정 디버그
/status           요약 상태
```

## TIP

> 💡 전부 설정할 필요 없습니다. **기본값이 안전하고 합리적**입니다. `model`과 필요한 `[features]` 정도만 손대고, 나머지는 필요할 때 추가하세요.

> ⚠️ 키 이름·구조는 버전에 따라 다를 수 있습니다. 공식 설정 레퍼런스(developers.openai.com/codex/config-reference)와 `/debug-config`로 현재 환경을 확인하세요.

## 정리

- 위치: 유저(`~/.codex/`) vs 프로젝트(`.codex/`)
- 핵심 영역: 모델·샌드박스·승인·권한·features·MCP·tools·AGENTS 관련
- provider·인증·텔레메트리는 **유저/관리 레벨만**
- 기본값이 안전 — 필요한 것만 조정, `/debug-config`로 검증

---

다음 절에서 CLI 서브커맨드를 정리합니다.

> 📷 `images/097_config_ref.png` — 부록 프롬프트 참고
