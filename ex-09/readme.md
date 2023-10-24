# What to do when we have messed up

We will, or someone - not we, will always mess up. So be prepared, both as a individual developers and as teams!

## Steps to mitigate a leak

- Revoke the exposed secret - `THIS IS PRIORITY #1`
- Depending on risk consequence - considering contacting IT-Security for assistance
  - Contact Help Desk at (+47) 51 999 222
- Clean the git history
  - If the repo is public/internal, consider making it `private` until the secrets are removed
- Potentially inspect logs
- Do a retrospective with your team

## Cleaning the git history

This part can be very easy to super hard, it all depends on what and where. (You will find a lot of hard learnt lessons at [https://dangitgit.com](https://dangitgit.com))

### You are working locally, the secret is in the last commit, not pushed

- The secret is the only file in the last commit
  - Consider dropping the last commit, doing a `git reset --hard HEAD~1`
- The secret is not the only file in the last commit
  - Consider altering files and then amend the last commit
    - `git add [files]; git commit --amend`

### You are working locally, the secret is beyond the last commit

Then things could get complicated. Git is distributed, you are not on your own. Rewriting the history could lead to all sorts of issues

Explore:

- git filter-repo

Be aware of:

- You may need to coordinate with your team
- Force push is powerful, use carefully
