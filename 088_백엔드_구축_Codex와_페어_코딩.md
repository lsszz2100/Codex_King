# 088. 백엔드 구축 — Codex와 페어 코딩

이제 본격적으로 만듭니다. 058번의 Todo API를 모듈화하고, TaskFlow의 핵심인 AI 우선순위 추천 기능을 붙입니다.

## Step 1. 구조 모듈화

058번의 단일 파일을 AGENTS.md 규약(087번)에 맞게 나눕니다.

```text
todo_api.py를 우리 아키텍처에 맞게 모듈화해줘:
- app/main.py        : FastAPI 앱 진입점
- app/db.py          : DB 연결/세션
- app/models/todo.py : Todo 모델
- app/routers/todos.py : 할 일 라우터
기존 기능과 테스트가 그대로 동작하도록 하고, pytest를 돌려 확인해줘.
```

> 리팩터링 후에도 기존 테스트가 통과해야 합니다. 테스트가 "안전망" 역할을 합니다(026번).

## Step 2. AI 우선순위 추천 — 설계

TaskFlow의 차별점입니다. AI가 할 일 목록을 보고 "오늘 뭐부터"를 제안합니다.

```text
/plan
AI 우선순위 추천 기능을 추가하려고 해.
- 입력: 사용자의 미완료 할 일 목록(제목, 마감일)
- 출력: 우선순위 순서 + 각 항목에 한 줄 이유
- GPT-5.5 API를 app/services/ai.py 에서 호출
- API 키는 .env(OPENAI_API_KEY)
단계 계획을 세워줘.
```

## Step 3. AI 모듈 구현

```text
app/services/ai.py 를 만들어줘:
- suggest_priority(todos: list) -> list 함수
- OpenAI API(GPT-5.5)로 할 일 목록을 보내 우선순위와 이유를 받는다
- 응답을 파싱해 [{title, reason, rank}] 형태로 반환
- API 키 없거나 호출 실패 시: 마감일 기준 정렬로 폴백(graceful degradation)
- 주석은 한국어, 키는 환경변수에서
```

> 폴백 설계가 핵심입니다. AI 호출이 실패해도 서비스가 죽지 않고 "마감일순"으로라도 동작하게 합니다. 실무에서 외부 API 의존은 항상 실패를 대비해야 합니다.

개념 골격:

```python
import os
from openai import OpenAI

client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY"))

def suggest_priority(todos: list) -> list:
    if not os.environ.get("OPENAI_API_KEY"):
        return _fallback_by_due(todos)   # 폴백
    try:
        # GPT-5.5에 할 일 목록을 주고 우선순위 요청
        # ... (응답 파싱) ...
        return ranked
    except Exception:
        return _fallback_by_due(todos)
```

## Step 4. 엔드포인트 연결

```text
GET /todos/suggest 엔드포인트를 추가해줘:
- 미완료 할 일을 모아 ai.suggest_priority에 넘기고
- 우선순위 결과를 JSON으로 반환
- 테스트도 추가 (AI 부분은 모킹해서 폴백/정상 모두 검증)
pytest를 돌려 통과를 보여줘.
```

> AI를 모킹(mock)해 테스트하는 건 중요한 실무 기술입니다 — 외부 호출 없이 로직을 검증합니다.

## Step 5. 환경 변수 설정

```text
.env.example 파일을 만들어줘 (OPENAI_API_KEY= 등 필요한 키 목록).
실제 .env는 .gitignore에 추가해서 커밋되지 않게 해줘.
```

> `.env`(진짜 키)는 절대 커밋 금지. `.env.example`(빈 템플릿)만 공유합니다.

## Step 6. 직접 확인 + 커밋

```bash
uvicorn app.main:app --reload
# http://127.0.0.1:8000/docs 에서 /todos/suggest 테스트
```

```text
/diff   → 검토
```
```bash
git add . && git commit -m "Add AI priority suggestion with fallback"
```

## 회고

- 단일 파일 → 모듈화(규칙 기반 리팩터링, 테스트가 안전망)
- TaskFlow의 핵심 AI 기능을 폴백과 함께 구현
- 외부 API를 모킹해 테스트, 키는 환경변수로
- 매 단계 검증·커밋

## 도전 과제

- AI 추천에 "예상 소요시간"도 포함시키기
- 추천 결과를 캐시해 같은 목록은 재호출 안 하기
- AI 응답이 형식에 안 맞을 때의 견고한 파싱

## 정리

- 058 결과를 모듈화(테스트로 안전하게)
- 핵심 차별점 AI 우선순위 추천 구현 (+ 실패 시 폴백)
- 외부 API는 모킹 테스트, 키는 `.env`(커밋 금지)
- 페어 코딩 리듬: 계획 → 구현 → 테스트 → 확인 → 커밋

---

다음 절에서 프런트엔드를 "AI 슬롭" 없이 구축합니다.
