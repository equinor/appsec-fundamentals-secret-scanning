# How do we manage secrets in our dev environments?

Context matters, a lot. There are many different ways of handling secrets in development environments. The opportunities will depend on the context. We will always have to find a good balance between security and convenience. 

Now that we have a better idea on risks we hopefully can make better and more informed decisions.

## A few *known* ways of managing secrets is

- Using password/credential managers
- Using keychain services
- Storing secrets in encrypted files
- Storing secrets in `.env` files
- Storing secrets in secret management tools (like Azure Key Vault)
- Injecting secrets into environment variables

## A few *known* controls could be

- Using `.gitignore`
- Using `.dockerignore`
- Using secret scanners
  - Not all tools are equal
- Limit access to secrets
- Use different secrets for different environments (dev, test, prod)
- Rotate secrets often, automate!
- Auditing and logging
- Educating and training are smart
- **Threat modelling your SDLC with your team is even smarter!**

## What we should NOT do

- Don't hardcode secrets into code
- Don't store secrets as part of the code, not even encrypted
- Don't emit secrets into logs

## Exploring one option (Key vault)

In `ex-03` we utilize an pattern that:

- Injects a secret into the development environment (The Service Principal)
  - We use the `Azure CLI`
  - We use this to access a service principal that have permissions to read secrets in our key vault
  - Alternatives would be to either authenticate as `your self` or as a `managed identity` if available
- Reads a secret from a Azure Key Vault (The Snyk Token)
  - The Secret "SNYK" is read from the Key vault and injected into an environment variable `SNYK_TOKEN`
- Use a .gitignore file to stop *obvious* from being adding to the git history
  - This should not be abused (like adding a `.env` file to the code folder - assuming it will never be added to git)
  
Enhancements we have explored:

- Adding Snyk Code into our IDE (it could pick up some secret issues early)
- Adding pre-commit with Trufflehog locally
- Adding branch protection requiring PR's, reviews, signed commits and passing checks. Disallow force pushes.
- Adding a GitHub Action scanning PR's for secrets
  
-- Now you --

- Explore `./bin/set-snyk-token.sh`

-- Discussions --

- How are you managing secrets today? Pros/Cons of current methods.