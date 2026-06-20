# 082. [실습] GitHub `@codex`로 PR 자동화

![그림 82-1. 이슈에 @codex 멘션으로 PR 생성](images/082_github_codex.png)

클라우드의 진가를 체험합니다. GitHub 이슈에 `@codex`만 멘션하면, Codex가 작업해 PR을 자동 생성합니다.

## 목표

TaskFlow 저장소를 GitHub에 올리고, 이슈에서 `@codex`로 작업을 시켜 PR을 받아봅니다.

## 사전 준비

1. TaskFlow를 GitHub 저장소로 푸시(056번에서 git init 했음)
2. Codex Cloud에서 GitHub 계정 연결(081번)
3. 저장소에 Codex 연동 활성화

```bash
# 로컬 → GitHub (저장소는 미리 GitHub에서 생성)
git remote add origin https://github.com/<당신>/taskflow.git
git push -u origin main
```

> AGENTS.md가 저장소에 커밋돼 있으면(036번), 클라우드 Codex도 같은 규칙으로 일합니다.

## Step 1. 이슈 생성

GitHub 저장소의 Issues 탭에서 새 이슈를 만듭니다.

```text
제목: 할 일 검색 기능 추가
본문:
GET /todos?q=키워드 로 제목에 키워드가 포함된 할 일만 필터링하고 싶어요.
- 대소문자 무시
- 테스트도 함께 추가
@codex 이 기능을 구현해줘.
```

## Step 2. Codex가 일하는 것 지켜보기

`@codex` 멘션을 감지하면 Codex가:
1. 클라우드 격리 환경에서 저장소를 체크아웃
2. AGENTS.md 규칙을 반영해 작업
3. 코드 + 테스트 작성, 검증
4. PR(Pull Request) 자동 생성

잠시 후 저장소에 새 PR이 올라옵니다.

## Step 3. PR 검토

생성된 PR에서:
- Files changed 탭으로 변경 검토 (`/diff`의 GitHub 버전)
- 테스트가 포함됐는지, 규칙(주석 언어 등)을 지켰는지 확인
- CI가 있다면 통과했는지 확인(083번)

## Step 4. 피드백 주기

PR이 만족스럽지 않으면, PR 코멘트로 다시 요청합니다.

```text
@codex 검색이 제목뿐 아니라 메모(note) 필드도 포함하게 해줘.
그리고 빈 키워드면 전체를 반환하게.
```

Codex가 PR을 업데이트합니다. 사람 리뷰어와 협업하듯 진행됩니다.

## Step 5. 병합

만족스러우면 PR을 머지합니다. 기능이 main에 반영됩니다.

```text
검토 → 승인 → Merge → 완료
```

## 이 워크플로의 힘

- 비동기: 이슈만 남기면 알아서 작업 → 자고 일어나니 PR이
- 팀 친화: 모든 작업이 PR로 남아 리뷰·추적 가능
- 반복 처리: 여러 이슈에 `@codex`를 달면 병렬로 처리

> 이것이 "1인 개발자가 팀처럼 일하는" 바이브 코딩의 정점입니다.

## 주의

- `@codex`가 만든 PR도 반드시 사람이 검토 후 머지하세요.
- 민감 저장소는 권한·접근을 신중히 설정.
- 클라우드 환경의 secret·인터넷 정책을 확인(081번).

## 도전 과제

TaskFlow에 이슈 두 개를 동시에 만들어 각각 `@codex`를 달아보세요.
- "마감일 지난 할 일을 표시하는 기능"
- "할 일 개수 통계 엔드포인트"

병렬로 PR이 생성되는 걸 관찰하세요.

## 정리

- GitHub 이슈/PR에서 `@codex` 멘션 → 작업 → PR 자동 생성
- 클라우드 격리 환경에서 AGENTS.md 규칙대로 작업
- PR 코멘트로 피드백 반복(사람과 협업하듯)
- 생성 PR은 사람 검토 후 머지, 병렬 처리 가능

---

다음 절에서 GitHub Actions에 Codex를 통합합니다.

> `images/082_github_codex.png` — 부록 프롬프트 참고
