# 070. OS 네이티브 샌드박스 내부 (Seatbelt / landlock)

![그림 70-1. 운영체제별 샌드박스 구현](images/070_native_sandbox.png)

샌드박스(038번)가 "어떻게 OS 수준에서 강제되는지" 그 내부를 봅니다. Codex는 각 운영체제의 네이티브 보안 기능을 직접 활용합니다.

## 왜 OS 네이티브인가

소프트웨어 차원의 "이 명령 하지 마세요"는 우회될 수 있습니다. 하지만 운영체제 커널이 직접 막으면 우회가 거의 불가능합니다. Codex는 그래서 OS의 진짜 샌드박스 기능을 씁니다.

내부적으로 샌드박스 종류는 이렇게 구분됩니다.

```text
SandboxType = None | MacosSeatbelt | LinuxSeccomp | WindowsRestrictedToken
```

## macOS — Seatbelt

- macOS의 Seatbelt 프레임워크를 사용
- 정책은 `.sbpl`(Seatbelt Policy Language) 파일로 정의
- `(deny default)` — 기본은 모두 금지로 시작하고, 필요한 것만 허용(화이트리스트)
- Chrome 브라우저의 샌드박스 정책에서 영감을 받음

```text
(deny default)              ; 닫힌 기본값
(allow process-fork)        ; 필요한 것만 명시적 허용
(allow file-read* ...)
...
```

> 핵심 사상: "기본 차단, 예외 허용". 안전의 정석입니다.

## Linux / WSL2 — bubblewrap + landlock + seccomp

리눅스는 세 기술을 조합합니다.

- bubblewrap(bwrap) — 네임스페이스 격리로 별도 환경 구성
- landlock — 파일시스템 접근을 커널 수준에서 제한
- seccomp — 시스템 콜(syscall) 자체를 필터링

세 겹이 함께 작동해 파일·실행·시스템 접근을 촘촘히 통제합니다. 별도의 `linux-sandbox` 구성요소가 bwrap 실행과 네트워크 프록시 라우팅까지 담당합니다.

## Windows — 제한 토큰 / Windows Sandbox

- 제한된 토큰(restricted token)으로 권한을 낮춰 실행
- 또는 Windows Sandbox 활용
- (WSL2를 쓰면 리눅스 방식의 격리도 가능 — 012번에서 WSL 권장한 이유 중 하나)

## 하위 프로세스까지 가둔다

중요한 특성: 샌드박스는 명령 하나만이 아니라 그 명령이 띄우는 하위 프로세스 전체에 적용됩니다.

```text
codex가 실행한  npm test
   └─ npm 이 띄운  node
        └─ node 가 띄운  하위 프로세스
   ← 이 모든 것이 같은 샌드박스 경계 안
```

그래서 "테스트 러너 안에서 몰래 시스템을 건드리는" 식의 우회가 막힙니다.

## 네트워크 통제

샌드박스 안 네트워크는 권한 프로필(041번)·네트워크 프록시와 함께 통제됩니다. 허용된 도메인만 접근하게 하거나, 아예 차단할 수 있습니다. 관리형 네트워크에서는 프록시를 통해서만 나가도록 라우팅하기도 합니다.

## 플랫폼별 요건

- macOS: Seatbelt 내장 — 추가 설치 불필요
- Linux: `bubblewrap`이 필요할 수 있음(없으면 경고)
- Windows: 네이티브 샌드박스 또는 WSL2

> 환경에 따라 샌드박스가 약하거나 비활성일 수 있습니다. 이럴 땐 승인 정책을 더 보수적으로 가져가세요(4겹 중 다른 겹으로 보완, 069번).

## 직접 확인

```bash
codex doctor       # 환경 점검 (샌드박스 가용성 등)
codex sandbox ...  # 샌드박스 관련 기능
```

`codex doctor`로 현재 머신에서 샌드박스가 제대로 동작하는지 점검할 수 있습니다.

## 정리

- Codex는 OS 네이티브 보안으로 샌드박스를 강제 (우회 어려움)
- macOS=Seatbelt(deny default), Linux=bwrap+landlock+seccomp, Windows=제한 토큰/Sandbox
- 하위 프로세스까지 같은 경계에 가둠
- 네트워크도 통제, `codex doctor`로 가용성 점검

---

다음 절에서 여러 AI를 부리는 서브에이전트 오케스트레이션으로 넘어갑니다.

> `images/070_native_sandbox.png` — 부록 프롬프트 참고
