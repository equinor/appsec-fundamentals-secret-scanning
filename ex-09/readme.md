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

- You can find more info in the [Secret Scanning Guidelines](https://appsec.equinor.com/guidelines/secret-scanning/#what-to-do-when-we-have-messed-up)
