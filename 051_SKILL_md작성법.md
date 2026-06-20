# 051. SKILL.md 작성법과 progressive disclosure

![그림 51-1. SKILL.md 구조](images/051_skillmd.png)

스킬의 심장은 `SKILL.md` 파일입니다. 이 절에서 그 구조와 잘 쓰는 법을 익힙니다.

## 최소 구조

스킬 디렉터리 안에 `SKILL.md`가 있고, 최소한 name과 description을 가져야 합니다.

```markdown
---
name: create-endpoint
description: FastAPI에 새 REST 엔드포인트를 테스트·문서와 함께 추가하는 표준 절차
---

# 새 엔드포인트 추가 절차

이 스킬은 우리 프로젝트 규칙에 맞춰 새 API 엔드포인트를 추가합니다.

## 단계
1. `app/routers/` 에 라우터 함수 추가 (RESTful 경로)
2. 요청/응답 Pydantic 모델 정의
3. `tests/` 에 정상/오류 케이스 테스트 작성
4. `pytest` 실행해 통과 확인
5. README의 API 표에 새 엔드포인트 한 줄 추가

## 규칙
- 경로는 복수형 명사(`/todos`)
- 모든 엔드포인트에 적절한 상태코드(201, 404 등)
- 주석은 한국어
```

## name과 description이 중요한 이유

progressive disclosure(점진적 공개) 때문입니다.

- 평소 Codex는 모든 스킬의 name + description만 봅니다(가볍게).
- 작업이 description과 맞으면 그때 본문 전체를 로드합니다.

따라서 description을 잘 쓰는 게 핵심입니다. "언제 이 스킬을 써야 하는지"가 한눈에 드러나야 자동 선택이 잘 됩니다.

```text
[나쁨] description: 엔드포인트 관련
[좋음] description: FastAPI에 새 REST 엔드포인트를 테스트·문서와 함께 추가하는 표준 절차
```

## 본문 작성 팁

- 단계(steps)를 번호로 명확히
- 규칙/제약을 분명히
- 필요하면 `scripts/`의 보조 스크립트를 참조
- 너무 길지 않게 — 핵심 절차에 집중

## 보조 파일 활용

```text
create-endpoint/
├── SKILL.md
├── scripts/
│   └── scaffold.py        # 라우터 뼈대 생성 스크립트
├── references/
│   └── api_style.md       # 우리 API 스타일 가이드
└── assets/
    └── router_template.py # 템플릿
```

본문에서 "`scripts/scaffold.py`를 실행해 뼈대를 만든 뒤..."처럼 참조하면 됩니다.

## 어디에 둘까

- 프로젝트 전용 → `.agents/skills/create-endpoint/`
- 내 모든 프로젝트 → `~/.agents/skills/create-endpoint/`

## 등록·확인

```text
/skills
```

목록에 우리 스킬이 보이는지, description이 잘 나오는지 확인합니다.

## 실습

```text
.agents/skills/commit-helper/SKILL.md 를 만들어줘.
- name: commit-helper
- description: 변경사항을 검토하고 우리 규칙(현재형, 한국어 요약)에 맞춰 커밋 메시지를 작성
- 본문: 1) /diff 검토 2) 변경 요약 3) 규칙에 맞는 메시지 제안 4) 사용자 확인 후 커밋
```

만든 뒤 `/skills`에서 확인하고, 다음 절에서 실제로 호출해 봅니다.

## 정리

- `SKILL.md`는 name + description(필수) + 절차 본문
- description이 자동 선택의 관건 — 언제 쓰는지 명확히
- 단계·규칙을 분명히, 보조 파일(scripts/references)로 확장
- `.agents/skills/`에 두고 `/skills`로 확인

---

다음 절에서 나만의 커스텀 스킬을 완성하고 사용해 봅니다.

> `images/051_skillmd.png` — 부록 프롬프트 참고
