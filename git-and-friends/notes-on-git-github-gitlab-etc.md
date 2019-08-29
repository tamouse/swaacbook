# Notes on Git, GitHub, GitLab, etc

## Links

* [git-scm.org](https://git-scm.org) - the home of git

## Quickies

### Delete a remote git branch

Perform a push to your remote using : before the name of the branch

```text
$ git push origin :mybranchname
```

where `origin` is the name of your remote and `mybranchname` is the name of the branch about to be deleted.

