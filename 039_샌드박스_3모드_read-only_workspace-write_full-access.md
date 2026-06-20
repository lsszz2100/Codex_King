# 039. 샌드박스 3모드 — read-only / workspace-write / full-access

샌드박스의 통제 강도는 세 가지 모드로 정합니다. 각각 무엇을 허용하는지 정확히 알아야 안전하게 쓸 수 있습니다.

## 세 모드 한눈에

| 모드 | 파일 읽기 | 파일 쓰기 | 명령 실행 | 비고 |
|---|---|---|---|---|
| `read-only` | ○ | × (승인 필요) | 제한적 | 가장 안전, 탐색·리뷰용 |
| `workspace-write` | ○ | ○ (작업 폴더 안) | 일상 명령 | 기본값, 균형 |
| `danger-full-access` | ○ | ○ (전체) | 제한 없음 | 위험, 특수 상황만 |

## 1) `read-only` — 읽기 전용

파일을 보기만 합니다. 편집하려면 승인이 필요합니다.

언제: 낯선 코드베이스를 탐색하거나, 코드 리뷰만 시킬 때. "절대 아무것도 바꾸지 마"가 필요한 상황.

```toml
sandbox_mode = "read-only"
```

## 2) `workspace-write` — 작업 폴더 쓰기 (기본값)

현재 작업 폴더 안에서는 읽고 쓰고 일상 명령을 실행할 수 있습니다. 폴더 밖이나 시스템 영역은 막힙니다.

언제: 대부분의 일상 개발. 가장 실용적인 균형점이라 기본값입니다.

```toml
sandbox_mode = "workspace-write"
```

세부적으로 쓰기 가능한 경로와 네트워크 허용 여부 등을 더 조정할 수도 있습니다(고급).

```toml
[sandbox_workspace_write]
# (개념) 쓰기 허용 루트, 네트워크 접근 등 세부 설정
```

## 3) `danger-full-access` — 전체 접근

샌드박스 제한이 사실상 없습니다. 이름에 'danger'가 붙은 이유가 있습니다.

언제: 정말 특수한 경우(예: 시스템 전역 작업이 꼭 필요하고, 환경이 이미 격리됨 - 일회용 컨테이너 등)에만.

```toml
sandbox_mode = "danger-full-access"
```

> 경고 일반 개발 머신에서 이 모드를 상시로 쓰지 마세요. AI의 실수나 악성 코드가 시스템 전체에 영향을 줄 수 있습니다. "편하니까"라는 이유로 풀지 마세요.

## 모드 고르는 법

```text
"절대 안 바꿨으면" → read-only
"평소 개발"        → workspace-write (기본, 권장)
"진짜 특수상황"    → danger-full-access (격리 환경에서만)
```

## 승인 정책과 함께 본다

샌드박스 모드는 승인 정책(040번)과 짝을 이룹니다.

```text
예) read-only + 편집 시 승인  → 매우 신중한 탐색 모드
예) workspace-write + on-request → 일상 개발의 표준 조합
```

## 실습

```text
1. .codex/config.toml 에 sandbox_mode = "read-only" 설정
2. Codex에게 "test.txt 파일을 만들어줘" 라고 요청
3. 어떻게 반응하는지 관찰 (승인을 요구하거나 제한을 안내할 것)
4. 다시 workspace-write 로 바꾸고 같은 요청 → 차이 확인
```

## 정리

- 3모드: `read-only`(보기만) · `workspace-write`(작업폴더 쓰기, 기본) · `danger-full-access`(전체,)
- 일상은 `workspace-write`로 충분하고 안전
- `full-access`는 격리 환경의 특수 상황에서만
- 샌드박스 모드 × 승인 정책으로 안전 수준을 조합

---

다음 절에서 짝꿍인 승인 정책 4종을 다룹니다.
