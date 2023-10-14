### `git pull-pr [username]:[branch] [optional_remote_name]`

Pulls (and checkout to) a PR's branch. The `[username]:[branch]` is given in
the GitHub's PR description.

If no remote with a URL containing `[username]` exists, create a new remote
named `[username]` (or `[optional_remote_name]` if given) with a URL based on
`origin` remote. \
_(eg. If `origin  https://github.com/EvitanRelta/repo` then the URL will be `https://github.com/[username]/repo`)_

If a remote exists, but it's name isn't equal to `[optional_remote_name]`, then
that remote is renamed to `[optional_remote_name]`.

For example, for the PR description: \
"afiqzu wants to merge 1 commit into `CS3219-AY2324S1:assignment-5` from `afiqzu:assignment-5`" \
`[username]:[branch]` = `afiqzu:assignment-5`

```bash
# Given this scenario:
$ git remote -v
oldremote  https://github.com/EvitanRelta/repo
origin     https://github.com/myorigin/repo
```

#### Example usage 1:
```bash
git pull-pr EvitanRelta:pr-branch
# is alias for:
git fetch oldremote
git checkout -b oldremote-pr-branch oldremote/pr-branch
```

#### Example usage 2:
```bash
git pull-pr EvitanRelta:pr-branch newremote
# is alias for:
git remote rename oldremote newremote
git fetch newremote
git checkout -b newremote-pr-branch newremote/pr-branch
```

#### Example usage 3:
```bash
git pull-pr NewUser:pr-branch newremote
# is alias for:
git remote add newremote https://github.com/NewUser/repo
git fetch newremote
git checkout -b newremote-pr-branch newremote/pr-branch
```
