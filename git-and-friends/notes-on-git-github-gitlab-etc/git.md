---
description: >-
  Git is nearly ubiquitous these days; you really can't get along without it in
  most development jobs.
---

# Git

{% hint style="info" %}
NOTE: `git` is not GitHub!

`git` is a tool, mainly used on the command line, to manage your repository.

GitHub is the name of a SaaS \(Software as a Service\) website that is used to house remote git repositories. It is not a part of `git`, it _uses_ `git` in the background.
{% endhint %}

## Links

* [The main git website](https://git-scm.com) - documentation, downloads, community

## Quickies

### Delete a remote git branch

Perform a push to your remote using : before the name of the branch

```text
$ git push origin :mybranchname
```

where `origin` is the name of your remote and `mybranchname` is the name of the branch about to be deleted.

