# StringChecker
Takes in a null-terminated string, and removes the characters "the".

What is removed:
* ✅ the | removed
* ❌ teh | rearranged "the"
* ❌ The | capital
* ❌ THE | all caps "the"
* ❌ them | non-space character following "the"
* ❌ other | non-space character before/after "the"
* ❌ 1the | non-space character before "the"
