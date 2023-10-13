### `git spoof-dates [author-date] [committer-date]`

Changes the author/commiter dates of the previous commit.

```bash
# Alias for:
GIT_COMMITTER_DATE="[committer-date]" git commit --date="[author-date]" --amend --no-edit

# Usage:
git spoof-dates "Fri Dec 2 18:53:50 2022 +0800" "Fri Dec 2 18:54:09 2022 +0800"
```
