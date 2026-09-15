---
applyTo: "**/*.tf,**/*.tfvars,**/*.tfvars.json"
---

# Terraform instructions

- Inspect the existing module structure, provider versions, state-backend configuration, and naming/tagging conventions before editing.
- Keep changes focused and preserve existing module interfaces, variable conventions, and resource organization.
- Do not change providers, state backends, regions, accounts, resource replacement behavior, or IAM permissions without explaining the impact.
- Prefer least-privilege IAM policies and follow existing conventions for encryption, logging, network exposure, and tags.
- Use variables and secret-management mechanisms already established by the repository; never place credentials or sensitive values in .tf or .tfvars files.
- Identify resources that may be destroyed, replaced, or recreated, and explain the blast radius and rollback path.
- Prefer stable for_each keys over count when resource identity must remain stable as a collection changes.
- Consider operational scalability and cost for changes that add resources, polling, high-cardinality metrics, or broad network access.
- Run terraform fmt and terraform validate when available.
- Recommend reviewing terraform plan before applying any infrastructure change.
- Do not run terraform apply, destroy, state operations, imports, or moves without explicit user approval.
