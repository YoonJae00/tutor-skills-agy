# tutor-skill (튜터 스킬)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-skill-blue)](https://docs.anthropic.com/en/docs/claude-code)
[![Antigravity CLI](https://img.shields.io/badge/Antigravity_CLI-skill-orange)](#)
[![Install with npx skills](https://img.shields.io/badge/npx_skills-add-green)](https://github.com/vercel-labs/skills)

텍스트 문서나 소스 코드를 분석하여 **Obsidian StudyVault(학습 공간)**를 생성하고, 이를 바탕으로 맞춤형 퀴즈 피드백을 제공하는 [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 및 [Antigravity CLI (agy)](#) 전용 에이전트 스킬 세트입니다. 정보 추출부터 최종 학습 완성까지 유기적인 흐름을 지원합니다.

## 작동 방식

```
  문서 / 소스 코드                      Obsidian                    퀴즈 세션
 ┌──────────────────┐           ┌──────────────────┐          ┌──────────────────┐
 │  PDF, MD, HTML,  │  /tutor   │   StudyVault/    │  /tutor  │  라운드당 4문항,   │
 │  EPUB, 소스 코드  │──setup──▶ │   구조화된 요약   │────────▶ │  채점 및 피드백,  │
 │  프로젝트         │           │   노트 + 대시보드 │          │  개념 단위 진도   │
 └──────────────────┘           └──────────────────┘          └────────┬─────────┘
                                         ▲                             │
                                         └─────── 학습 진도 업데이트 ───┘
```

## 스킬 개요

| 스킬명 | 실행 명령어 | 주요 기능 | 입력 | 출력 |
|-------|---------|---------|-------|--------|
| **tutor-setup** | `/tutor-setup` | StudyVault(학습 노하우 공간) 생성 | 문서 또는 소스 코드 프로젝트 | 요약 노트, 대시보드, 연습 문제를 포함한 Obsidian Vault |
| **tutor** | `/tutor` | 메타인지 기반 인터랙티브 퀴즈 | 생성된 StudyVault 자료 | 개념 단위 학습 진도 및 오답을 기록하는 실시간 학습 세션 |

## 빠른 시작

### 한 줄 설치 (Claude Code 전용)

```bash
npx skills add RoundTable02/tutor-skills
```

> [npx skills](https://github.com/vercel-labs/skills)가 필요합니다. Claude Code, Cursor, Windsurf 등 다양한 도구에서 연동 가능합니다.

### 수동 설치 (Antigravity CLI 및 Claude Code 모두 권장)

```bash
git clone https://github.com/RoundTable02/tutor-skills.git
cd tutor-skills
./install.sh
```

### 1단계: StudyVault 생성

* **Claude Code 사용 시**:
  ```bash
  cd ~/study-materials/          # 학습 파일 또는 소스 코드가 있는 디렉토리로 이동
  claude
  > /tutor-setup
  ```

* **Antigravity CLI (agy) 사용 시**:
  ```bash
  cd ~/study-materials/          # 학습 파일 또는 소스 코드가 있는 디렉토리로 이동
  agy
  > /tutor-setup
  ```

### 2단계: 퀴즈 풀며 공부하기

* **Claude Code 사용 시**:
  ```bash
  claude
  > /tutor
  ```

* **Antigravity CLI (agy) 사용 시**:
  ```bash
  agy
  > /tutor
  ```

---

## tutor-setup

입력받은 리소스를 읽고 구조화된 Obsidian StudyVault를 자동으로 구축합니다. 현재 작업 디렉토리(CWD) 내 파일들을 검사하여 모드를 자동 감지합니다:

| 디렉토리 내 감지된 파일 | 모드 |
|---|---|
| `package.json`, `pom.xml`, `build.gradle`, `Cargo.toml`, `go.mod` 등 | 코드베이스 모드 (Codebase Mode) |
| 프로젝트 설정 파일 없음 | 문서 분석 모드 (Document Mode) |

### 문서 분석 모드 (Document Mode)

PDF, 텍스트, 웹페이지, Epub 소스 등을 체계적인 개념 노트로 변환합니다.

* 현재 디렉토리 내 원본 소스 파일 자동 탐색 및 사용자 컨펌
* **텍스트 추출 (필수 가이드)**: PDF의 경우 직접 Read 도구를 쓰지 않고 `pdftotext` CLI를 사용하여 텍스트 변환 후 읽어 토큰을 최소화합니다.
* 개념 노트 생성: 개념 요약, 다이어그램, 비교 테이블 등으로 작성
* 연습 문제 생성: 액티브 리콜을 돕기 위한 **숨겨진 정답(접기 콜아웃)** 적용 (단원별 8문제 이상)
* 대시보드 구축: MOC(목차), 공식 요약, 자주 함정에 빠지는 시험 팁 정리
* 위키링크(`[[wiki-links]]`)를 활용한 노트 간의 촘촘한 연결망 구축

### 코드베이스 모드 (Codebase Mode)

처음 투입된 개발자를 위한 소스 코드 온보딩 가이드를 생성합니다.

* 기술 스택, 아키텍처 패턴, 모듈 경계 분석
* 요청 및 데이터 흐름 추적
* 모듈별 핵심 파일 명세, 주요 API 구조 기술
* 코드 리딩, 디버깅, 간단한 기능 확장 미션 등을 담은 온보딩 과제 생성

---

## tutor

학습 대시보드를 기반으로 내가 확실히 아는 부분과 헷갈리는 부분을 **개념 단위(Concept level)**로 정확히 진단해 주는 퀴즈 튜터 스킬입니다.

### 세션 종류

| 세션 유형 | 제공 조건 | 학습 초점 |
|------|----------------|-------|
| Diagnostic (전체 진단) | 측정되지 않은 개념(⬜)이 존재할 때 | 새로운 영역에 대한 종합적인 진단 |
| Drill weak areas (취약점 훈련) | 약한 부분(🟥/🟨)이 있을 때 | 오답 기록이 있는 영역의 반복 훈련 |
| Choose a section (단원 선택) | 항상 | 공부하고 싶은 단원을 사용자가 직접 지정 |
| Hard-mode review (심화 복습) | 전체 영역 마스터(🟩/🟦) 시 | 깊이 있는 개념 검증 및 난이도 상승 복습 |

### 진행 순서

1. 생성된 StudyVault 및 대시보드를 탐색합니다.
2. 현재 학습 수준에 최적화된 퀴즈 세션을 제안하고 사용자의 선택을 받습니다.
3. 라운드당 4문항을 출제합니다. (힌트 없음, 4지 선다형)
4. 채점을 완료한 후 세부 오답 분석 및 정답 근거를 설명합니다.
5. 관련 개념 노트 및 전체 학습 대시보드를 실시간 업데이트합니다.

### 진도 및 숙련도 관리 기준

각 단원별 또는 핵심 개념 단위의 정확도를 점수로 환산하여 숙련도를 설정합니다.

| 아이콘 Badge | 등급 | 점수 구간 |
|-------|-------|------|
| 🟥 | Weak (취약) | 0–39% |
| 🟨 | Fair (보통) | 40–69% |
| 🟩 | Good (우수) | 70–89% |
| 🟦 | Mastered (마스터) | 90–100% |
| ⬜ | Unmeasured (측정 전) | 기록 없음 |

---

## 필수 요구사항

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) 또는 [Antigravity CLI (agy)](#) 설치 및 연동 완료
- 생성된 요약 및 문제를 열어보고 공부하기 위해 [Obsidian](https://obsidian.md/) 뷰어 권장

## 삭제 방법

```bash
./uninstall.sh
```

또는 수동 삭제:

```bash
# Claude Code:
rm -rf ~/.claude/skills/tutor-setup
rm -rf ~/.claude/skills/tutor

# For Antigravity CLI (agy):
rm -rf ~/.gemini/antigravity-cli/skills/tutor-setup
rm -rf ~/.gemini/antigravity-cli/skills/tutor
```

## 라이선스

[MIT](LICENSE)
