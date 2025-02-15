### `git copy-commit-metadata [--all|--committer|--author|--committer-date|--author-date|--message] [COMMIT_HASH]`

Amends the last commit to copy the committer/author names and dates and commit
message of `[COMMIT_HASH]`.

Takes the flags which selects which metadata to copy:

-   `--all`: All metadata
-   `--committer`: Committer name/email
-   `--author`: Author name/email
-   `--committer-date`: Committer date
-   `--author-date`: Author date
-   `--message`: Commit message

```bash
# Alias for:
committer_name=$(git show -s --format='%cn' [COMMIT_HASH])
committer_email=$(git show -s --format='%ce' [COMMIT_HASH])
committer_date=$(git show -s --format='%cd' [COMMIT_HASH])
author=$(git show -s --format='%an <%ae>' [COMMIT_HASH])
author_date=$(git show -s --format='%ad' [COMMIT_HASH])
commit_message=$(git show -s --format='%B' [COMMIT_HASH])

GIT_COMMITTER_NAME="$committer_name" \
GIT_COMMITTER_EMAIL="$committer_email" \
GIT_COMMITTER_DATE="$committer_date" \
git commit --amend --no-edit \
    --author="$author" \
    --date="$author_date" \
    -m "$commit_message"
```
