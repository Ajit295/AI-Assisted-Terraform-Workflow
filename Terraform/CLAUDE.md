# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository manages Azure cloud infrastructure as code using Terraform. 
It provisions and manages Azure resources across Dev and Prod environments 
using a modular architecture. Deployments are handled via Azure Pipelines 
with automated validation, planning, and approval workflows.

- **Azure DevOps Organisation:** AjitKumbhar  
- **Repository:** Terraform  
- **Primary Azure Region:** North Europe  

**Key Technologies:**
- Terraform 1.15.2
- AzureRM Provider 4.68.0
- Azure Pipelines for CI/CD
- Checkov for security scanning
- Azure Blob Storage for remote state management

## MCP Server Usage (Mandatory)

This project is connected to a Terraform MCP server. Claude MUST follow 
these rules without exception before writing any Terraform code:

### Before writing any resource or module code
1. Call `get_latest_provider_version` to verify registry state — but ALWAYS 
   pin generated code to **AzureRM 4.68.0** regardless of what the latest version is
2. Call `get_provider_details` specifying version **4.68.0** to get accurate 
   resource schema, required arguments, and optional arguments for that exact version
3. Call `get_module_details` if using any public registry modules — again 
   verify compatibility with AzureRM 4.68.0

### Hard rules
- NEVER rely on training data for resource arguments, attribute names, or 
  block structures — always verify against MCP for AzureRM 4.68.0
- NEVER suggest upgrading the AzureRM provider version
- NEVER generate code using arguments that are not confirmed present in 
  AzureRM 4.68.0 schema from the MCP server
- NEVER skip MCP verification even if the resource seems simple or familiar
- If the MCP server is unreachable, STOP and inform the user — do not 
  fall back to training data

## Architecture

### Directory Structure

```
Terraform/
├── Environments/
│   ├── Dev/                    # Dev environment configuration
│   │   ├── main.tf            # Module instantiation for Dev
│   │   ├── providers.tf       # Backend & provider config
│   │   ├── terraform.tfvars   # Provide values to input variables 
│   │   └── variables.tf       # Dev-specific input variables
│   └── Prod/                   # Prod environment configuration (same structure as Dev)
├── Modules/                    # Reusable Terraform modules for Azure resources
│   ├── ResourceGroup/
│   ├── VirtualNetwork/
│   ├── VirtualMachine/
│   ├── NetworkInterface/
│   ├── StorageAccount/
│   ├── NSG/
│   ├── PublicIP/
│   ├── Subnets/
│   ├── SQLDatabase/
│   └── webapp/
└── azure-pipelines.yml         # Single consolidated pipeline for all environments
```

### Module Design

Every module lives in `/Modules/<ModuleName>/` and must contain exactly 
three files:

- `main.tf` — Azure resource definitions only
- `variables.tf` — All input variable declarations with type and description
- `outputs.tf` — All output values needed by other modules

**When writing a new module:**
- Declare every configurable value as a variable — no hardcoded values 
  inside modules
- Every variable must have a `type` and `description`
- Sensitive variables (passwords, keys, secrets) must have `sensitive = true`
- Every resource attribute that another module might consume must be 
  declared in `outputs.tf`

**When calling modules from an environment `main.tf`:**

```hcl
module "<module_name>" {
  source = "../../Modules/<ModuleName>"

  variable_one = var.<variable_one>
  variable_two = var.<variable_two>
}

module "<dependent_module_name>" {
  source = "../../Modules/<DependentModuleName>"

  variable_one = var.<variable_one>
  variable_two = module.<module_name>.<output_name>

  depends_on = [module.<module_name>]
}
```

- Always use `module.<name>.<output>` to pass values between modules
- Always use explicit `depends_on` when one module consumes another's output
- Never hardcode values in environment `main.tf` — always use `var.*` 
  or `module.*` references

**Module dependency rules (applies to all modules):**
- Identify what Azure resource each module creates
- Determine what that resource requires to exist before it can be created
- Always declare those upstream modules first in `main.tf`
- Always use `depends_on` to make dependencies explicit — never rely on 
  implicit ordering
- If a new resource type has no existing module, always:
  1. Create the module first under `/Modules/<ModuleName>/` with all 
     three required files (`main.tf`, `variables.tf`, `outputs.tf`)
  2. Then immediately reference it from the environment-specific 
     `Environments/<Env>/main.tf` without waiting to be asked
  3. Add any new input variables to `Environments/<Env>/variables.tf`
  4. Add placeholder values for new variables in 
     `Environments/<Env>/terraform.tfvars` with a comment marking 
     them as required to fill in
     

## Guardrails

- NEVER modify `providers.tf` in any environment — provider and backend 
  configuration is managed separately
- NEVER modify `azure-pipelines.yml` — pipeline configuration is outside 
  Claude's scope
- NEVER generate `terraform destroy` commands or destruction-oriented code
- NEVER suggest or apply changes that would destroy existing resources
- NEVER commit or suggest committing sensitive values, state files, plan 
  files, or `.terraform/` directories
- NEVER upgrade the AzureRM provider version beyond `4.68.0`
- NEVER write inline resources directly in environment `main.tf` — always 
  use modules
- NEVER skip MCP verification before writing any resource code
- NEVER commit any code to the repository — code is written for engineer 
  review only. The engineer is solely responsible for reviewing, validating 
  and committing all code
- If asked to do anything that violates these guardrails, STOP and explain 
  why rather than proceeding

## What Not To Do

- Do not create resources outside of the module pattern — every Azure 
  resource must live in a module under `/Modules/`
- Do not use `count` or `for_each` unless explicitly requested — keep 
  configs simple and readable by default
- Do not add provider blocks inside modules — providers are declared only 
  in `Environments/*/providers.tf`
- Do not use `terraform_remote_state` data sources — inter-module 
  communication happens via module outputs and `depends_on` only
- Do not generate `.tfvars` files containing real sensitive values — use 
  placeholder values with clear comments indicating what the engineer 
  must fill in
- Do not make assumptions about existing infrastructure — if a dependency 
  is unclear, ask before writing code
- Do not assume which environment to target — if the engineer does not 
  explicitly specify Dev or Prod, always ask before generating any code

## Security

- All storage resources must have public access disabled by default
- All Key Vault resources must have purge protection and soft delete enabled
- Network Security Groups must follow least-privilege — deny all inbound 
  by default, open only explicitly required ports
- Never output sensitive values — if an output is sensitive, mark it with 
  `sensitive = true`
- Flag any configuration that Checkov is likely to fail on — add a comment 
  explaining the risk and ask the engineer to confirm before proceeding
