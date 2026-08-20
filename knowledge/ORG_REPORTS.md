# POW Reports & Dashboards
Generated: 2026-08-20 | Org: protectourwinters.org (00D4P000001dRZ9)

## Overview

| Type | Count | Source |
|------|-------|--------|
| Custom Report Types | 41 (+3 since Apr 2026) | Metadata retrieve |
| Reports | 2,113 | SOQL (Report), all folders |
| Dashboards | 93 | SOQL (Dashboard), all folders |

Report/dashboard definitions still require folder-scoped package.xml
members to retrieve as metadata; counts above come from read-only SOQL.

## Report Folders (top by report count, of ~150 folders)

| Folder | Reports | | Folder | Reports |
|--------|---------|-|--------|---------|
| Development Department | 134 | | NPSP 3.0 Donor Mgmt Reports | 39 |
| Battleground Analytics 2020 | 122 | | NPSP Fundraising Reports | 35 |
| Programs Department | 117 | | Admin Greener Pastures FY23 | 34 |
| Private Reports | 110 | | Volunteer Reports | 33 |
| Waverley's Reports | 69 | | Donors | 31 |
| Resin | 67 | | DonorSearch Folder | 30 |
| Public Reports | 56 | | Stages | 29 |
| Mel's Reports | 49 | | Colorado CD3 | 27 |
| z_Archived | 48 | | Data Quality Audit | 26 |
| MAPTV 2022 | 43 | | Voter File Reports 2022 | 25 |
| Pledge 2022 | 40 | | Alliance User Journey / Captains | 22 each |

A large tail of 2020-2022 election/analytics folders suggests an archive
cleanup opportunity.

## Dashboard Folders (93 dashboards)

Development (23), Programs (8), Private (8), Membership (8), Events (8),
Objectives and Key Results (5), NPSP Dashboards (4), Volunteer (3),
Organizational Health (3), Campaigns (3), plus ~15 single-dashboard
folders (Blackthorn, Grants, Merchandise, POW Action Fund, Training, etc.).

Key dashboards (per Salesforce Manual): **POW Development Forecasting**,
**POW Development Analysis**, **Membership Dashboard**; the **Objectives
and Key Results** folder (5 dashboards) backs the Alliance OKRs Leadership
View that `Campaign.Alliance_Training__c` (deployed 2026-08-20) feeds.

---

## Custom Report Types (41 total)

New since Apr 2026: `Accounts_Contact_with_or_without_Opportunities`,
`Analytic_Notifications`, `Contacts_with_Affiliations`.

### Contacts & Accounts
| Report Type | Description |
|-------------|-------------|
| Accounts_Contact_with_or_without_Opportunities | Accounts + contacts with/without opps _(new since Apr 2026)_ |
| Contact_Fields | Contact field reporting |
| Contacts_and_Accounts | Contacts with account data |
| Contacts_with_Affiliations | Contact affiliation reporting _(new since Apr 2026)_ |
| Contacts_with_Opportunities | Contact-opportunity relationships |
| Contacts_with_Tasks_and_Events | Contact activities |
| Contacts_with_Topics | Contact topic associations |
| Contacts_in_Campaigns | Contacts linked to campaigns |
| Contacts_with_Campaign_History | Full campaign history per contact |
| Accounts_with_Contacts | Account-contact relationships |
| Accounts_with_Opportunities | Account-opportunity relationships |
| Accounts_and_Contacts_with_Opportunites | Full account-contact-opportunity chain |

### Donations & Finance
| Report Type | Description |
|-------------|-------------|
| Opportunities_with_Contacts_with_Affiliations | Donations with affiliated org context |
| Opportunities_with_Primary_Contacts | Donations with primary contact |
| Opportunities_with_orders | Donations linked to orders |
| Opportunties_with_Recurring_Donation | Opportunities linked to NPSP recurring donations |
| Contacts_with_Recurring_Donations | Contact recurring donation history |
| Contacts_with_Classy_Recurring_Donations | Classy-specific recurring donations |
| GoFundMe_Recurring | GoFundMe/Classy recurring donation reporting |

### Campaigns & Events
| Report Type | Description |
|-------------|-------------|
| Campaigns_and_Campaign_Members | Campaign with member details |
| Campaigns_with_Contacts | Campaign-contact relationships |
| Contacts_with_Attendees | Contact event attendance (Conference360) |
| Contacts_with_Attendee_Data | Detailed attendee data per contact |
| Attendees_with_Form_Submissions | Event attendees with form data |

### Alliance Program
| Report Type | Description |
|-------------|-------------|
| Alliance_Members_with_Survey | Alliance members with survey responses |

### Partnerships
| Report Type | Description |
|-------------|-------------|
| Accounts_with_Deliverables | Partner accounts with deliverable tracking |

### Advocacy & Voter Data
| Report Type | Description |
|-------------|-------------|
| Contacts_with_Ballot_Ready_Data | Contact voter engagement data |

### Forms & Submissions
| Report Type | Description |
|-------------|-------------|
| Contacts_with_Form_Submissions | Contact form submission data |
| Contacts_with_Form_Submissions_2 | Contact form submission data (v2) |
| Contacts_with_Formstack_Submissions | Formstack-specific submissions |
| Form_Elements | Form element reporting |
| Form_Submission_Answers | Individual form answers |
| Formstack_Submissions | All Formstack submissions |

### Engagement
| Report Type | Description |
|-------------|-------------|
| Engagements_with_Activites | Engagement records with activities |
| Engagements_with_Campaign_Members | Engagement with campaign member data |

### Data Quality
| Report Type | Description |
|-------------|-------------|
| Duplicate_Accounts | Duplicate account identification |
| Duplicate_Contacts | Duplicate contact identification |
| Duplicate_Data_Imports | Duplicate data import records |
| Duplicate_Records | General duplicate record reporting |

### System
| Report Type | Description |
|-------------|-------------|
| Email_Messages | Email message reporting |
| flow_orchestration_* (5 types) | Flow orchestration system report types |
| screen_flows_prebuilt_crt | Screen flow prebuilt report type |

---

## Retrieving Reports & Dashboards

To complete this documentation, run these queries from a local terminal:

```bash
# List report folders
sf data query --query "SELECT Id, Name, DeveloperName FROM Folder WHERE Type = 'Report' ORDER BY Name" --target-org production --json

# List dashboard folders
sf data query --query "SELECT Id, Name, DeveloperName FROM Folder WHERE Type = 'Dashboard' ORDER BY Name" --target-org production --json

# List all reports
sf data query --query "SELECT Name, DeveloperName, FolderName, Description, Format FROM Report WHERE IsDeleted = false ORDER BY FolderName, Name" --target-org production --json

# List all dashboards
sf data query --query "SELECT Title, DeveloperName, FolderName, Description FROM Dashboard WHERE IsDeleted = false ORDER BY FolderName, Title" --target-org production --json
```

Then update the package.xml with specific folder/report members and re-retrieve.
