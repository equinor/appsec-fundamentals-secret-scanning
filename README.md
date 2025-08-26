# Appsec Fundamentals Secret Scanning

## The workshop will not be continued in it's current form. We introduce GHAS and secret scanning. We may consider an new agumented workshop later, focusing on general usage and perhaps container scanning etc.

[![License](https://shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT) 
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](/CONTRIBUTING.md)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md) 

A 3-hour workshop exploring scanning for secrets in code and containers.

As developers, we know that secrets like passwords, API keys, and access tokens are critical to our work. But what happens when these secrets accidentally end up in our code, logs or error messages? In this AppSec Fundamentals workshop we aim to explore this challenge, how to mitigate the risks and what to do when we have messed up. We will also explore some good practices for managing secrets in our development environments.

This will be a hands-on workshop where you'll walk away with practical solution you can start using right away. Context matters - so fire up your curiosity, be prepared to explore and ask question - and join us.

## Agenda

- [What's the problem?](ex-01/readme.md)
- [Preparing your workshop environment](ex-02/readme.md)
- [Let's create secrets and explore a few tools](ex-03/readme.md) 
- [The SDLC, where and when to scan for secrets](ex-04/readme.md)
- [Pre-commit, preventing secrets from entering the git history](ex-05/readme.md)
- [Scanning for secrets in container images](ex-06/readme.md)
- [Scanning in the CI](ex-07/readme.md)
- [How do we manage secrets in our dev environments?](ex-08/readme.md)
- [What to do when we have messed up?](ex-09/readme.md)
- [Wrapping up](ex-10/readme.md)

## Workshop preparations

- You need a laptop with access to the internet
- You need an updated and modern browser (like Firefox)
- You need access to the [Equinor](https://github.com/equinor) and the [Equinor Playground](https://github.com/equinor-playground) organizations on [github.com](https://github.com). Test this by using the SSO end-points, [https://github.com/orgs/equinor/sso](https://github.com/orgs/equinor/sso) and [https://github.com/orgs/equinor-playground/sso](https://github.com/orgs/equinor-playground/sso)
- *Some basic knowledge of the Linux command line are always useful*

## Non Equinor adaptions

The workshop makes a few assumptions about the availability of various infrastructure components we use in Equinor.

### Snyk

We use Snyk for some part of our secret scanning (the Snyk code module). In order to be able to scan internal/private repos we need a Snyk service account. It's free for scanning public repos.

- You can skip the Snyk part if that's not used in your organisation
- Azure Key vault
  - Used to store the Snyk Service Service Account token required for accessing Snyk
- Azure AD Service Principal, Client-Secret
  - We use these to access the Azure Key vault. The client secret is stored as a repo secret
- Some scripts to get the Snyk token and make it available to the scanning environment. You will have to inspect the content in the `/bin` folder and at least adapt the config in `/src/development.cfg`

It may seem like a lot of mechanics just for using Snyk, and you are correct. There is a second purpose; we try to show/teach generic patterns that we recommend for secret management. This is one of those (even though we more often than not recommend the Github Actions OICD connector)

### Github Codespaces

We use Github Codespaces to develop and run the workshop. For this we have one Github organization where we store the main repo (this). This is a template repo. Participants create a new repo in another Github organisation where we have enabled Codespaces. You'll need to adapt (at least) the *Equinor-Playground* references to your set-up.

### Admin work

We also have a section for admin work, this is where we remind ourselves of stuff that needs to be done before and after the workshops. You'll need to adapt this to your context

### Good adaptations patterns?

Good question. The whole idea of this workshop is to raise awareness on the topic of secret scanning and then teach some ok patterns. This workshop will not be exhausting all permutations of patterns and tools. From such perspective this repo may be quite static.

One option for your company could be to create a copy of the repo, adapt it to your context and use the content as long as it makes sense.

### Github Actions

We use Github Actions to give people an example and ideas on how to include secret scanning in CI

### Sharing security research

In the first exercise we share experiences from our internal security research. Compared with talking about the big incidents that *never will happen to us anyway*, we have seen that this leaves a much bigger impression, and urge people to explore.

### Are we locked on the tools?

Nope. We expect this part to change over time. The good patterns, practices and habits usually stick.

### Slack

The Slack spaces we refer to are internal - and will continue to be so :)
