# templates — 바로 쓰는 샘플 모음

《GPT & Codex 기초부터 고급까지 100》 독자가 복붙해서 바로 시작할 수 있는 설정·규칙 샘플입니다. 자신의 프로젝트에 맞게 고쳐 쓰세요.

| 파일 | 용도 | 관련 절 |
| --- | --- | --- |
| [`AGENTS.md`](AGENTS.md) | 프로젝트 규칙(명령·컨벤션·금지사항)을 Codex에 주입 | 034·035·036 |
| [`config.toml`](config.toml) | 안전한 기본값의 Codex 설정 | 031·032·097 |
| [`hooks/block-dangerous.sh`](hooks/block-dangerous.sh) | 위험 명령을 막는 PreToolUse 훅 | 073·074·075 |

## 쓰는 법

- **AGENTS.md** → 프로젝트 루트에 `AGENTS.md`로 복사 후 내용 수정.
- **config.toml** → `~/.codex/config.toml`(유저) 또는 프로젝트 `.codex/config.toml`로 복사 후 필요한 줄만 남김.
- **block-dangerous.sh** → 실행 권한 부여(`chmod +x`) 후 훅으로 등록(`/hooks` 또는 설정 참고).

> 키 이름·훅 스키마는 Codex 버전에 따라 달라질 수 있습니다. 적용 후 `/debug-config`, `/hooks`, 공식 문서로 현재 환경을 확인하세요.
