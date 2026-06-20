# 077. Codex SDK 시작 (TypeScript)

![그림 77-1. SDK로 Codex를 코드에서 제어](images/077_sdk_ts.png)

지금까지는 Codex를 "사용"했습니다. 이제 Codex를 **내 프로그램 안에서 부품처럼 제어**합니다. 그 도구가 SDK입니다. 나만의 AI 도구·자동화를 만들 수 있습니다.

## SDK란

> Codex를 **프로그래밍 방식으로 제어**하는 라이브러리. 내 앱·스크립트·CI에서 Codex 에이전트를 호출합니다.

CLI가 "사람이 터미널에서 쓰는 것"이라면, SDK는 "코드가 Codex를 쓰는 것"입니다.

## 설치 (TypeScript)

Node.js 18 이상이 필요합니다.

```bash
npm install @openai/codex-sdk
```

## 가장 간단한 예제

```typescript
import { Codex } from "@openai/codex-sdk";

const codex = new Codex();
const thread = codex.startThread();        // 스레드 시작
const result = await thread.run("이 폴더의 README를 요약해줘");
console.log(result);
```

이게 전부입니다. `startThread()`로 스레드를 만들고 `run()`으로 작업을 시킵니다.

## 대화 이어가기

같은 스레드에서 `run()`을 반복하면 맥락이 유지됩니다.

```typescript
const thread = codex.startThread();
await thread.run("todo_api.py에 삭제 기능을 추가해줘");
await thread.run("방금 추가한 기능의 테스트도 작성해줘");  // 이전 맥락 이어감
```

## 과거 스레드 재개

스레드 ID로 이전 작업을 다시 이어갈 수 있습니다(063번 `response_id` 개념과 연결).

```typescript
const thread = codex.resumeThread(threadId);
await thread.run("어제 하던 작업을 계속하자");
```

## 샌드박스 프리셋

코드에서도 안전 경계를 지정합니다.

```typescript
// 개념 예시: 샌드박스 수준 지정
const thread = codex.startThread({ sandbox: "workspace-write" });
// "read-only" | "workspace-write" | "full-access"
```

> ⚠️ 자동화에서도 4겹 안전(069번)을 잊지 마세요. 코드로 돌릴수록 경계가 더 중요합니다.

## 활용 시나리오

- 🤖 **나만의 AI CLI 도구** — 특정 작업에 특화된 래퍼
- 🔁 **CI/CD 통합** — PR마다 자동 작업(083번과 연결)
- 🏢 **사내 도구** — 슬랙 봇이 Codex를 호출해 작업
- 📊 **배치 처리** — 여러 저장소를 순회하며 일괄 작업

## 실전 예: 미니 자동화 스크립트

```typescript
import { Codex } from "@openai/codex-sdk";

const codex = new Codex();

async function autoDocument(files: string[]) {
  const thread = codex.startThread({ sandbox: "workspace-write" });
  for (const f of files) {
    const r = await thread.run(`${f} 파일의 모든 함수에 docstring을 추가하고 저장해줘`);
    console.log(`✅ ${f}:`, r);
  }
}

autoDocument(["a.py", "b.py", "c.py"]);
```

> 사람 없이 여러 파일을 자동 문서화하는 도구가 몇 줄로 완성됩니다.

## 오픈소스

SDK는 오픈소스로 GitHub에서 관리됩니다. 예제와 최신 API는 저장소·공식 문서(developers.openai.com/codex/sdk)를 참고하세요.

## 🧪 실습

```text
Codex에게 시켜보세요:
"@openai/codex-sdk 를 써서, 인자로 받은 폴더의 .md 파일들을
각각 3줄로 요약해 콘솔에 출력하는 TypeScript 스크립트를 만들어줘.
package.json과 실행 방법도 함께."
```

만든 스크립트를 직접 돌려보며 "AI를 호출하는 코드"를 경험하세요.

## 정리

- SDK = Codex를 **코드에서 제어**하는 라이브러리 (TS: `@openai/codex-sdk`, Node 18+)
- `startThread()` → `run()`, 같은 스레드로 맥락 유지, `resumeThread()`로 재개
- 샌드박스 프리셋으로 안전 경계 지정
- 나만의 AI 도구·CI 통합·사내 봇 등에 활용

---

다음 절에서 Python SDK를 다룹니다.

> 📷 `images/077_sdk_ts.png` — 부록 프롬프트 참고
