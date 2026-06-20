# 031. 설정 파일 `config.toml` 이해하기

![그림 31-1. config.toml로 Codex 길들이기](images/031_config.png)

**Part 2, 중급**에 오신 걸 환영합니다. 초급이 "도구에 익숙해지기"였다면, 중급은 **"Codex를 내 방식대로 길들이기"** 입니다. 그 출발점이 설정 파일입니다.

## config.toml이란

Codex의 동작을 정의하는 설정 파일입니다. 모델, 승인 정책, 샌드박스, 기능 토글 등 거의 모든 것을 여기서 정합니다. 형식은 **TOML**(읽기 쉬운 키-값 형식)입니다.

```toml
# 가장 단순한 예
model = "gpt-5.5"
model_reasoning_effort = "medium"
```

> **TOML 읽는 법** `키 = 값` 형태입니다. `[섹션]`으로 묶고, `#`은 주석입니다. JSON보다 사람이 읽기 편합니다.

## 어디에 있나

설정은 위치에 따라 두 종류입니다(자세히는 032번).

- **유저 설정**: `~/.codex/config.toml` — 내 모든 프로젝트에 적용
- **프로젝트 설정**: `<프로젝트>/.codex/config.toml` — 그 프로젝트에만 적용 (신뢰된 프로젝트에서만 로드)

> `~`는 사용자 홈 폴더입니다 (Windows는 보통 `C:\Users\사용자명`).

## 파일 만들기/열기

가장 쉬운 방법은 Codex에게 시키는 겁니다.

```text
~/.codex/config.toml 파일을 열어서 현재 설정을 보여줘.
없으면 기본 모델을 gpt-5.5로 설정하는 파일을 만들어줘.
```

또는 직접:

```bash
# 폴더가 없으면 만들고, 편집기로 열기
mkdir -p ~/.codex
# (원하는 편집기로 ~/.codex/config.toml 열기)
```

## 자주 쓰는 핵심 설정 미리보기

```toml
# 모델과 추론 강도
model = "gpt-5.5"
model_reasoning_effort = "medium"

# 샌드박스 모드 (안전) — 038번
sandbox_mode = "workspace-write"

# 승인 정책 — 040번
approval_policy = "on-request"

# 기능 토글 — 필요한 것만 켜기
[features]
hooks = true
memories = true
```

각 항목은 이어지는 절들에서 하나씩 깊이 다룹니다. 지금은 "이런 게 여기서 정해진다"만 알면 됩니다. 전체 목록은 097번 레퍼런스에 있습니다.

## 설정 확인하기

```text
/status
```

또는 설정 디버그용 명령으로 현재 적용된 값을 확인할 수 있습니다.

```text
/debug-config
```

## ⚠️ 주의: 프로젝트 설정의 제한

프로젝트 `.codex/config.toml`은 편리하지만, **모델 제공자(provider)·인증·텔레메트리** 같은 민감한 설정은 **유저 설정만** 바꿀 수 있습니다. 보안을 위한 제한입니다(→ 032번).

## 🧪 실습

```text
~/.codex/config.toml 에 기본 모델을 gpt-5.5,
추론 강도를 medium으로 설정해줘. 그리고 적용됐는지 /status로 보여줘.
```

설정 전후로 `/status`의 모델 표시가 바뀌는지 확인하세요.

## 정리

- `config.toml` = Codex 동작을 정의하는 TOML 설정 파일
- 위치: 유저(`~/.codex/`) vs 프로젝트(`.codex/`)
- 모델·샌드박스·승인·기능 토글 등을 지정
- 민감 설정은 유저 레벨에서만 변경 가능
- 전체 목록은 097번

---

다음 절에서 **유저 설정과 프로젝트 설정의 관계·우선순위**를 정리합니다.

> 📷 `images/031_config.png` — 부록 프롬프트 참고
