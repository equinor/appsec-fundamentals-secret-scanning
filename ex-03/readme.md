# Let's create secrets and explore a few tools

In this exercise we will warm up and start scanning for secrets. For this exercise you must have a terminal window open and the current directory should be `ex-03` (`cd $CODESPACE_VSCODE_FOLDER`) will take you there)

## Prepping our Codespace environment

We will add one secret value to our Codespace. We will use this secret to access Azure Resources. We will add the secret to our repo config so that it is available to all Codespaces for this repo.
Note you can view your running Codespaces here: [https://github.com/codespaces](https://github.com/codespaces)

### -- Now You --

- Make sure you have the codespace available and a terminal window open at `ex-03`
- Enter the config section of your workshop repo on the Equinor-Playground
- Select "Secrets and Variables"
- Select "Codespaces"
- Add a new "Repository Secret" named `VAULT_ACCESS`
- Add the secret value `provided by the instructor`
- Switch back to the codespace
  - A message should show that the environment has changed and offer to reload
- Verify that the secret is available in the terminal (`env | grep VAULT_ACCESS`)
  - If not, try to manually re-load the browser window
  - If not, rebuilding the  the codespace container environment should fix it but will take time (Codespaces menu, bottom left corner)
  - If not, adding the VAULT_ACCESS environment variable manually will work for this exercise
    - (` export VAULT_ACCESS=<paste value>`) (The leading white space is intentional, the command will not enter the command history)

### -- Discussion --

- Do a tiny threat model of this pattern - what could go wrong?

## Prepping for Snyk

We will utilize a range of tools in this exercise, all of which are pre-installed in the development environment. However, some require additional configuration to function properly. A prime example is Snyk and the Snyk Command Line Interface (CLI). To enable Snyk to operate on a non-public repository, such as the one we will create on the Equinor Playground, we need to acquire a Snyk token. This token will authenticate the CLI with the Snyk platform. Specifically, the token is designated as a "Service Account" for the Snyk Organization that we have established for this workshop.

### -- Now you --

- In the terminal do the following (from `./ex-03`):
  - `source ../bin/set-snyk-token.sh `
- Locate the `SNYK_TOKEN` environment variable
  - e.g. `env | grep -i SNYK_TOKEN` 
- Locate other potential secrets / token in the environment

### -- Discussion --

- Do a tiny threat model of this pattern - what could go wrong?

## Adding a few secrets

We will create a few secrets in our exercise and scan for these.

### -- Now you ---

- Explore the files in `ex-03/src`
- `secret.txt`
- `app.py`

## Scanning with Snyk

Snyk has a SAST (Static Application Security Testing) module, let's try it.

### -- Now you --

- Assuming you are int he folder `ex-03/src` and that the Snyk token has been acquired for the active terminal session.
- Do `snyk code test` and explore results

  ```shell
  snyk code test
  ```

### -- Discussion --

- Snyk found some secrets in app.py, but not secrets.txt?

## Scanning with Trufflehog

[Trufflehog](https://github.com/trufflesecurity/trufflehog) is an open source secret scanning tools. It has quite a few options. Let's test it.

### -- Now you --

- Assuming you are int he folder `ex-03/src` 
- Do `trufflehog filesystem . --no-update` and explore the results

  ```shell
  trufflehog filesystem . --no-update
  ```

- Do `trufflehog git file://../.. --no-update` and explore the results

  ```shell
  trufflehog git file://../.. --no-update
  ```

- Explore Trufflehog options

  ```shell
  trufflehog --help
  ```

### -- Discussions --

- The first scan (the filesystem) found the secret in the .txt file, but not in the app.py?
- The second scan (git) scanned the whole git commit history

## Secret verification

Many tools have will try to *verify* if a secret is valid. The verification part involves using the secret against the service which the scanner believes it is for. In Trufflehog this is default if the detectors that supports it. For the example of the GitHub token, Trufflehog's [detector](https://github.com/trufflesecurity/trufflehog/blob/0d8c3335ed9321c2e198206f9279a31c8f2e3b67/pkg/detectors/github/v1/github_old.go#L109) will hit the github api using the secret. If the api call is successfull Trufflehog will report "Verified" - else "Found unverified result 🐷🔑❓"

(In the current version, `snyk code test` will send your data away for analysis. There is a ["local engine"](https://docs.snyk.io:8443/scan-using-snyk/snyk-code/snyk-code-local-engine) version in early access which will not send data away)

### -- Now You --

- Assuming you are int he folder `ex-03/src` 
- Do `trufflehog filesystem . --no-update` and explore the results

  ```shell
  trufflehog filesystem . --no-update
  ```
- Do `trufflehog filesystem . --no-update --no-verification` and explore the results

  ```shell
  trufflehog filesystem . --no-update --no-verification
  ```
- Do `trufflehog filesystem . --no-update --only-verified` and explore the results

  ```shell
  trufflehog filesystem . --no-update --only-verified
  ```

### -- Discussions --

- Take a deliberate decision on "verification" and what data that is sendt out of your system
- What could go wrong? (Expose data in http headers, test secret with wrong vendor, should we treat all secrets that has undergone a verification as exposed?)

## Fine-tuning

Most secret scanning tools will report quite a few false positives, and Trufflehog is no exception. It supports over 810+ detectors, where most of them are defined by [regular expressions](https://en.wikipedia.org/wiki/Regular_expression), so false positives are to be expected. Tuning the scanners to meet your specific needs is often necessary.

### -- Now You ---

- Assuming you are int he folder `ex-03/src` 
- We will install the dependencies for a tiny NodeJS project. Run the install command.

  ```shell
  npm install
  ```
- Use Trufflehog to scan for secrets

  ```shell
  trufflehog filesystem . --no-update --no-verification
  ```
- Examine the resuls and the detectors that are triggered.
- Our first strategy will be to exclude detectors that we do not think is relevant for our project, start with "URI"

  ```shell
  trufflehog filesystem . --no-update --no-verification --exclude-detectors=URI
  ```
- For our example this worked, we are left with the known Github token. Detectors can either be included or excluded.
- For our example, it does "not make sense" to scan the "node_modules" directory. We will focus on our code and tell Trufflehog to ignore the NodeJS dependencies
- Examine the "trufflehog-exclude-dirs.txt" file and the use it with Trufflehog

  ```shell
  trufflehog filesystem . --no-update --no-verification --exclude-paths=./trufflehog-exclude-dirs.txt
  ```
- For our example this worked out fine. We are back to the Github token that we know.

### -- Discussions ---

- Secret scanners usually need to be fine-tuned.
- The more "detectors" a tool has, the larger the number of false positives.
- Take deliberate and conscious action on what to include or exclude.

## Takeaways

- Secrets are "everywhere" in our development environment — it's *easy* for them to slip and be exposed.
- Not all tools are equal; they serve different purposes and offer various opportunities. These tools are under constant development and improvement.
- Use more than one tool in your SDLC.
- Fine-tune scanners to reduce number of false positives
- Be aware of the data that leaves your control for scanning, verification, and similar processes.
