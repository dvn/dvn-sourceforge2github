---
layout: default
title: DVN on GitHub
---
## Comparison of two import tests (test2 vs. test5)

### Version with `--trunk dvn-app/trunk --branches dvn-app/branches`

https://github.com/dvn/dvn-svn-import-test2

- Cons
    - does not contain complete history:
        - oldest commit is from July 2010: https://github.com/dvn/dvn-svn-import-test2/commit/d3e1cac

### Latest `--rootistrunk` test import

https://github.com/dvn/dvn-svn-import-test5

- Pros
    - complete history
        - oldest commit is from June 2007: https://github.com/dvn/dvn-svn-import-test5/commit/e4cddf3
- Cons
    - 16 projects (from various revisions)
    - trunk is is a holdover term from svn

## Cleanup

We decided to start with https://github.com/dvn/dvn-svn-import-test5 and move `dvn-app/trunk/*` to the root of repo in this commit: https://github.com/IQSS/dvn/commit/cb12acc
