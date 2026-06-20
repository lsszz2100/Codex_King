# 068. 명령 정책 execpolicy와 Starlark DSL

19번에서 "안전한 명령은 자동 허용, 위험한 건 승인"이라고 했습니다. 그 판단을 내리는 게 execpolicy 입니다. 샌드박스와는 다른 계층의 안전장치입니다.

## execpolicy란

> 어떤 명령을 자동 허용 / 질문 / 금지할지 선언적으로 정의하는 정책 시스템.

샌드박스(070번)가 "OS가 물리적으로 막는" 것이라면, execpolicy는 "이 명령을 애초에 실행해도 되는가"를 명령 의미 수준에서 판단합니다.

## 세 가지 결정(Decision)

정책은 각 명령을 셋 중 하나로 분류합니다.

| Decision | 의미 |
|---|---|
| `Allow` | 추가 승인 없이 실행 가능 |
| `Prompt` | 사용자 승인 요청 (`approval_policy="never"`면 거부됨) |
| `Forbidden` | 무조건 차단 |

## Starlark DSL로 정의

정책은 Starlark라는 작은 언어(파이썬 비슷한 설정 언어)로 작성됩니다. `define_program()`으로 프로그램별 규칙을 정의합니다.

```python
define_program(
    program="cat",
    system_path=["/bin/cat", "/usr/bin/cat"],
    options=[flag("-b"), flag("-n"), flag("-t")],
    args=[ARG_RFILES],          # 읽기 파일 인자
    should_match=[              # 이 호출은 매칭되어야 함
        ["file.txt"],
        ["-n", "file.txt"],
    ],
    should_not_match=[          # 이 호출은 매칭되면 안 됨
        [],                     # 인자 없는 cat (stdin 읽기) 거부
        ["-l", "file.txt"],     # advisory lock 자동허용 거부
    ],
)
```

핵심 요소:
- `flag()` / `opt()` — 허용할 옵션 정의
- `ARG_RFILES`(읽기 파일), `ARG_WFILE`(쓰기 파일) 등 — 인자 매처
- `should_match` / `should_not_match` — 정책 자체를 자가 테스트 (규칙에 단위테스트 내장!)

> 정책에 테스트가 내장되어 있다는 점이 인상적입니다. 규칙이 의도대로 동작하는지 정책 파일이 스스로 검증합니다.

> 참고: 위 `define_program`·`should_match` 형식은 초기(legacy) 정책 API(`execpolicy-legacy`)입니다. 현재 `codex-rs/execpolicy` 크레이트는 "접두사(prefix) 기반 Starlark 규칙"으로 재구성됐습니다(내부적으로 `add_prefix_rule` 등). 결정(Allow/Prompt/Forbidden)과 Starlark로 정의한다는 원리는 동일하니, 정확한 현행 문법은 저장소를 확인하세요.

## 자동 허용은 "읽기 위주 소수"뿐

기본 정책에서 승인 없이 자동 허용되는 명령은 사실상 안전한 읽기 명령 소수입니다. 대표적으로:

```text
cat, ls, head, cp, pwd, rg, sed, which, printenv ...
```

이 목록 밖의 명령(설치·삭제·네트워크 등)은 대부분 `Prompt`(승인 요청)로 갑니다. 그래서 `pip install`은 묻고, `ls`는 안 묻는 거죠(019번).

## execpolicy vs 샌드박스 vs 승인

헷갈리기 쉬우니 정리합니다.

| 계층 | 질문 | 예 |
|---|---|---|
| execpolicy | "이 명령이 애초에 허용/질문/금지인가?" | `rm -rf`는 위험 분류 |
| 승인 정책 | "사용자에게 물어볼까?" | `Prompt`면 물음 |
| 샌드박스 | "OS가 물리적으로 막을까?" | 폴더 밖 쓰기 차단 |

세 계층이 독립적으로 작동해, 하나가 느슨해도 다른 게 막습니다(다음 절 069번에서 종합).

## 직접 점검하기

Codex CLI에는 정책을 점검하는 서브커맨드가 있습니다.

```bash
codex execpolicy --help      # 정책 관련 기능
```

특정 명령이 어떤 결정을 받는지 확인하는 용도로 쓸 수 있습니다.

## 커스터마이즈 (고급)

조직·프로젝트에 따라 정책을 조정해, 특정 명령을 추가 허용하거나 더 엄격히 금지할 수 있습니다. 단 느슨하게 푸는 건 신중히 — 안전장치를 약화시키는 일입니다.

## 정리

- execpolicy = 명령을 Allow/Prompt/Forbidden으로 분류하는 정책
- Starlark DSL(`define_program`)로 선언, `should_match`로 자가 테스트
- 자동 허용은 읽기 위주 소수 명령뿐, 나머지는 승인 요청
- 샌드박스·승인과 독립된 계층 (069번에서 종합)

---

다음 절에서 이 모든 안전장치를 한데 모은 4겹 권한 모델을 봅니다.
