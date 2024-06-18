### `git graph`

Displays Git commit graph.

```bash
# Alias for:
git log \
  --graph \
  --abbrev-commit \
  --decorate \
  --all \
  --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'
```
