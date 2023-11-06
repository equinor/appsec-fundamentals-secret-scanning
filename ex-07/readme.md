# Scanning in the CI

There are many opportunities to scan for secrets in our continuous integration (CI). In general, do the scanning as early as possible. We will look at one implementation using github actions.

For this exercise we have defined a github action that will scan for secrets when we do pull requests. Let's dive into the details and get a better idea for the mechanics.

## Review the Github actions config

We need to take a few minutes to verify the Github Actions config.

### -- Now you --

- Explore the workflow at `.github/workflows/secret-scanning.yml`
  - The workflow triggers on "pull_requests"
  - The workflow will checkout code and scan the commits being part of the pull_request
- Explore the `Actions` section of your repo
- Explore the Actions `permissions` for your repo (Settings - Actions - General )
  - "Allow enterprise, and select non-enterprise, actions and reusable workflows" should be `selected`
  - "Allow actions created by Github" should be `selected`
  - Add "`trufflesecurity/trufflehog@*,`" to "Allow specified actions .."
  - `Save`

### -- Discussions --

- Remember; Github actions are code that you "allow" to work with your source code and CI process. It's important to understand what you allow and why. Trust but verify?
- What would be a good default config for the Github Action in a repo?


## Branching out

In this part we will create a new branch, accidentally add a file with a secret and then create a PR (pull request).

### -- Now you --

- Open a terminal and navigate to the `ex-07` folder, create a `src` directory and head into it.
- Create a new branch named `ex-07`

    ```shell
    git checkout -b ex-07
    ```

- Create a `security.py` file and add a *invalid* github token to it

    ```shell
    echo "github_token = 'ghp_6GdlOSDwyZKlhSyuuuEEEJJ8yLxRNQ3UnVAj'" > secret.py
    ```

- Add the file to git, commit and push to origin (Github)

    ```shell
    git add secret.py
    git status
    git commit -m "Adding a file"
     ```

- The pre-commit scanning should catch this 👮‍♂️ - you will be stopped before the commit is done. We must disable the pre-commit.
  Temporary solution, circumventing the pre-commit hook:
  ```shell
  git commit -m "Adding file" --no-verify
  ```
  Permanently, removing pre-commit:
  ```shell
  pre-commit uninstall
  ```

- Continue the commit and then push to origin

    ```shell
    git status
    git commit -m "Adding a file"
    git push --set-upstream origin ex-07
    ```

- Head over to Github.com, find your repo and select (`Compare & pull request`)
- The PR is from ex-07 to main, `Create` the pull request.
- Observe that the `Scanning for Secrets / TruffleHog (pull_request)` is triggered
- The check should `fail`, explore the `details`
  - Secret values should not be in the logs


- Explore the `Actions` section of your repo on github.com
- Explore [Events that triggers workflows](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows) on github.com
- Explore [About branch protection rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches) on github.com

### -- Discussions --

- What are the benefit of "branch protection"?
- What would a *good* branch protection rule be?
