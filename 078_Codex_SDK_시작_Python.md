# 078. Codex SDK 시작 (Python)

파이썬 사용자를 위한 SDK입니다. TaskFlow가 파이썬 백엔드이니, 파이썬 SDK로 자동화를 붙이기 좋습니다.

## 설치

Python 3.10 이상이 필요합니다.

```bash
pip install openai-codex
```

> Python SDK는 내부적으로 로컬 Codex app-server(080번)를 JSON-RPC로 제어합니다.

## 가장 간단한 예제

```python
from openai_codex import Codex

with Codex() as codex:
    thread = codex.thread_start(model="gpt-5.5")
    result = thread.run("이 폴더의 테스트를 실행하고 결과를 요약해줘")
    print(result.final_response)
```

`with` 블록으로 리소스를 안전하게 관리합니다.

## 대화 이어가기

```python
with Codex() as codex:
    thread = codex.thread_start(model="gpt-5.5")
    thread.run("todo_api.py에 검색 기능을 추가해줘")
    thread.run("방금 기능의 테스트도 작성하고 실행해줘")  # 맥락 유지
```

## 비동기 지원

비동기 앱에서는 `AsyncCodex`를 씁니다.

```python
import asyncio
from openai_codex import AsyncCodex

async def main():
    async with AsyncCodex() as codex:
        thread = codex.thread_start(model="gpt-5.4-mini")
        result = await thread.run("README를 한 문단으로 요약해줘")
        print(result.final_response)

asyncio.run(main())
```

## 샌드박스 프리셋

```python
from openai_codex import Codex, Sandbox

with Codex() as codex:
    thread = codex.thread_start(
        model="gpt-5.5",
        # 샌드박스 수준 (개념): read_only | workspace_write | full_access
    )
```

(정확한 인자명은 버전·문서를 확인하세요. 안전 경계는 069번 원칙대로.)

## 실전 예: 저장소 일괄 점검 도구

```python
from openai_codex import Codex

REPOS = ["service-a", "service-b", "service-c"]

def audit(repo: str) -> str:
    with Codex() as codex:
        thread = codex.thread_start(model="gpt-5.4")
        r = thread.run(
            "보안상 위험한 패턴(하드코딩된 비밀키 등)이 있는지 점검하고 "
            "발견 사항을 목록으로 요약해줘."
        )
        return r.final_response

for repo in REPOS:
    print(f"== {repo} ==")
    print(audit(repo))
```

> 여러 저장소를 순회하며 자동 보안 점검하는 도구가 짧게 완성됩니다.

## TypeScript SDK와 비교

| | TypeScript | Python |
|---|---|---|
| 패키지 | `@openai/codex-sdk` | `openai-codex` |
| 런타임 | Node 18+ | Python 3.10+ |
| 비동기 | async/await 기본 | `AsyncCodex` |
| 잘 맞는 곳 | 웹·Node 생태계 | 데이터·백엔드·스크립트 |

둘 다 같은 Codex 엔진을 제어하므로, 익숙한 언어를 고르면 됩니다.

## 실습

```text
Codex에게 시켜보세요:
"openai-codex(파이썬)로, 인자로 받은 파이썬 파일의 함수 목록과
각 함수가 하는 일을 한 줄씩 출력하는 스크립트를 만들어줘.
requirements와 실행법도 함께."
```

## 정리

- Python SDK: `pip install openai-codex`(3.10+), 로컬 app-server를 JSON-RPC로 제어
- `thread_start()` → `run()`, `with` 블록으로 관리, `AsyncCodex`로 비동기
- 샌드박스 프리셋으로 안전 경계
- 데이터·백엔드·일괄 처리 자동화에 적합

---

다음 절에서 SDK로 실제 작은 에이전트 앱을 만들어 봅니다.
