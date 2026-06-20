# 013. Codex CLI 설치하기 (Mac / Linux / Windows)

이제 진짜 Codex를 컴퓨터에 설치합니다. 운영체제에 맞는 방법 하나만 고르면 됩니다.

## 방법 1: 설치 스크립트 (가장 쉬움)

macOS / Linux
```bash
curl -fsSL https://chatgpt.com/codex/install.sh | sh
```

Windows (PowerShell)
```powershell
powershell -ExecutionPolicy ByPass -c "irm https://chatgpt.com/codex/install.ps1 | iex"
```

이 한 줄이 알아서 최신 버전을 받아 설치합니다.

## 방법 2: 패키지 매니저

이미 개발 도구가 깔려 있다면 이 방법도 좋습니다.

npm (Node.js 사용자)
```bash
npm install -g @openai/codex
```

Homebrew (macOS)
```bash
brew install --cask codex
```

## 방법 3: 직접 다운로드

[GitHub Releases](https://github.com/openai/codex/releases/latest) 에서 운영체제에 맞는 바이너리를 내려받아도 됩니다.

| 플랫폼 | 파일 |
|---|---|
| macOS (Apple Silicon) | `codex-aarch64-apple-darwin.tar.gz` |
| macOS (Intel) | `codex-x86_64-apple-darwin.tar.gz` |
| Linux | `codex-x86_64-unknown-linux-...tar.gz` |

> TIP 초보자는 방법 1(설치 스크립트)을 추천합니다. 가장 적게 고민하고 끝납니다.

## 설치 확인

설치가 끝났으면 터미널에서 버전을 확인합니다.

```bash
codex --version
```

버전 번호(예: `codex 0.xx.x`)가 나오면 설치 성공!

```bash
# 도움말도 한번 봐두세요
codex --help
```

## 잘 안 될 때

`command not found: codex`
→ 터미널을 완전히 껐다 켜 보세요. 그래도 안 되면 PATH 설정 문제일 수 있습니다. 설치 스크립트가 안내한 경로를 확인하세요.

npm 권한 오류 (`EACCES`)
→ 전역 설치 권한 문제입니다. 설치 스크립트(방법 1)로 다시 시도하거나, npm 전역 경로 권한을 조정하세요.

Windows에서 스크립트 실행이 막힘
→ `ExecutionPolicy ByPass` 옵션이 포함된 명령(위 방법 1)을 그대로 쓰세요.

> 깊이 보기 Codex CLI는 Rust로 작성된 오픈소스(Apache-2.0)입니다. 그래서 단일 실행 바이너리로 가볍게 배포되고, 원하면 소스에서 직접 빌드할 수도 있습니다. 내부 구조는 Part 3(061번~)에서 깊이 다룹니다.

## 정리

- 설치는 스크립트 한 줄이 가장 쉽다 (Mac/Linux/Windows 각각 제공)
- npm·Homebrew·직접 다운로드도 가능
- `codex --version` 으로 확인
- 안 되면 터미널 재시작부터

---

설치를 마쳤으니, 다음 절에서 로그인하고 첫 실행을 해봅시다.
