# 083. GitHub Actions에 Codex 통합

![그림 83-1. CI 파이프라인에 Codex 통합](images/083_actions.png)

`codex exec`(055번)와 SDK(077번)를 CI/CD에 넣으면, PR마다 자동으로 Codex가 일하는 파이프라인을 만들 수 있습니다.

## 무엇을 자동화할 수 있나

- PR 올라오면 자동 코드 리뷰 → 코멘트
- 실패한 테스트를 자동 분석·수정 제안
- 변경에 맞춰 문서·체인지로그 자동 갱신
- 보안 점검 자동 실행

## 기본 구조

GitHub Actions는 `.github/workflows/*.yml`로 정의합니다. Codex를 한 단계로 넣습니다.

```yaml
name: Codex Review
on:
  pull_request:
    types: [opened, synchronize]

jobs:
  codex-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Codex
        run: npm install -g @openai/codex

      - name: Run Codex review
        env:
          OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
        run: |
          codex exec --ask-for-approval never \
            "이 PR의 변경을 리뷰하고, 버그·보안 위험을 review.md로 정리해줘"

      - name: Upload report
        uses: actions/upload-artifact@v4
        with:
          name: codex-review
          path: review.md
```

> 개념 예시입니다. 실제 인증·러너 설정은 공식 문서(developers.openai.com/codex)와 최신 액션을 확인하세요.

## 핵심 포인트

### 1) 비대화형 + 안전 경계
CI엔 사람이 없으므로 `--ask-for-approval never`가 필요합니다. 대신 격리된 러너 + 제한된 권한으로 4겹 안전(069번)을 유지하세요.

### 2) Secret 관리
```yaml
env:
  OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
```
키는 GitHub Secrets에 저장하고 환경변수로 주입. 절대 워크플로 파일에 직접 쓰지 마세요.

### 3) 결과 활용
- 아티팩트로 업로드
- PR에 코멘트로 게시
- 심각한 문제면 체크 실패로 머지 차단

## 실전 패턴 1: 자동 리뷰 게이트

```text
PR 생성 → Codex 리뷰 → 심각한 문제 발견 시 종료코드 1 → 머지 차단
```

079번의 리뷰 봇을 CI에 올리면 됩니다. "사람 리뷰 전 1차 AI 게이트".

## 실전 패턴 2: 야간 유지보수

```yaml
on:
  schedule:
    - cron: "0 18 * * *"   # 매일 정해진 시각
```

```text
정기 실행 → 의존성 취약점 점검 / 오래된 문서 갱신 → PR 자동 생성
```

## 실전 패턴 3: 이슈 → 자동 작업

`@codex`(082번)는 클라우드가 처리하지만, Actions로도 커스텀 자동화를 짤 수 있습니다(라벨이 붙으면 특정 작업 실행 등).

## 거버넌스

- AI가 만든 변경도 사람 승인 후 머지 (자동 머지 신중히)
- CI에서 AI에 주는 권한을 최소화
- 비용 모니터링(CI에서 토큰을 많이 쓸 수 있음)
- 감사 로그 유지(누가/언제/무엇을)

## 실습

```text
Codex에게 시켜보세요:
"내 저장소에 PR이 올라오면 codex exec로 변경을 리뷰해 review.md를 만들고
아티팩트로 올리는 GitHub Actions 워크플로(.github/workflows/review.yml)를 만들어줘.
OPENAI_API_KEY는 secrets에서 읽도록."
```

(실제 동작시키려면 저장소 Secrets에 키 등록이 필요합니다.)

## 정리

- `codex exec`/SDK를 GitHub Actions에 넣어 PR·정기 자동화
- 비대화형(`never`) + 격리 러너·최소 권한으로 안전 유지
- 키는 GitHub Secrets, 결과는 코멘트/아티팩트/체크로
- AI 변경도 사람 승인 후 머지, 거버넌스 필수

---

다음 절에서 보안과 거버넌스, 그리고 Codex Security를 다룹니다.

> `images/083_actions.png` — 부록 프롬프트 참고
