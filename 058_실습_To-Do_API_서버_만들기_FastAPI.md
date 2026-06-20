# 058. [실습] To-Do API 서버 만들기 (FastAPI)

![그림 58-1. FastAPI로 만드는 To-Do API](images/058_todo_api.png)

드디어 TaskFlow의 첫 실제 코드를 만듭니다. 지금까지 배운 모든 것(명확한 요청·쪼개기·검증·AGENTS.md·승인)을 총동원합니다. 이 결과물은 Part 4에서 확장됩니다.

## 목표

할 일을 추가·조회·완료·삭제하는 REST API를, 테스트와 함께 만듭니다.

## 사전 준비

```bash
cd taskflow          # 036번에서 만든 폴더 (AGENTS.md 있음)
codex
```

> AGENTS.md 덕분에 Codex는 이미 "pytest로 검증, 한국어 주석, 의존성은 먼저 확인" 같은 규칙을 알고 있습니다.

## Step 1. 계획 (쪼개기)

```text
/plan
FastAPI로 할 일(todo) REST API를 만들 거야. 단계 계획을 세워줘.
기능: 추가/목록/완료토글/삭제. 저장은 우선 메모리(리스트), 나중에 DB.
```

Codex가 단계를 제시하면 검토 후 진행합니다.

## Step 2. 1차 — 메모리 기반 CRUD (명확하게)

```text
1단계만 진행하자. todo_api.py 를 만들어줘:
- FastAPI 앱
- Todo 모델: id(int), title(str), done(bool=False), due(선택, 날짜)
- POST /todos        : 추가 (제목 필수, 비면 400)
- GET  /todos        : 전체 목록
- PATCH /todos/{id}/toggle : 완료 토글 (없으면 404)
- DELETE /todos/{id} : 삭제 (없으면 404)
저장은 메모리 리스트로. 새 패키지(fastapi, uvicorn)가 필요하면 먼저 알려줘.
```

생성될 코드의 골격(예시):

```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Optional
from datetime import date

app = FastAPI()

class Todo(BaseModel):
    id: int
    title: str
    done: bool = False
    due: Optional[date] = None

todos: list[Todo] = []   # 메모리 저장소
_next_id = 1
# ... 엔드포인트들 ...
```

의존성 설치 승인이 뜨면 의미를 확인하고 승인하세요(019번).

## Step 3. 검증 (테스트 포함)

```text
test_todo_api.py 를 만들어서 FastAPI TestClient로 검증해줘:
- 할 일 추가 후 목록에 나오는지
- 제목 없이 추가하면 400인지
- 없는 id 토글/삭제 시 404인지
그리고 pytest를 실행해서 결과를 보여줘.
```

테스트가 통과하는 걸 눈으로 확인하세요. 통과 못 하면 Codex가 원인을 찾아 고칠 겁니다(이게 검증의 힘, 026번).

## Step 4. 직접 실행해보기

```text
서버를 실행하는 방법을 알려줘.
```

보통:

```bash
uvicorn todo_api:app --reload
```

브라우저에서 `http://127.0.0.1:8000/docs` 를 열면 FastAPI가 자동 생성한 API 문서(Swagger UI)가 나옵니다. 여기서 직접 할 일을 추가/조회해 보세요.

## Step 5. 변경 검토 & 커밋

```text
/diff
```
변경을 검토한 뒤:

```bash
git add todo_api.py test_todo_api.py
git commit -m "Add in-memory Todo CRUD API with tests"
```

## Step 6. 2차 — SQLite로 저장 (쪼개기의 다음 단계)

```text
이제 저장소를 메모리에서 SQLite로 바꾸자.
- todos 테이블 (id, title, done, due)
- 서버 재시작해도 데이터가 유지되게
- 기존 테스트가 그대로 통과하도록 (필요하면 테스트도 조정)
변경 후 pytest를 다시 돌려줘.
```

> 데이터 영속성이 생겼습니다. TaskFlow가 한 걸음 더 진짜 서비스에 가까워졌습니다.

## 회고

이번 실습에서 당신은:
- 계획 → 메모리 CRUD → 테스트 → 실행 → SQLite로 쪼개서 진행
- 매 단계 테스트로 검증
- AGENTS.md 규칙이 자동 적용되는 걸 경험
- `/diff`와 git으로 안전하게 관리

이게 실무 백엔드 개발의 표준 리듬입니다.

## 도전 과제

- `GET /todos?done=false` 처럼 필터 추가 + 테스트
- 마감일(`due`) 기준 정렬 추가
- 완료한 일 개수를 반환하는 `/todos/stats`

각 기능마다 테스트로 검증하는 습관 유지!

## 정리

- TaskFlow의 첫 코드: Todo CRUD API + 테스트 완성
- 메모리 → SQLite로 단계적 확장(쪼개기)
- 계획·검증·diff·커밋의 실무 리듬 체득
- 도전 과제로 기능 확장 연습

---

다음 절에서 중급에서 흔한 실수를 정리합니다.

> `images/058_todo_api.png` — 부록 프롬프트 참고
