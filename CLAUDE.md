# Resin PoW - Salesforce NPSP Org Repository

## Project Overview

This repository contains the Salesforce metadata for a nonprofit organization running the **Nonprofit Success Pack (NPSP)**. It serves as the source of truth for org configuration, customizations, and automation.

## Tech Stack

- **Platform**: Salesforce (NPSP / Nonprofit Cloud)
- **CLI**: Salesforce CLI (`sf`) v2+
- **API Version**: 62.0
- **Source Format**: SFDX source format
- **Project Structure**: Standard SFDX project layout

## Directory Structure

```
resin-pow/
├── CLAUDE.md              # This file
├── manifest/
│   └── package.xml        # Full org metadata manifest (~70 types)
├── force-app/
│   └── main/default/      # Retrieved metadata (source format)
├── config/
│   └── project-scratch-def.json
├── scripts/               # Utility scripts (SOQL, Apex)
├── sfdx-project.json      # SFDX project configuration
└── .forceignore            # Files excluded from SF operations
```

## Org Authentication

The production org uses the alias **`production`**.

### Authenticate (first time)

```bash
sf org login web --alias production --instance-url https://login.salesforce.com
```

### Verify authentication

```bash
sf org list
sf org display --target-org production
```

## Metadata Retrieval

### Full org retrieval using the manifest

```bash
sf project retrieve start --manifest manifest/package.xml --target-org production
```

### Retrieve a single metadata type

```bash
sf project retrieve start --metadata ApexClass --target-org production
sf project retrieve start --metadata CustomObject --target-org production
```

## Key NPSP Packages

This org includes Salesforce.org managed packages. Common namespace prefixes:

- `npsp__` - Nonprofit Success Pack
- `npe01__` - Contacts & Organizations
- `npo02__` - Households
- `npe03__` - Recurring Donations
- `npe4__` - Relationships
- `npe5__` - Affiliations

## Development Workflow

1. Always retrieve latest metadata before making changes
2. Make changes in a sandbox or scratch org first
3. Test thoroughly before deploying to production
4. Use `sf project deploy start --manifest manifest/package.xml --target-org production --dry-run` to validate before deploying

## Commands Reference

| Command | Description |
|---------|-------------|
| `sf project retrieve start --manifest manifest/package.xml -o production` | Full metadata retrieve |
| `sf project deploy start --manifest manifest/package.xml -o production --dry-run` | Validate deployment |
| `sf project deploy start --manifest manifest/package.xml -o production` | Deploy to production |
| `sf org open -o production` | Open org in browser |
| `sf apex run -f scripts/apex/hello.apex -o production` | Run anonymous Apex |
