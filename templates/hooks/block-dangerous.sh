#!/usr/bin/env bash
# PreToolUse 훅 샘플 — 위험 명령 차단 (본문 073~075번 참고)
#
# 표준입력(JSON)에서 실행하려는 명령을 읽어, 파괴적 명령이면 거부한다.
# 정확한 훅 입력 스키마·등록 방법은 공식 문서/`/hooks`로 확인하세요(버전에 따라 다름).
# jq가 필요합니다: https://jqlang.github.io/jq/

set -euo pipefail

input="$(cat)"
cmd="$(printf '%s' "$input" | jq -r '.command // .tool_input.command // empty')"

case "$cmd" in
  *"rm -rf /"* | *"rm -rf ~"* | *":(){ :|:& };:"* | *"mkfs"* | *"dd if="* | *"git push --force"* | *"git push -f"*)
    printf '{"decision":"deny","reason":"위험 명령 차단: %s"}\n' "$cmd"
    exit 0
    ;;
esac

printf '{"decision":"allow"}\n'
