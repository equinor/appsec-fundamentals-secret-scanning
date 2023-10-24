# Course admin preparations

## Configuring infrastructure

- Create Service Principal (SP)
  - Remember the official guidelines in [Omnia Docs](https://docs.omnia.equinor.com/governance/iam/App-General-Info/)
  - Record name (for scripts) (appsec-fundamentals-secret-scanning)
  - Create client secret, it should be short lived.
  - Store the Client-Secret - for sharing with participant
  - Update the CodeSpace Repository Secret "VAULT_ACCESS"
- Create Key vault
  - Course instructor's should have role "Key vault Secret Officer"
  - The SP create in previous step should have role "Key vault Secret User"
- Create/use a Snyk Organization in the "Equinor Test" group
  - Create a Service Account in this group
  - Inject the service account "value" into the Key vault as a Secret named "SNYK"
- Update the bin/config/development.cfg file

For this workshop we:

1. Use a SP, that all participants share. This is to reduce the config we would have to do up front providing specific access for each participant to the various infrastructure components.
2. Use a common Service Account for SNYK for all participants. Same reasoning as for #1.

## Post-Workshop

- Delete client-secret for SP
- Consider deleting infrastructure
  - Service Pincipal
  - Azure Key Vault
  - Azure Resource Group
  - Snyk Organization

