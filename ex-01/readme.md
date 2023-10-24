# What's the problem?

The problem is that secrets like api keys, private keys, client secrets - or any secret that end up in our code can/will be used by adversaries to do harm.

## Some statistics from 2022

Stats from ([Gitguardian, Report on Secrets Sprawl 2023](https://www.gitguardian.com/state-of-secrets-sprawl-report-2023))

- 10 million new secrets detected in public Github commits in 2022
- The volume of hardcoded secrets increased by 67% from 2021 to 2022
- 1 in 10 authors on Github exposed a secret in 2022
  - It's often done as a mistake or out of convenience, by seniors and juniors!
- The use of stolen of compromised credentials remain the most common cause for data breaches in 2022

## Some recent examples

- Uber, September 2022, Hardcoded admin credentials used to take over Privileged Access Platform ([link](https://www.upguard.com/blog/what-caused-the-uber-data-breach))
- Circle CI, December 2022, Malware on developer laptop used to lift SSO creds ([link](https://circleci.com/blog/jan-4-2023-incident-report/))
- Toyota, October 2022, Secret key exposed on Github.com, customer data exposed ([link](https://blog.gitguardian.com/toyota-accidently-exposed-a-secret-key-publicly-on-github-for-five-years/))
- Private source code was stolen/leaked from NVidia, Samsung, Microsoft, DropBox and Slack in 2022
  
And a few weeks ago:

- August 2023, [Graphana Private Signing key](https://grafana.com/blog/2023/08/24/grafana-security-update-gpg-signing-key-rotation/)
- September 2023, [Microsoft Signing Key](https://msrc.microsoft.com/blog/2023/09/results-of-major-technical-investigations-for-storm-0558-key-acquisition/)

And we do security research in Equinor as well:

- Some recent stats will be shared.

## Adversaries are monitoring all public commits

- All public commits on Github are constantly monitored by adversaries (and certain commercial companies)
- It takes seconds from the secret being exposed to someone trying to exploit it

The use of honey tokens give us some insight (`demo`)

## Key advice - keep secrets out of source code

- Keep all secrets out of source code, and containers. This goes for public, internal and private repos!
- Deploy secret/credential scanning into your SDLC
