# Course/Workshop Administration Tasks

## Configuring Infrastructure

- Create Service Principal (SP)
  - Remember the official guidelines in [Omnia Docs](https://docs.omnia.equinor.com/governance/iam/App-General-Info/)
  - Record the name (for scripts) (`appsec-fundamentals-secret-scanning`)
  - Create a client secret; it should be short-lived.
  - Store the Client Secret for sharing with participants.
  - Update the CodeSpace Repository Secret `VAULT_ACCESS`.
- Create a Key Vault
  - Course instructors should have the role "Key Vault Secret Officer" on the key vault.
  - The SP created in the previous step should have the role "Key Vault Secret User" on the secret.
- Create/use a Snyk Organization in the "Test" group.
  - Create a Service Account in this group.
  - Inject the service account "value" into the Key Vault as a Secret named `SNYK`.
- Update the `bin/config/development.cfg` file.

For this workshop, we:

1. Use an SP that all participants share. This is to reduce the configuration we would have to do upfront, providing specific access for each participant to the various infrastructure components.
2. Use a common Service Account for SNYK for all participants. Same reasoning as for #1.

## Pre-Workshop

- Establish infrastructure; update config files if necessary (`/bin/config`).
- 2-3 weeks ahead:
  - Schedule time in the calendar, add a virtual meeting if needed.
  - Announce the workshop. Include:
    - Introduction
    - Date, time
    - Type (virtual, physical)
    - Skill level (beginner, intermediate, advanced)
    - Audience (developers, coders, data scientists, etc.)
    - Preparation (link to repo preps)
    - Potential sign-up link (if needed)
    - Deadline for sign-up (if needed)
    - Max number of participants (30-40 persons seems to work fine).
- 1 week ahead:
  - Close sign-up (if needed).
  - Add participants to the calendar invite.
- 1 week after:
  - Issue an email to participants, reminding them to clean up, sharing links to guidelines.

## During Workshop

- Introduce yourself!
- Using "raising hands" works well as a tool for progress management.
- For the 3-hour version, we take breaks on the hour (10 and 5 minutes).
- Collecting feedback using polls or similar can be a good idea.

## Post-Workshop

- Rotate/delete secrets/service accounts.
- Consider deleting infrastructure:
  - Service Principal
  - Azure Key Vault
  - Azure Resource Group
  - Snyk Organization
- Aggregate information on participation for potential reporting (number of participants, ...)