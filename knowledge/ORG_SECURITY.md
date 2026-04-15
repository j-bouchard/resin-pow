# POW Org Security
Generated: 2026-04-15 | Org: protectourwinters.org

## Overview

| Type | Count |
|------|-------|
| Custom Permission Sets | 11 |
| Managed Package Permission Sets | 2 |
| Profiles | 37 (6 standard, 31 custom) |
| Roles | 32 |
| Public Groups | 1 |
| Queues | 1 |

---

## Permission Sets (11 custom)

### Donation Access (3 tiers)

| Name | Label | Description | Key Permissions |
|------|-------|-------------|-----------------|
| View_Donations | View Donations | Read-only access to donation info | Opportunity: Read, npe01__OppPayment__c: Read, npe03__Recurring_Donation__c: Read, npsp__Allocation__c: Read, npsp__General_Accounting_Unit__c: Read |
| Edit_Donations | View and Edit Donations | Create/edit donations and recurring donations | Opportunity: Create/Edit/Read, npe01__OppPayment__c: Read, npe03__Recurring_Donation__c: Create/Edit/Read, npsp__Allocation__c: Create/Edit/Read |
| Edit_Donations_and_Payments | View and Edit Donations & Payments | Full donation + payment access | Opportunity: Create/Edit/Read, npe01__OppPayment__c: Create/Edit/Read, npe03__Recurring_Donation__c: Create/Edit/Read, npsp__Allocation__c: Create/Edit/Read, npsp__General_Accounting_Unit__c: Create/Edit/Read |

### Alliance & Program Access

| Name | Label | Description | Key Permissions |
|------|-------|-------------|-----------------|
| Alliance_Record_Type_Access | Alliance Record Type Access | Grants Alliance Member record type visibility | Contact: ViewAll/ModifyAll, RecordType: Alliance_Member |
| Alliance_Record_Type_Prevention_of_Change | Alliance Record Type - Prevention of Change | Prevents users from changing Alliance Record Type | Contact: Create/Edit/Delete/ViewAll/ModifyAll |

### Integration & Admin

| Name | Label | Description | Key Permissions |
|------|-------|-------------|-----------------|
| Integration_User_Standard_Objects | Integration User - Standard Objects | Full access for integration user | Account/Campaign/Contact/Lead/Opportunity: Edit/Delete/Read/ModifyAll/ViewAll, Order: Full CRUD, Ballot_Ready__c: Full Access, Order_Fulfillment__e: Create/Read |
| Case_Full_Access | Case Full Access | Full case management access | Case: Create/Edit/Delete/Read/ModifyAll/ViewAll |
| Batch_Gift_Entry | Batch Gift Entry | NPSP Batch Gift Entry access | Account/Contact/Opportunity: Create/Edit/Read, npsp__DataImportBatch__c: Create/Edit/Read, npsp__DataImport__c: Create/Edit/Delete |
| MFA | MFA | Multi-factor authentication | (label only — no specific permissions) |
| No_MFA | No MFA | MFA bypass | User Permission: BypassMFAForUiLogins |

### Managed Package Permission Sets

| Name | Label | Description |
|------|-------|-------------|
| KnowWho_Data_Update_Access | KnowWho Data Update Access | KnowWho data management Apex class access |
| KnowWho_User_Read_Access | KnowWho User Read Access | Read-only access to KnowWho (kw__) fields |

---

## Profiles (37 total)

### Standard Profiles (6)
- Admin (System Administrator)
- Standard
- StandardAul
- Guest
- Minimum Access - API Only Integrations
- Minimum Access - Salesforce

### Custom Profiles — Staff (10)
| Profile | Purpose |
|---------|---------|
| POW System Admin | Full admin with POW-specific config |
| System Admin - Advocacy | Admin access for advocacy team |
| System Admin - Training | Admin access for training purposes |
| System Administrator - Sync | Admin for sync/integration operations |
| Executive Management | Executive-level access |
| Fundraising and Development | Development team access |
| Comms and Marketing | Communications team |
| Program Staff | Program team |
| Advocacy | Advocacy team |
| Partnerships | Partnerships team |

### Custom Profiles — Alliance/Volunteer (5)
| Profile | Purpose |
|---------|---------|
| Alliance Captains | Alliance team captains |
| Alliance Captain - Science | Science alliance captains |
| Volunteer | Volunteer access |
| Volunteer Profile | Additional volunteer profile |
| MarketingProfile | Marketing access |

### Custom Profiles — Integration (7)
| Profile | Purpose |
|---------|---------|
| Anypoint Integration | MuleSoft integration |
| CiviClick Webhook Profile | CiviClick/P2A webhook |
| ShopifyIntegration Profile | Shopify integration |
| Salesforce API Only System Integrations | API-only integrations |
| Sales Insights Integration User | Sales Insights |
| SalesforceIQ Integration User | SalesforceIQ/RelateIQ |
| Analytics Cloud Integration User | Analytics/Tableau |

### Custom Profiles — Community/Other (9)
| Profile | Purpose |
|---------|---------|
| Chatter External User | External Chatter access |
| Chatter Free User | Free Chatter access |
| Chatter Moderator User | Chatter moderation |
| Guest License User | Guest user access |
| Identity User | Identity services |
| Analytics Cloud Security User | Analytics security |
| ContractManager | Contract management |
| SolutionManager | Solution management |
| Read Only | Read-only access |

---

## Roles (32 total)

### Organizational Hierarchy

```
CEO
├── COO
│   ├── Director_Operations
│   │   ├── Coordinator_Operations
│   │   └── Consultant_Finance
│   └── Director_Merchandise_and_Memberships
├── Vice_President_Campaigns
│   ├── Director_Campaigns
│   │   ├── Coordinator_Campaigns
│   │   └── Senior_Manager_Programs
│   └── Manager
├── Vice_President_Development
│   ├── Director_Development
│   │   ├── Coordinator_Development
│   │   ├── Senior_Manager_Development
│   │   └── Manager_Grants_and_Impact
│   └── Director_Strategic_Partnerships
│       └── Manager_Strategic_Partnerships
├── Vice_President_Marketing_and_Communications
│   ├── Director_Digital
│   │   └── Manager_Communications
│   │       └── Senior_Manager_Content
│   └── Senior_Director
├── Team Captains
│   ├── Team_Captain_Bike
│   ├── Team_Captain_Climb
│   ├── Team_Captain_Creative
│   ├── Team_Captain_Run
│   ├── Team_Captain_Science
│   ├── Team_Captain_Ski
│   └── Team_Captain_Snowboard
└── Executive_Assistant
```

---

## Public Groups (1)

| Name | Description |
|------|-------------|
| admins | Public group with boss inclusion enabled |

## Queues (1)

| Name | Object | Email | Members |
|------|--------|-------|---------|
| Communications | Case | memberships@protectourwinters.org | brian, donny, lora, sam |

---

## Page Layouts (124 total)

Key custom layouts by object:

| Object | Layouts |
|--------|---------|
| Account | Government Office, Household Lightning, Local Alliance, Organization Lightning, POW Partner |
| Contact | Alliance Member, Alliance Member - Captains, Contact Lightning, Legislators, POW Contact, Volunteers Contact |
| Opportunity | Event Ticket, Merchandise, POW Partner |
| Campaign | Campaign, Event, Parent |
| Case | Case Layout, Closed Case, Case Close Layout |
