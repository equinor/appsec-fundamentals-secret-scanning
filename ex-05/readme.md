# Pre-commit, preventing secrets from entering the git history

We have already identify that tools have different purposes and behaviours

- We should spend sufficient time to get to know the tools we use and their purpose
- Speed and friction is also important in a development flow, we could limit scanning scope based on where we are
    - Scan HEAD before we do any commits (pre-commit) (staging area)
    - Scan commits since last push before we push to origin
    - Scan filesystem directories when we have longer build?
  
In this part of the workshop will will explore the git scanning a bit deeper.

## Exploring Trufflehog options

- Create a `src` folder in `ex-05` and navigate to this folder in the terminal
- Copy the secret.txt file from ex-03
    ```shell
    cp ../../ex-03/src/secret.txt .
    ```
- Scan the file system, secret found?
    ```shell
   trufflehog filesystem . --no-update --no-verification
    ```
- Scan git from HEAD, secret found?
    ```shell
    trufflehog git file://../../ --no-update --no-verification --since-commit HEAD
    ```
- Start tracking the secret.txt file in git
    ```shell
    git add secret.txt
    git status
    ```
- Scan git from HEAD, secret found?
    ```shell
    trufflehog git file://../../ --no-update --no-verification --since-commit HEAD
    ```
- Explore Trufflehog git options
    ```shell
    trufflehog git --help
    ```

## Exploring Git pre-commit

We are using the [Pre-Commit](https://pre-commit.com/) framework. This framework provide quite a few options for plugging in various routines that would run before git events such as commit and push. A few notes:

- Our usage in this workshop is perhaps a bit *unusual*. You would typically use routines from a common or corporate library. We create our own local for our workshop.
- The pre-commit routines are installed per repo. This mean that the initialization will have to be repeated when things are initialized (as with rebuild in our workshop) or installed as part of the initialisation of the environment (we don't implement this in our workshop - it would mess up the flow)
- The pre-commit framework is pre-installed into your Codespace (part of the [devcontainer.json](../.devcontainer/devcontainer.json))
- Should you need to install pre-commit _locally_, [follow the official installation guides](https://pre-commit.com/#install)

### -- Now you --

- Explore the `./.pre-commit-config.yaml` file
- Open a new fresh terminal and keep the one running in `ex-05/src` open.
- Install the pre-commit rules we have created
    ```shell
    pre-commit install
    ```
- Go back to the terminal session that is running `ex-05/src` 
- Add the `secret.txt` file to git, and commit to git history
    ```shell
    git add secret.txt
    git commit -m "Adding a secret"
    ```
- Explore the output
- Remove the secret from the secret.txt file and commit to git
    ```shell
    git add secret.txt
    git commit -m "removing secret"
    git log
    ```
- Explore the output

### -- Discussion --

- We now have a way to potentially stop secrets being entered into the git history
    - Pros?
    - Cons?

