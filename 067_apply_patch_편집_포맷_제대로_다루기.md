# 067. apply_patch 편집 포맷 제대로 다루기

Codex가 파일을 편집하는 핵심 도구가 apply_patch입니다. 그 포맷을 이해하면 Codex의 편집을 정확히 읽고, 직접 패치를 다룰 수도 있습니다.

## 왜 전체 재작성이 아니라 패치인가

파일 전체를 다시 쓰면:
- 토큰 낭비(큰 파일일수록 심각)
- 의도치 않은 부분까지 바뀔 위험

그래서 Codex는 바뀌는 부분만 교체하는 패치 방식을 씁니다. 안전하고 효율적입니다.

## 기본 구조 (envelope)

패치는 봉투(envelope)로 감쌉니다.

```text
*** Begin Patch
[ 하나 이상의 파일 작업 ]
*** End Patch
```

## 세 가지 파일 작업

각 작업은 헤더로 시작합니다.

```text
*** Add File: <경로>      파일 생성 (이후 모든 줄은 + 로 시작)
*** Delete File: <경로>   파일 삭제 (이후 내용 없음)
*** Update File: <경로>   기존 파일 수정 (선택적으로 이름 변경)
```

`Update File` 뒤에 이름 변경을 붙일 수 있습니다.

```text
*** Update File: src/app.py
*** Move to: src/main.py
```

## 변경 줄(hunk)

`@@` 로 위치를 잡고, 각 줄 앞에 기호를 붙입니다.

```text
@@ def greet():
-print("Hi")
+print("Hello, world!")
```

- ` ` (공백) = 맥락 줄 (그대로)
- `-` = 삭제할 줄
- `+` = 추가할 줄

## 맥락(context)으로 위치 잡기

같은 코드가 여러 번 나오면 어디를 고칠지 모호합니다. 그래서:

- 기본적으로 변경 위아래 3줄의 맥락을 함께 보여 위치를 특정
- 그래도 모호하면 `@@ 함수명/클래스명` 으로 범위를 지정
- 더 모호하면 `@@`를 여러 개 중첩해 정확히 짚음

```text
@@ class PaymentService
@@     def refund(self):
[맥락 3줄]
-        old_code
+        new_code
[맥락 3줄]
```

## 종합 예시

여러 작업을 한 패치에 담을 수 있습니다.

```text
*** Begin Patch
*** Add File: hello.txt
+Hello world
*** Update File: src/app.py
*** Move to: src/main.py
@@ def greet():
-print("Hi")
+print("Hello, world!")
*** Delete File: obsolete.txt
*** End Patch
```

## 중요한 규칙

- 작업마다 헤더 필수(Add/Delete/Update 명시)
- 신규 파일도 모든 줄을 `+`로 시작
- 경로는 상대경로만 (절대경로 금지)

> 이 포맷은 저장소에 정식 Lark 문법(`core/src/tools/handlers/apply_patch.lark`)으로 정의돼 있고, 전용 Rust 파서(`apply-patch` 크레이트의 `parser.rs`·`streaming_parser.rs`)가 이를 엄격히 검증·적용합니다. 그래서 형식이 어긋나면 적용이 거부됩니다.

## 실무에서 어떻게 만나나

평소엔 Codex가 알아서 apply_patch를 씁니다. 당신은 주로:
- `/diff`에서 이 형식 비슷한 변경을 읽고(020번)
- "이 부분만 바꿔줘"처럼 국소 편집을 요청할 때 이 메커니즘의 혜택을 봅니다.

> 큰 파일에서 "딱 이 함수만 고쳐"가 잘 되는 이유가 apply_patch입니다. 반대로 자동생성 파일이나 전체 치환은 apply_patch보다 스크립트가 낫다고 출하 프롬프트도 안내합니다(066번).

## 실습

```text
1. greet.py 에서 한 줄만 바꾸도록 요청
2. /diff 로 변경을 보고, +/- 와 맥락 줄 구조를 직접 확인
3. "이번엔 함수 이름을 바꾸면서 파일도 hello.py로 이동해줘" → Move 동작 관찰
```

## 정리

- apply_patch = 바뀌는 부분만 교체하는 편집 포맷(효율·안전)
- 봉투(`*** Begin/End Patch`) + Add/Delete/Update 작업
- `@@`와 맥락 줄로 정확한 위치 지정, `+/-`로 추가/삭제
- 상대경로만, 헤더 필수, 엄격한 문법 검증

---

다음 절에서 명령 실행을 통제하는 execpolicy(Starlark DSL)를 봅니다.
