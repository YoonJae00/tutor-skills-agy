# Quiz Design Rules

## Zero-Hint Policy (CRITICAL)

Every question must be answerable ONLY by someone who actually knows the material.

1. **Option descriptions**: NEVER reveal correctness
   - BAD: `label: "stderr"`, `description: "Error output stream used by Cloud Run for error classification"`
   - GOOD: `label: "stderr"`, `description: "Standard error stream"`

2. **No "(Recommended)" tag** on any option

3. **Randomize** correct answer position — never always first or last

4. **Question phrasing**: Ask about behavior/purpose/output, don't hint at the answer
   - BAD: "Which error stream does error() use?"
   - GOOD: "Where does error() method output go?"

5. **Plausible distractors**: Wrong options must be real concepts from the domain, representing common misconceptions

## Question Types

1. **Factual recall**: "What HTTP status code is returned when...?"
2. **Conceptual understanding**: "Why does the system use X pattern?"
3. **Behavioral prediction**: "What happens when X fails?"
4. **Comparison/distinction**: "What is the difference between X and Y?"
5. **Debugging scenario**: "Given this error, what is the most likely cause?"

## Difficulty Balancing

- Diagnostic: easy 40%, medium 40%, hard 20%
- Weak-area drill: medium 30%, hard 70%
- Review: all levels evenly

## Drilling Unresolved Concepts

When targeting 🔴 concepts from concept files:
- Do NOT repeat the exact same question — rephrase in a new context
- Test the same underlying knowledge from a different angle
- E.g., if user confused "400 vs 422", ask a scenario question where they must choose the correct status code for a new situation

## Question Presentation Format

All questions (both multiple-choice and descriptive) must be bundled and presented together in a single AskUserQuestion (or ask_question) call.

1. **Multiple-Choice (객관식)**:
   - Provide 4 options, single-select.
   - Header: max 12 chars, "Q[N]. Topic".
2. **Descriptive (서술형/주관식)**:
   - Provide predefined options:
     1. `[기타] 입력란에 주관식/서술형 답안을 작성하여 제출하겠습니다.`
     2. `잘 모르겠습니다. (패스)`
   - In the question description, instruct the user to select the first option and write their detailed answer in the popup's write-in (Other/기타) text input field.
   - Header: max 12 chars, "Q[N]. Topic".

## File Update Protocol

After grading:
1. Update `concepts/{area}.md` — add/update concept rows + error notes
2. Update dashboard — recalculate area stats from concept files
3. Badges: 🟥 0-39% · 🟨 40-69% · 🟩 70-89% · 🟦 90-100% · ⬜ no data

## Language Rule

All file content and output in the user's detected language. Badge emojis are universal.
