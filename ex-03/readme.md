# Let's create secrets and explore a few tools

In this exercise we will warm up and start scanning for secrets. For this exercise you must have a termninal window open and the current directory should be `ex-03` (`cd $CODESPACE_VSCODE_FOLDER`) will take you there)

## Prepping our codespace environment

We will add one secret value to our codespace. We will use this secret to access Azure Resources. We will add the secret to our repo config so that it is available to all Codespaces for this repo.

-- Now You --

- Enter the config section of your workshop repo on the Equinor-Playground
- Select "Secrets and Variables"
- Select "Codespaces"
- Add a new "Repository Secret" named `VAULT_ACCESS`
- Add the secret value `provided by the instructor`
- Rebuild the Codespaces container environment (Codespaces menu, bottom left corner)
- Verify that the secret is available (`env | grep VAULT_ACCESS`)

-- Discussion --

- Do a tiny threat model of this pattern - what could go wrong?


## Prepping for SNYK

We will use various tools in this exercise. The tools are pre-installed in the development environment. Some need a bit of config to work. One such tools is SNYK. In order for SNYK to work on a non-public repo we need to get a SNYK token. This token is defined as "Service account" for our Snyk test account.

-- Now you --

- In the terminal do the following (from `./ex-03`):
  - `source ../bin/set-snyk-token.sh `
- Locate the SNYK_TOKEN
- Locate other potential secrets / token in the environment

--- Discussion --

- Do a tiny threat model of this pattern - what could go wrong?

## Adding a few secrets

We will create a few secrets in our excerise and scan for these.

-- Now you ---

- Explore the files in `ex-03/src`
- `secret.txt`
- `app.py`

## Scanning with Snyk

Snyk has a SATS (Static Application Security Testing) module, let's try it.

-- Now you --

- Assuming you are int he folder `ex-03/src` and that the Snyk token has been aquired for the active terminal session.
- Do `snyk code test` and explore results

  ```shell
  snyk code test
  ```

-- Discussion --

- Snyk found some secrets in app.py, but not secrets.txt?

## Scanning with Trufflehog

[Trufflehog](https://github.com/trufflesecurity/trufflehog) is an open source secret scanning tools. It has quite a few options. Let's test it.

-- Now you --

- Assuming you are int he folder `ex-03/src` 
- Do `trufflehog filesystem . --no-update` and explore the results

  ```shell
  trufflehog filesystem . --no-update
  ```

- Do `trufflehog git file://../.. --no-update` and explore the results

  ```shell
  trufflehog git file://../.. --no-update
  ```

-- Discussions --

- The first scan (the filesystem) found the secret in the .txt file, but not in the app.py?
- The second scan (git) scanned the whole git commit history

## Take away

- Secrets are "everywhere" in our dev environment  - it's *easy* for them to slip and be exposed
- Not all tools are equal, they have different purposes and opportunities. The tools are under constant development and improvement
- Use more than one tool in your SDLC
