# 080. app-server JSON-RPC 프로토콜

![그림 80-1. 모든 클라이언트가 붙는 app-server](images/080_appserver.png)

SDK·IDE 확장·데스크톱 앱은 모두 같은 곳에 연결됩니다 — **app-server**. 이 절에서 그 통합 진입점을 이해합니다.

## app-server란

> Codex 엔진을 **JSON-RPC**로 노출하는 서버. SDK·IDE·앱이 모두 이 서버를 통해 엔진과 통신합니다.

062번의 SQ/EQ 큐가 "엔진 내부의 메시지 모델"이라면, app-server는 그것을 **외부 클라이언트가 쓸 수 있는 표준 인터페이스**로 감싼 것입니다.

```text
        ┌──────────── app-server (JSON-RPC) ────────────┐
        │                                                │
   [Python SDK]   [TypeScript SDK]   [IDE 확장]   [데스크톱 앱]
```

## JSON-RPC란

간단한 원격 호출 규약입니다. "메서드 이름 + 인자"를 JSON으로 보내고 결과를 JSON으로 받습니다.

```json
{ "method": "thread/start", "params": { ... } }
```

## 주요 메서드 그룹

app-server는 도메인별로 메서드를 제공합니다.

**thread/* — 스레드 생명주기**
```text
thread/start, thread/resume, thread/fork, thread/rollback,
thread/list, thread/read, thread/archive, thread/delete,
thread/compacted, thread/search ...
```
063번의 Session·Task·Turn, `/fork`·`resume`이 여기에 대응됩니다.

**turn/* — 턴 제어**
```text
turn/start, turn/interrupt, turn/steer, turn/completed ...
```
`turn/steer`는 진행 중 방향을 트는 조향(044번)입니다.

**process/* — 프로세스(PTY)**
```text
process/spawn, process/kill, process/writeStdin,
process/resizePty, process/outputDelta, process/exited
```

**fs/* — 파일시스템**
```text
fs/readFile, fs/writeFile, fs/watch, fs/changed,
fs/copy, fs/remove, fs/createDirectory, fs/readDirectory
```

**그 외**: `model/*`, `config/*`, `hook/*`, `skills/*`, `plugin/*`, `mcpServerStatus/*`, `account/*`, `review/start` 등.

## 왜 이 구조인가

- **한 엔진, 여러 클라이언트**: SDK든 IDE든 같은 메서드를 쓰므로 일관됨(011번 "네 가지 얼굴"의 기술적 토대)
- **언어 독립**: JSON-RPC라 어떤 언어에서도 클라이언트를 만들 수 있음
- **세밀한 제어**: fork·rollback·steer 같은 고급 동작까지 1급 지원

## SDK와의 관계

당신이 78번에서 쓴 Python SDK의 `thread_start()`·`run()`은 내부적으로 이 app-server 메서드(`thread/start` 등)를 호출합니다. SDK는 app-server를 **편하게 감싼 래퍼**인 셈입니다.

```text
SDK.thread_start()  →  JSON-RPC "thread/start"  →  엔진(SQ/EQ)
```

## 직접 띄우기 (고급)

app-server를 직접 실행해 커스텀 클라이언트를 붙일 수도 있습니다.

```bash
codex app-server        # app-server 실행 (고급 용도)
codex mcp-server         # Codex를 MCP 서버로 노출 (다른 AI가 Codex를 도구로)
```

> 🔍 `codex mcp-server`는 흥미롭습니다 — Codex 자신을 MCP 서버로 노출해, **다른 AI가 Codex를 하나의 도구로** 부릴 수 있게 합니다.

## 언제 직접 다루나

- 새로운 **에디터/플랫폼 통합**을 만들 때
- 기존 SDK로 안 되는 **세밀한 제어**가 필요할 때
- Codex를 **다른 시스템에 임베드**할 때

대부분의 경우 SDK로 충분하고, app-server는 "그 아래에 이런 게 있다"를 아는 것으로 족합니다.

## 정리

- app-server = 엔진을 **JSON-RPC로 노출**하는 통합 진입점
- SDK·IDE·앱이 모두 이걸 통해 통신(언어 독립)
- 메서드 그룹: thread/* · turn/* · process/* · fs/* · model/* 등
- SDK는 app-server의 래퍼, `codex mcp-server`로 Codex를 도구화 가능

---

다음 절에서 클라우드 실행 환경 — **Codex Cloud와 Environments**를 심화합니다.

> 📷 `images/080_appserver.png` — 부록 프롬프트 참고
