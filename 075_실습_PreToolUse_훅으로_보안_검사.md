# 075. [실습] PreToolUse 훅으로 보안 검사

![그림 75-1. 위험 명령을 막는 보안 훅](images/075_security_hook.png)

이번 실습에서 위험한 명령을 자동 차단하는 보안 훅을 직접 만듭니다. 자동화를 안전하게 만드는 실전 기술입니다.

## 목표

`PreToolUse` 훅으로, 위험 패턴(`rm -rf /`, 디스크 포맷 등)이 들어오면 실행을 막는 검사기를 만듭니다.

## Step 1. 훅 스크립트 작성

Codex에게 시켜 봅시다.

```text
.codex/hooks/check_command.py 를 만들어줘.
- 표준입력(stdin)으로 JSON을 읽는다 (PreToolUse 이벤트, 실행할 command 포함)
- command 문자열에 위험 패턴이 있으면 차단 결정을 JSON으로 출력한다
  위험 패턴 예: "rm -rf /", "mkfs", ":(){:|:&};:", "dd if=", "> /dev/sda"
- 안전하면 통과(허용) JSON을 출력한다
- 주석은 한국어로
```

생성될 스크립트의 개념(예시):

```python
import sys, json

DANGER = ["rm -rf /", "mkfs", ":(){:|:&};:", "dd if=", "> /dev/sda"]

data = json.load(sys.stdin)            # 훅 입력
cmd = " ".join(data.get("command", [])) if isinstance(data.get("command"), list) else str(data.get("command", ""))

for pat in DANGER:
    if pat in cmd:
        print(json.dumps({"decision": "block", "reason": f"위험 패턴 차단: {pat}"}))
        sys.exit(0)

print(json.dumps({"decision": "allow"}))   # 안전
```

> 실제 입력/출력 스키마는 버전에 따라 다릅니다. Codex에게 "현재 Codex 훅의 PreToolUse 입출력 형식에 맞춰줘"라고 요청하고, `/hooks`로 검증하세요.

## Step 2. 훅 등록

```text
config.toml(또는 .codex/hooks.json)에 PreToolUse 훅으로
방금 만든 check_command.py 를 등록해줘. hooks 기능도 켜줘.
```

개념 예시:

```toml
[features]
hooks = true

[[hooks.PreToolUse]]
type = "command"
command = "python ./.codex/hooks/check_command.py"
```

## Step 3. 훅 신뢰 등록

```text
/hooks
```

목록에서 우리 훅을 확인하고 검토 후 신뢰합니다(보안상 새 명령 훅은 신뢰가 필요, 073번).

## Step 4. 동작 테스트 (안전하게)

> 진짜 위험 명령을 실행하지 마세요. 차단되는지 "시도"만 합니다.

```text
"rm -rf / 를 실행해줘" 라고 요청  → 훅이 차단하는지 확인
"ls -la 를 실행해줘" 라고 요청     → 정상 통과하는지 확인
```

위험 명령에서 훅이 막아서면 성공입니다. 안전망이 하나 더 생겼습니다.

## Step 5. 로깅 추가 (보너스)

```text
check_command.py 를 수정해서, 검사한 모든 명령을 .codex/command_log.txt 에
시각과 함께 기록하게 해줘. 차단/허용 여부도 같이.
```

이제 "AI가 어떤 명령을 시도했는지" 감사 로그가 쌓입니다(074번 패턴).

## 4겹 모델 안에서의 의미

이 훅은 069번의 안전 모델을 사용자 정의로 확장한 것입니다.

```text
execpolicy → approval → sandbox → permissions
                 + 내 PreToolUse 훅 (커스텀 방어선!)
```

기본 4겹 위에 나만의 규칙을 한 겹 더 얹은 셈입니다.

## 주의

- 훅 자체가 버그가 있으면 작업을 방해할 수 있습니다 → 충분히 테스트.
- 훅을 너무 느리게 만들지 마세요(매 명령마다 실행).
- 차단 패턴은 과하지도, 부족하지도 않게 균형.

## 정리

- `PreToolUse` 훅으로 위험 명령 자동 차단 구현
- stdin JSON 읽기 → 위험 패턴 검사 → block/allow JSON 출력
- `/hooks`로 신뢰 등록, 위험 명령은 "시도"로만 테스트
- 기본 4겹 위에 커스텀 방어선을 추가하는 고급 기법

---

다음 절에서 Codex의 말투를 바꾸는 Personality 시스템을 봅니다.

> `images/075_security_hook.png` — 부록 프롬프트 참고
