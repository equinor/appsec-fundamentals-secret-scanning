# Scanning for secrets in container images

Container images are also a **well-known** source for secrets in the wild. There should not be any secrets baked into container images. Secrets should be mounted on runtime (or by other mechanisms). A few notes:

- Container images are layers, which if not understood properly will give you challenges (similar to the git history)
- Adding a secret at build time, using it and then deleting it may give you problems if not handled properly!

Let's explore a typical example.

-- Now You --

- Assuming you have a terminal open in the folder `ex-06`
- Explore the `Dockerfile`
- Build the Docker image for your app. Run it afterwards
  
    ```shell
    docker build -t myapp . --progress=plain --no-cache
    
    docker run myapp
    ```

- The image is build, no secrets are exposed in build output
- Let's build again and now pass a secret
- (A fee hint; if you start commands in bash with a space the command will not be saved in the history)

    ```shell
    export MY_SECRET="ghp_6GdlOSDwyZKlhSyuuuEEEJJ8yLxRNQ3UnVAj"
    
    docker build -t myapp . --progress=plain --no-cache --build-arg MY_SECRET=$MY_SECRET
    ```

- The image is build, the secret is emitted to the console and then deleted.
- We will explore a bit further using our local file system (as opposed to a container registry)
- First we do the build but store the result, that would end up in an container image, into the file system

    ```shell
    mkdir myapp

    docker build --build-arg MY_SECRET=${MY_SECRET} -t myapp --progress=plain --no-cache -o type=local,dest=./myapp .
    ```

- The **image** is build, but the results are stored in the `my-app` folder. Explore
- Let's scan the `my-app` for any secrets

    ```shell
    trufflehog filesystem ./myapp --no-update
    
    echo $?

    ls myapp/tmp 
    ```

- The scan gives some error we can ignore, but finds no secrets (exit code 0). There is no /tmp/secret.txt, it's deleted ...
- The previous build was not a real container image. Let's build a real image, save it to a tar file and investigate

    ```shell
    mkdir myapp-tar

    docker build --build-arg MY_SECRET=${MY_SECRET} -t myapp --progress=plain --no-cache .
    
    docker save -o myapp.tar myapp
    
    tar -xvf myapp.tar -C myapp-tar
    
    ls -la ./myapp-tar
    ```

- The content of `myapp-tar` looks different than what's in `myapp`. It's represents whats end up in the container image, all layers.
- Let us scan the result with Trufflehog

    ```shell
    trufflehog filesystem ./myapp-tar --no-update
    ```

- We found a secret, the same one 2 places?
- Explore the files reported (layers) and identify the secret.
  - Hint: `cat (json file) | jq .`
  - Hint: `tar -tvf (tar file)`

- Looking at the layers with [docker history](https://docs.docker.com/engine/reference/commandline/history/)

    ```shell

    docker history myapp
    
    ```

- This command will show the all the layers that make up an image - and the commands that were used to create each layer.

-- Discussions --

- In many cases, using the tool to scan images directly (local or registry, but as early as possible), is the better approach, we took a longer route to explain
- Be aware of layers and use them "properly" with multi-stage builds
- The better pattern for using secrets in Docker build may be to use the "--secret" option or mount a secret file using the "--mount=type=secret,id=MY_SECRET" option
- The [Docker Security Best Practices](https://docs.docker.com/develop/security-best-practices/) provide some guidance. Always search product documentation for security best practices.
