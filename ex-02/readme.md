# Preparing your workshop environment

It's time to do some hands-on work. In this part you will create your own version of the course repository on the Equinor-Playground organization and then start the Github Codespace where you will spend most of your time in this workshop.

## Now-You

- Verify access to the github orgs
  - [https://github.com/orgs/equinor/sso](https://github.com/orgs/equinor/sso)
  - [https://github.com/orgs/equinor-playground/sso](https://github.com/orgs/equinor-playground/sso)
- Navigate to the template repo [https://github.com/equinor/appsec-fundamentals-secret-scanning](https://github.com/equinor/appsec-fundamentals-secret-scanning)
- Select "`Use this template`" and then add relevant information
  - "Create a new repository"
  - "Owner" should be "Equinor-Playground"
  - "Repository-Name" should be "(your-initials)-appsec-secret-scanning-workshop" </br> (example: "lksk-appsec-secret-scanning-workshop")
  - "Description" should be "Appsec Workshop Repo, will be deleted 3 weeks after creation"
  - Repository "visibility" should be "Internal"
- Select "`Create repository`"

You should now have your own copy of the course repository hosted on the Equinor-Playground.

Next up will be to start the virtual development environment, Github CodeSpaces.

- From your copy of the repository select "`Code`"
- Select the Tab "Codespaces"
- Select "`Create Codespace on main`"

It typically will take a few minutes to build your codespace. In a *normal* working scenario you should investigate the "prebuilt container" feature. While it build we can

- have a look at the honey token demo
- explore the workshop repo
- discuss pros/cons of this way of working (Codespaces)