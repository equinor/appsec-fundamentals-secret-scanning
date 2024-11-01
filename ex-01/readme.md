# What's the problem?

The problem is that secrets like API keys, private keys, client secrets—or any secret that ends up in our code can and will be used by adversaries to do harm.

## Some statistics from 2023

Stats from ([GitGuardian, Report on Secrets Sprawl 2024](https://www.gitguardian.com/state-of-secrets-sprawl-report-2024))

- 12.8 million new secrets detected in public GitHub commits in 2023 (+28%)
- More than 90% of secrets remained valid 5 days after being leaked
- 3 million GitHub repositories leaked a secret
- More than 1 in 10 authors on GitHub exposed a secret in 2023
- Leaking secrets is often done as a mistake or out of convenience, by seniors and juniors! (2022)
- OpenAI keys leakage increased 1212x (46k keys each month)
- The use of stolen or compromised credentials remains the most common cause for data breaches (2022)

## Some recent examples

- Rabbit Inc., 2024, hard-coded secrets allowing unauthorized access to personal data and control over R1 devices ([link](https://www.doppler.com/blog/updated-data-breaches-caused-by-leaks-in-2024))
- Mercedes-Benz, 2024, mistakenly published GitHub token exposed Mercedes-Benz source code ([link](https://techcrunch.com/2024/01/26/mercedez-benz-token-exposed-source-code-github/))
- Meta AI, late 2023, AI models cracked open with exposed API tokens (GitHub, Hugging Face) ([link](https://www.darkreading.com/vulnerabilities-threats/meta-ai-models-cracked-open-exposed-api-tokens))
- Verizon 2023 DBIR (Data Breaches Investigation Report), 16.3k incidents examined, 74% involves human element, 86% of basic web attacks involves stolen credentials ([link](https://www.verizon.com/business/resources/reports/dbir/))
- September 2023, [Microsoft Signing Key](https://msrc.microsoft.com/blog/2023/09/results-of-major-technical-investigations-for-storm-0558-key-acquisition/)
- August 2023, [Grafana Private Signing key](https://grafana.com/blog/2023/08/24/grafana-security-update-gpg-signing-key-rotation/)

And we do security research at Equinor as well:

- Some recent stats will be shared.

## Adversaries are monitoring all public commits

- All public commits on GitHub are constantly monitored by adversaries (and certain commercial companies)
- It takes seconds from the secret being exposed to someone trying to exploit it

(The use of honey tokens gives us some insight (`demo`))

## Key advice - keep secrets out of source code

- Keep all secrets out of source code and containers. This goes for public, internal, and private repos!
- Deploy secret/credential scanning into your SDLC
