# 036. [실습] 우리 프로젝트 AGENTS.md 작성

![그림 36-1. TaskFlow용 AGENTS.md 작성](images/036_taskflow_agentsmd.png)

이제 배운 걸 적용해, 우리 실전 프로젝트 **TaskFlow**의 AGENTS.md를 만듭니다. 이 파일은 Part 4에서 그대로 재사용합니다.

## Step 1. 프로젝트 폴더 준비

```bash
mkdir taskflow && cd taskflow
git init        # 버전 관리 시작 (권장)
codex
```

## Step 2. `/init`으로 초안 받기

```text
/init
```

Codex가 폴더를 분석해 AGENTS.md 초안을 만듭니다. 아직 코드가 없으니 간단할 겁니다. 이제 우리 손으로 채웁니다.

## Step 3. TaskFlow 규칙 작성

```text
AGENTS.md를 아래 내용으로 작성해줘:

# TaskFlow 프로젝트 규칙

## 프로젝트 개요
- AI가 우선순위를 추천해주는 할 일 관리 SaaS
- 백엔드: Python + FastAPI, DB: SQLite(개발) → PostgreSQL(운영)
- 프런트엔드: HTML/CSS + 약간의 JavaScript

## 작업 방식
- 기능은 작게 쪼개서 하나씩 완성한다(수직 분해).
- 코드를 수정하면 항상 `pytest`로 테스트를 실행한다.
- 새 기능에는 반드시 테스트를 함께 작성한다.

## 코드 스타일
- Python은 PEP8, 포매터는 black.
- 함수/변수명은 영어, 주석은 한국어.
- API 경로는 RESTful 하게(`/todos`, `/todos/{id}`).

## 의존성
- 새 패키지 추가 전에 먼저 물어본다.
- 의존성은 requirements.txt 로 관리.

## 보안/금지
- 비밀키·토큰은 코드에 넣지 않고 환경 변수로 관리한다.
- main 브랜치에 직접 커밋하지 않는다.
- 데이터 삭제/마이그레이션은 사람 확인 후 실행한다.
```

## Step 4. 잘 적용됐는지 검증

```text
현재 적용된 프로젝트 지시(instructions)를 요약해서 알려줘.
```

또는 터미널에서:

```bash
codex --ask-for-approval never "이 프로젝트의 규칙을 요약해줘."
```

요약에 우리가 적은 규칙(테스트, 주석 언어, 의존성 확인 등)이 반영되면 성공입니다.

## Step 5. 동작 테스트

규칙이 실제로 작동하는지 봅시다.

```text
todo를 표현하는 간단한 파이썬 클래스를 todo.py에 만들어줘.
```

관찰 포인트:
- 주석이 **한국어**로 달리는가? (스타일 규칙)
- 테스트를 함께 만들려 하는가? (테스트 규칙)
- 새 패키지가 필요하면 **먼저 물어보는가?** (의존성 규칙)

규칙대로 움직인다면, 당신은 Codex를 성공적으로 "길들인" 겁니다.

## Step 6. 팀과 공유 (git 커밋)

```bash
git add AGENTS.md
git commit -m "Add project rules in AGENTS.md"
```

이제 이 저장소를 받는 누구든(혹은 클라우드의 Codex든) **같은 규칙**으로 일합니다.

## 흔한 실수

> ⚠️ AGENTS.md를 소설처럼 길게 쓰지 마세요. **간결한 규칙 목록**이 가장 잘 작동합니다(32KiB 제한도 있음). 세부 배경은 별도 문서로, 규칙만 여기에.

## 정리

- `/init`으로 초안 → 우리 규칙으로 구체화
- TaskFlow의 스택·작업방식·스타일·보안 규칙을 명시
- `--ask-for-approval never "규칙 요약"`으로 검증
- git 커밋으로 팀·클라우드와 규칙 공유

---

다음 절에서 Codex의 **Memories(기억)** 기능을 다룹니다.

> 📷 `images/036_taskflow_agentsmd.png` — 부록 프롬프트 참고
