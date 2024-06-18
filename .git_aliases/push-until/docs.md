### `git push-until [commit]`

Push all commits until (and including) `[commit]` to the `origin` branch of
the same name.

```bash
# Alias for:
current_branch="$(git get-current-branch)"
git push origin "[commit]:$current_branch"
```
