---
client: Protect Our Winters
generated: 2026-08-20T15:13:55+00:00
generated_from: dbaa381b9f5f5df3d79ccb682b8c7ca1d24f77ef
pipeline_version: pipeline-v1.3.1
---

# **Salesforce User Manual**

**Version 2 — August 2026** (completes the January 2025 v1; maintained by Resin LLC)

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

**Introduction to Salesforce: A Guide for Protect Our Winters**

Welcome to the Salesforce User Manual, used to provide detailed insights into how Protect Our Winter's team utilizes Salesforce. Harnessing the power of Salesforce's Nonprofit Success Pack (NPSP), the aim of this manual and Salesforce is to streamline constituent management, centralize data tracking, and scale fundraising efforts. This manual serves as your comprehensive resource, guiding you through Salesforce's features and functionalities, enabling you to maximize our collective impact in advancing environmental advocacy and action. 

[**Introduction** **2**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.5ldmx35uew0i)

[Purpose of the Document 2](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.pth4je16dwhq)

[Overview of NPSP Instance 2](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.pxnogayagup3)

[Key Stakeholders 3](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.u5k1ucau3d1a)

[**Salesforce Org Overview** **3**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.5jif3x5cbb6n)

[Integration Overview 3](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.cqxihtgpoexo)

[**Data Model Overview** **4**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.n87oun3rlrn8)

[Standard Objects 4](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.bbdw1b2c1lqi)

[Custom Objects 5](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.cljvessclpak)

[Custom Fields 5](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.o263jzgo5dky)

[Relationships Between Objects 5](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.ros39s8ynsoi)

[Record Types 5](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.kla81g100mz)

[**Household Model** **6**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.oq7wicu81g6i)

[Explanation of Household Account Model 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.9vkwjpi5xhb3)

[Customizations to Household Model 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.ry90khfu3qj5)

[Record Types (Households, Organizations, etc.) 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.um62oouxcbzi)

[**Donations Management** **6**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.ke2e4v81wcxz)

[Opportunity Management (Donation Types) 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.hoarhdcbc8wt)

[Recurring Donations (Setup & Configuration) 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.s5cb5b7p4zl4)

[Payment Processing Setup 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.e5ias98jgfsf)

[Grant Management Overview (if applicable) 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.ksiqto71xiqh)

[**Custom Automation** **6**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.nucpic4iahfh)

[○ Workflow Rules 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.75tbd6kvuorq)

[○ Process Builders 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.clx4e5fde7v2)

[○ Flows 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.v1n0036xa4x)

[○ Apex Triggers (if any) 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.cy2cb2pcwahg)

[○ Automation Dependencies 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.cmzxnu1o9z7)

[**Custom Integrations** **6**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.ykp6hbeqcx33)

[○ External Tools (Classy, QuickBooks, Mailchimp, etc.) 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.gnedk08qyiqz)

[○ Integration Patterns (API, Webhooks, Middleware) 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.o9de23jmzmt1)

[○ Data Sync Frequencies and Fields Mapped 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.qisiserkhcd9)

[**Custom Reports and Dashboards** **6**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.hmxk0jjw7fof)

[○ Key Reports (Donation Reports, LYBUNT, SYBUNT) 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.1tclx4ccvs79)

[○ Dashboards for Fundraising, Grant Tracking, etc. 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.2u0fk26kjr99)

[○ Custom Report Types 6](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.1ydvdk0invn)

[**Security and Access Control** **6**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.9p74uh3bljio)

[○ Profiles 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.5vbvq7nrn5hh)

[○ Roles 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.h7ng5bb6tptv)

[○ Sharing Rules 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.bybrw8cb6huk)

[○ Permission Sets 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.ny1ov425vlof)

[**Data Management** **7**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.w4d49kiptfsl)

[○ Data Import & Export Processes 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.xwmvc4a9zypb)

[○ Data Validation Rules 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.yfij0k4gx2ly)

[○ Duplicate Management Strategy 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.dqs27tptik9r)

[○ Data Archiving Strategy 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.her1nqc3s6t3)

[**Engagement and Communication** **7**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.5yxih1vsk92b)

[○ Email Templates 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.6rl26rp2m0e4)

[○ Campaigns and Campaign Hierarchies 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.vuwr8jygzmd8)

[○ Engagement Plans and Levels 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.m7cz7jfroc58)

[○ Custom Email Alerts and Automations 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.renm3a5d88g1)

[**User Training and Adoption** **7**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.inl5xl5edasi)

[○ Key User Roles and Responsibilities 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.dxzzifsu24c2)

[○ Training Materials 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.7ixtzzjq6di2)

[○ User Guides for Specific Features 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.rb92pqsc6h49)

[○ Ongoing Support and Feedback Loops 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.jzsoiihrexde)

[**System Maintenance and Governance** **7**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.ml3bl2l691fl)

[○ Backup and Restore Processes 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.z6a9fdmztjel)

[○ System Health Checks 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.qo4zruvv77ba)

[○ Audit Trail for Key Changes 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.stj59kix7x0n)

[○ Release Management Strategy (updating NPSP and custom packages) 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.t9v11y9pbn8b)

[**Technical Debt and Cleanup** **7**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.j2a40oetstak)

[○ Overview of Existing Technical Debt 7](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.7u8e7tp1bmuy)

[○ Plans for Reducing Technical Debt 8](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.95zex8cltyog)

[○ Custom Code and its Purpose (Apex, Visualforce, LWC) 8](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.dbotfepw79ib)

[**Future Enhancements** **8**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.l6fpyiy88iw3)

[○ Potential System Upgrades 8](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.16o7dj2q3di2)

[○ Additional Features (e.g., Einstein for Nonprofits) 8](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.rlxpi6ebdgae)

[○ Roadmap for future automations, integrations, or customizations 8](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.zafen0uw19vm)

[**Appendix** **8**](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.ivl7pa9vfywr)

[○ Glossary of Terms 8](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.5my57zt9riy8)

[○ Useful Resources (NPSP Documentation, Salesforce Support) 8](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.rs21f4eho0gr)

[○ Contact Information for Key Support 8](https://docs.google.com/document/d/1S_W1PsE5nfSt7kD7iWEhMcPFoZQgsbEgcX6F2xkXOII/edit?ouid=110295639254258473132#heading=h.esra82m4oz)

## 

  
  
  

## Introduction

### Purpose of the Document

This document serves as a comprehensive resource for the Salesforce instance used by the organization *Protect Our Winters* (POW). It is designed to assist Salesforce administrators and staff members in addressing questions related to the configuration, use, and maintenance of the system. The goal is to ensure that the organization’s staff can effectively utilize Salesforce to fulfill their mission and manage constituent relationships.

### Overview of NPSP Instance

The core mission of *Protect Our Winters* is:  
*"We turn passionate outdoor people into climate advocates, working together to protect the places and experiences they love from climate change."**  
*Salesforce's Nonprofit Success Pack (NPSP) plays a central role in supporting this mission by providing a 360-degree view of all interactions with constituents. This includes managing donations, advocates, alliance members, partnerships, events, board members, email lists, and other touchpoints with POW’s stakeholders.

The NPSP instance has several customizations, particularly around the membership program, which differs from the standard NPSP membership objects. Additionally, the instance integrates with various tools that enhance its capabilities, including:

  - **360MatchPro** by Double the Donation
  - **Blackthorn Events**
  - **Classy**
  - **Cloudingo**
  - **DonorSearch 360io**
  - **Formstack for Salesforce**
  - **Gmail Extension**
  - **KnowWho**
  - **Mailchimp/Cazoomi Sync Apps**
  - **Phone2Action / CiviClick** (CiviClick replaced Quorum, January 2026)
  - **Higher Logic (POW Connected)**
  - **Google Ads lead capture**
  - **Shopify** (merchandise store — replaced WooCommerce, September 2025)

These integrations, along with customizations, enable POW to better manage their data and relationships, furthering their advocacy efforts.

### Key Stakeholders

  - **Joe Bouchard**, Resin LLC
  - Department Leads at Protect Our Winters

## Salesforce Org Overview

  - **Org Name**: Protect Our Winters
  - **Org ID**: 00D4P000001dRZ9

<!-- end list -->

  - **Salesforce Edition:** Enterprise Edition
  - **NPSP Version**: 3.229

<!-- end list -->

  - **NPSP Licenses**: 36

### Integration Overview

The *Protect Our Winters* Salesforce instance integrates with several external tools to streamline operations, including managing donations, events, data hygiene, and communications. The following integrations are currently active:

  - **360MatchPro** by Double the Donation: Used to track and manage corporate matching gifts, providing an easy way to identify eligible donors and match opportunities.
  - **Blackthorn Events**: Facilitates event management within Salesforce, enabling POW to organize, track, and report on events while providing attendees with a seamless registration experience.
  - **Classy**: An online fundraising platform that syncs with Salesforce to track donations, campaigns, and donor engagement within the CRM.
  - **Cloudingo**: A data cleansing tool used to manage duplicate records, ensuring data accuracy and consistency across the Salesforce instance.
  - **DonorSearch 360io**: Provides wealth screening and donor prospecting capabilities, integrating insights about donors’ philanthropic histories directly into Salesforce.
  - **Formstack**: A form-building tool integrated into Salesforce to manage and capture data from forms, including donor forms and event registrations.
  - **Gmail Extension**: Integrates Gmail with Salesforce, allowing users to easily log emails, create contacts, and update records directly from their inbox.
  - **KnowWho**: A tool to manage and track communications with government representatives, advocacy efforts, and legislative impacts.
  - **Mailchimp/Cazoomi Sync Apps**: Facilitates email marketing by syncing Mailchimp lists and campaigns with Salesforce data for targeted email outreach.
  - **Phone2Action**: An advocacy tool that helps manage grassroots campaigns, track interactions with constituents, and drive engagement with policymakers.
  - **\*\*woocommerce/merchandise integration:\*\***

Each integration provides a key function to support POW’s mission, enabling efficient management of data and interactions with their stakeholders.

## Data Model Overview

### Standard Objects

  - **Account**: Represents an individual’s household, organization, or partner of *Protect Our Winters* (POW). There are three key record types:
      
      - **Household Accounts**: Automatically created when a new contact is added.
      - **Organization Accounts**: Used for foundations, nonprofits, and non-partner companies.
      - **Partner Accounts**: Represents organizations that are pledge or current POW partners.
  - **Affiliation**: Tracks relationships between contacts and organizations, such as when an individual works for an organization that is part of POW’s network.
  - **Attendee**: A custom object used to capture and manage details of individuals attending POW events through Blackthorn.
  - **Campaign**: Used to track activities such as fundraising events, email campaigns, and advocacy efforts.
      
      - **Default Campaigns**: For fundraising, advocacy, and email outreach.
      - **Parent Campaigns**: Used for campaign hierarchies if the campaign is a parent campaign.
  - **Campaign Member**: Describes the relationship between a contact and a campaign.
  - **Case**: Used for managing external requests and inquiries.
      
      - **Default Case**: General inquiries from the website’s “Contact Us” form.
  - **Contact**: Represents individuals, including donors, advocates, and volunteers.
      
      - **Contact Record Type**: For general constituents.
      - **Alliance Member Record Type**: For athletes, scientists, and creatives in POW’s Alliance.
  - **Event**: Used to manage both in-person and virtual events.
      
      - **In-Person Event**: Manages physical events.
      - **Virtual Event**: Manages online events.
  - **\*\*GAU:\*\* Represents a specific fund or allocation category within an organization's accounting structure.**
  - **\*\*GAU Allocations:\*\* Tracks the allocation of individual donations (Opportunities) to one or more GAUs**
  - **Opportunity**: Manages various donation types and merchandise purchases:
      
      - **Classy**: Online donation platform.
      - **Corporate**: Non-partner company donations.
      - **Donation**: Individual donations.
      - **Grant**: Donations from foundations.
      - **Partner Commitments**: Partner organization donations.
      - **Matching Gifts**: Corporate matching of individual donations.
      - **In-Kind Gifts**: Non-monetary donations.
      - **Merchandise**: Tracks merchandise sales.
  - **\*\*Partial Soft Credit:\*\* links a donation (Opportunity) to additional Contacts who should receive recognition for the gift, even though they are not the primary donor.**
  - **Payment**: Tracks individual payments associated with opportunities.
  - **Product**: Tracks merchandise items related to opportunities for merchandise purchases, providing visibility into the actual products sold.
  - **Task**: Standard Salesforce object used to manage to-dos and tasks assigned to users across the organization.

### Custom Objects

  - **L2 Data**: Custom object holding fields related to L2 data, voter election data, from the 2022 election
  - **\*\*Partner Deliverables:\*\* holds information about the deliverables the partner or POW completed related to the partnership**

### Custom Fields and/or Notes on Certain Fields

#### Contact Object

  - **Description:** This field is used for contact bios and other timeless data. Ie data related to the contact that does not change
  - **Context:** Current must knows, including connection to POW
  - **Talking Points:** This field is used to house important high level points on the contact
  - **\*\*Major Donor Potential:\*\* If this is check as true, the contact has a potential for major giving ($1,000+)**
  - **\*\*Donor Level:\*\* This levels are automatically assigned using Salesforce standard object ‘Levels’. Criteria on assignment is as follows: Ally - 18 Month Giving \\\<$1,000, Advocate - 18 Month Giving $1,000 - $4,999 Enthusiast - 18 Month Giving $5,000 - $9,999 Champion - 18 Month Giving - $10,000 - $24,999 Titan - 18 Month Giving \\\>$25,000**
  - **\*\*Previous Donor Level:\*\* The level the donor was at before their current donor level. This will be null if they were never at a previous donor level.**
  - **\*\*Membership Status:\*\* Populates to Current or Expired based on membership criteria. Please see membership section for more information**
  - **Member ID:** Contact’s Salesforce ID
  - **\*\*Membership Join Date:\*\* The date the contact took their first membership action**
  - **\*\*Last Membership Date:\*\* The date of their last membership action**
  - **\*\*Membership Opt Out:\*\* This contact has opted out of their POW membership**
  - **\*\*Initial Entry Point:\*\* The contact’s first membership action. Values will be ‘Advocacy Action’, ‘Donation’, ‘Event Attendee’, ‘Merchandise Purchase’, ‘Partner Opt In’, or ‘POW Opt In’**
  - **\*\*Most Recent Entry Point:\*\* The contact’s most recent membership action. Values will be ‘Advocacy Action’, ‘Donation’, ‘Event Attendee’, ‘Merchandise Purchase’, ‘Partner Opt In’, or ‘POW Opt In’**
  - **\*\*Member Entry Points:\*\* All membership actions the contact has taken. Values will be ‘Advocacy Action’, ‘Donation’, ‘Event Attendee’, ‘Merchandise Purchase’, ‘Partner Opt In’, and/or ‘POW Opt In’**
  - **\*\*Membership End Date:\*\* This will be 365 days after their last membership date. Ie. 365 days from their last membership action. Once this date has passed, their membership status will change to ‘Expired’**
  - **\*\*Membership Years:\*\* The years the contact has been a member**
  - **\*\*Last Membership Amount:\*\* The contacts most recent membership amount donated**
  - **\*\*Total Membership Amount:\*\* The total amount a contact has donated towards membership**
  - **\*\*First Merchandise Amount:\*\* A contact’s first merchandise purchase amount**
  - **\*\*Last Merchandise Amount:\*\* A contact’s last merchandise purchase amount**
  - **\*\*Total Merchandise Amount:\*\* The total amount of all merchandise purchases the contact has made**
  - **\*\*Last Merchandise Date:\*\* The date the contact last purchased merchandise**
  - **\*\*MailChimp Bounce Data:\*\* Data from Mailchimp on deliverability** 
  - **\*\*POW:\*\* If ‘Yes’, the contact will be added to the Mailchimp Protect Our Winters audience. If not, the contact will not be added to the Mailchimp Protect Our Winters audience. By default, it is marked as ‘Yes’**
  - **POW Action Fund:** If ‘Yes’, the contact will be added to the Mailchimp Protect Our Winters Action Fund audience. If not, the contact will not be added to the Mailchimp Protect Our Winters Action Fund audience.
  - **\*\*8000ers:\*\* Is marked as TRUE, then the contact has a high potential for fundraising**
  - **\*\*POW Internal Team:\*\* If marked as TRUE, this contact will be tagged as ‘POW Internal Team’ in Mailchimp for internal emails** 
  - **\*\*Sport Interest:\*\* Picklist of sports the contact said they are interested in. This is sent to Mailchimp for segmentation purposes**
  - **\*\*Archived:\*\* Populated based on POW’s Data Retention Policy (please see section for more info)**
  - **Federal House District**: The U.S. congressional district in which the voter is registered, determining their representative in the U.S. House of Representatives.
  - **State House District**: The state legislative district that elects a representative to the state’s House of Representatives (or equivalent lower chamber).
  - **City District**: The municipal or local district in which the voter resides, determining local representation and governance.
  - **State Senate District**: The legislative district that elects a representative to the state’s Senate (or equivalent upper chamber).
  - **\*\*2014 General Election Voting Method:\*\* The method the voter used to cast their ballot in the 2014 general election (e.g., in-person, early voting, mail-in).**
  - **\*\*2014 Primary Election Voting Method:\*\* The method the voter used to cast their ballot in the 2014 primary election.**
  - **\*\*2016 General Election Voting Method:\*\* The method the voter used to vote in the 2016 general election.**
  - **\*\*2016 Presidential Election Voting Method:\*\* The method the voter used to vote in the 2016 presidential election.**
  - **\*\*2016 Primary Election Voting Method:\*\* The method the voter used to vote in the 2016 primary election.**
  - **\*\*2018 General Election Voting Method:\*\* The method the voter used to vote in the 2018 general election.**
  - **\*\*2018 Primary Election Voting Method:\*\* The method the voter used to vote in the 2018 primary election.**
  - **\*\*2020 Primary Election Voting Method:\*\* The method the voter used to vote in the 2020 primary election.**
  - **\*\*2020 Presidential Primary Voting Method:\*\* The method the voter used to vote in the 2020 presidential primary election.**
  - **\*\*2020 General Election Voting Method:\*\* The method the voter used to vote in the 2020 general election.**
  - **2014 Primary Election Party**: The political party the voter was affiliated with when voting in the **2014 primary election**.
  - **2016 Presidential Primary Election Party**: The political party the voter was affiliated with when voting in the **2016 presidential primary election**.
  - **2016 Primary Election Party**: The political party the voter was affiliated with when voting in the **2016 primary election**.
  - **2018 Primary Election Party**: The political party the voter was affiliated with when voting in the **2018 primary election**.
  - **Voter Status**: The current **registration status** of the voter (e.g., Active, Inactive, Removed).
  - **2020 General Election Vote Propensity**: A calculated likelihood (or score) estimating how likely the voter was to cast a ballot in the **2020 general election**.
  - **Ballot Requested**: Indicates whether the voter requested a mail-in or absentee ballot for an election.
  - **Ballot Requested Date**: The date the voter requested a mail-in or absentee ballot.
  - **Ballot Sent**: Indicates whether an election office sent a mail-in or absentee ballot to the voter.
  - **Ballot Sent Date**: The date an election office sent the mail-in or absentee ballot.
  - **Ballot Returned**: Indicates whether the voter **returned their ballot** (i.e., it was received by the election office).
  - **Ballot Returned Date**: The date the election office received the voter’s returned ballot.
  - **Voter Rating**: A score or classification assigned to the voter based on engagement, voting history, or predictive modeling.
  - **Political Party**: The **political party affiliation** of the voter, as recorded in their voter registration.

#### Account Object

  - **\*\*Partner Level\*\*: Indicates the tier or status of the partner within the organization’s partnership program** 
  - **\*\*Contract Needed:\*\* Yes/No field that specifies whether a formal contract is required for the partnership.**
  - **\*\*Contract Start Date:\*\* The date the partnership contract begins, marking the official start of the agreement.**
  - **\*\*Contract Amount:\*\* The monetary value of the contract, representing the total financial commitment agreed upon between the organization and the partner.**
  - **\*\*Renewal Date:\*\* The date the partnership contract is set for renewal, indicating when the agreement should be reviewed or extended.**

#### Opportunity Object: 

  - **\*\*Discount Code:\*\* The discount code the contact used on the merchandise purchase**
  - **\*\*Fund Designation:\*\* Designates whether the opportunity is for POW, POW Action Fund or Other.**
  - **\*\*Order ID:\*\* The ID of the woocommerce related merchandise order**

#### Campaign Object:

  - **\*\*OKR Win/Loss:\*\* Determines if the campaign was considered a ‘Win’ or a ‘Loss’**
  - **\*\*OKR Type:\*\* The type of OKR the campaign supports**
  - **\*\*Alliance Mobilization Type:\*\* The type of ‘Alliance mobilization’. Used for tracking program OKR’s**
  - **\*\*Alliance Training Type:\*\* The type of ‘Alliance training’. Used for tracking program OKR’s**
  - **\*\*Alliance Training Category:\*\* The category of the Alliance training. Used for tracking program OKR’s**
  - **\*\*Membership Campaign Type:\*\* The type of membership campaign.**

## Household Model

### Explanation of Household Account Model

The **Household Account Model** in NPSP is designed to group individual Contacts into a single Household Account, making it easier for nonprofits to manage relationships, donations, and communications at both the individual and household levels.

#### **Key Points:**

1.  **Household Account:** A Household Account represents a group of individuals (Contacts) living together or sharing a family relationship. It provides a single record for tracking overall household engagement and donations.
2.  **Automatic Household Creation:** When a new Contact is created, NPSP automatically generates a Household Account. If multiple Contacts belong to the same household, they are linked to the same account.
3.  **Household Naming:** NPSP automatically names households based on the last names of the Contacts.
4.  **Household-Level Donations:** Donations from all household members are rolled up to the Household Account, providing a total view of household giving.
5.  **Streamlined Communication:** Nonprofits can send one communication to an entire household, reducing duplicate outreach and improving communication efficiency.
6.  **Customizable Reports:** Household Accounts enable reporting on household-level giving and engagement, helping nonprofits track their most valuable supporters.

## Donations Management

### Opportunity Management (Donation Types)

In the Protect Our Winters Salesforce instance, opportunities are categorized by the following record types to track various types of donations and contributions:

1.  **Donation**: Represents standard one-time monetary gifts made by individuals or organizations. These are typically direct donations entered manually by the team
2.  **Classy**: Tracks online donations processed through the Classy platform, syncing donor and payment details directly into Salesforce.
3.  **Event Ticket**: Captures revenue generated from ticket sales for in-person or virtual events, allowing for tracking of event-specific fundraising efforts.
4.  **Grant**: Used to track funding received from foundations or other granting entities. These opportunities may include additional details such as grant application statuses and reporting deadlines.
5.  **In-Kind**: Tracks non-monetary contributions, such as donated goods or services. This type ensures a comprehensive view of all support received by POW.
6.  **Matching Gift**: Represents donations matched by an employer or another organization. These opportunities are linked to the original donation for tracking purposes.
7.  **Merchandise**: Tracks purchases of branded merchandise, allowing for an understanding of revenue generated through these sales.
8.  **Partner Commitment**: Represents financial contributions made by partner organizations, reflecting their pledged or fulfilled commitments to POW’s mission.

### Dashboards for Donation Management

To analyze and forecast donation data, POW utilizes two key dashboards:

1.  [**POW Development Forecasting**](https://pow.lightning.force.com/lightning/r/Dashboard/01ZRn000002NoB3MAK/view?queryScope=userFolders): This dashboard provides a forward-looking perspective on expected revenue. It helps the development team monitor potential incoming donations and assess progress toward fundraising goals.
2.  [**POW Development Analysis**](https://pow.lightning.force.com/lightning/r/Dashboard/01ZRn000002Nm9GMAS/view?queryScope=userFolders): Focused on historical performance, this dashboard tracks trends, evaluates donor retention, and measures the effectiveness of campaigns and events.

These dashboards are tailored to provide actionable insights to support strategic planning and donor engagement.

### Recurring Donations (Setup & Configuration)

Recurring donations are managed through the Classy platform and synced into Salesforce via the **Classy Recurring Donors** object.

  - **Setup**: No additional customizations have been applied to recurring donations in Salesforce.
  - **Resources**: For further details on managing recurring donations, refer to the [Classy Recurring Donations Documentation](https://support.classy.org/s/article/guide-to-recurring-donations).
  - **Reporting**: To analyze recurring donations, access the [**All Recurring Donations Report**](https://pow.lightning.force.com/lightning/r/Report/00O4P000006Wk6rUAC/view?queryScope=userFolders) in Salesforce.

### Payment Processing Setup

POW processes payments using multiple systems integrated with Salesforce:

1.  **Classy**: Payments are processed via Classy Pay and PayPal.
2.  **Blackthorn Events**: Payments are processed through Stripe for event ticket sales.
3.  **Merchandise**: Payments for merchandise purchases are also handled through Stripe.

<!-- end list -->

  - **Reconciliation Rules**:
      
      - Use the **payment date** as the **payout date** for donations processed via Classy and Stripe to ensure alignment with system payouts.
      - Stripe payouts are reconciled monthly in Salesforce using the payout date to align with financial reports. Resin oversees this reconciliation process.

### Grant Management Overview

Grants from foundations and granting entities are tracked as Opportunities with the **Grant** record type, which carries grant-specific fields (application status, contract details, reporting deadlines) on its own layout. Two things happen automatically: the **Manager of Grants and Impact** role has visibility across the grant pipeline, and a **grant task is created 28 days before each grant's close date** so reporting deadlines don't sneak up. Grant revenue rolls into the same NPSP giving totals as other donations; use the Grant record type filter in Development reports to see the grant pipeline on its own.

## Membership Program

### **Membership Program in Salesforce**

The membership program for Protect Our Winters (POW) is fully customized in Salesforce to accommodate multiple types of activities that define membership. Standard NPSP membership fields and rollups are not used, as the definition of a "Team POW" member extends beyond donations to include advocacy, events, merchandise purchases, and more.

#### **Definition of Membership**

To be considered a current Team POW member, a constituent must have participated in one of the following activities within the last 365 days:

1.  **Donation**: Made a one-time or recurring donation (any Opportunity record type).
2.  **POW Opt-In**: Formally opted in to Team POW via the POW website (tracked through Formstack forms).
3.  **Partner Opt-In**: Formally opted in to Team POW through a partner website (e.g., Ikon, Aspen, etc., tracked through Formstack forms).
4.  **Merchandise**: Purchased POW merchandise (tracked through Opportunity records with the Merchandise record type).
5.  **Event**: Attended a POW-organized event (tracked through Blackthorn Event records).
6.  **Advocacy**: Participated in a Quorum campaign (tracked through Advocacy Campaign records).

#### **Membership Status**

Membership status is determined using a formula field based on the "Last Membership Date" field. A membership is considered "Current" if the "Last Membership Date" is within the past 365 days. Otherwise, the status is updated to "Expired."

**Formula:**

IF(

  ISBLANK(Last\_Membership\_Date\_v2\_\_c),

  NULL,

  IF(

    Last\_Membership\_Date\_v2\_\_c \>= TODAY() - 365,

    "Current",

    "Expired"

  )

)

  

**Criteria or Automations:****  
**The formula field on the "Membership Status" field automatically updates based on changes to the "Last Membership Date" field.

#### **Membership Actions**

The following actions qualify as membership interactions and are automatically tracked in Salesforce:

1.  **Donation**: Tracked via Opportunity records.
2.  **POW Opt-In**: Tracked via Formstack submissions.
3.  **Partner Opt-In**: Tracked via Formstack submissions from partner websites.
4.  **Merchandise**: Tracked via Opportunity records with the Merchandise record type.
5.  **Event**: Tracked via Blackthorn Event attendance records.
6.  **Advocacy**: Tracked via Quorum campaign interactions.

Membership-related fields are populated through automations, further detailed in the **Automation for Memberships** section.

#### **Membership Metrics**

The following metrics are tracked for each constituent:

  - **Membership Status**: Indicates whether the membership is Current or Expired (based on "Last Membership Date").
  - **Member ID**: The Salesforce Contact ID, uniquely identifying each member.
  - **Membership Join Date**: The date of the first membership action.
  - **Membership Opt-Out**: Indicates whether the contact has opted out of membership.
  - **Last Membership Date**: The date of the most recent membership action.
  - **Membership End Date**: Calculated as 365 days after the last membership action.
  - **Initial Entry Point**: The first membership action taken, with values including Donation, Advocacy, Event, etc.
  - **Most Recent Entry Point**: The latest membership action, reflecting the same value set as Initial Entry Point.

These metrics are displayed on the Contact record and are calculated via custom Flows.

**Automation for Memberships**

Membership details are maintained and updated through five custom Flows:

1.  **Membership Flow - Campaign Membership Type**: Sets the "Membership Campaign Type" field on Campaigns to either Donation (Classy campaigns), Advocacy Action (P2A campaigns), or Event Attendee (Blackthorn campaigns).
2.  **Membership Flow - Campaigns (P2A/Opt-In)**: Updates the entry point fields on Contacts to "Advocacy" and updates membership dates.
3.  **Membership Flow - Event Attendee**: Updates entry point fields on Contacts to "Event Attendee" and membership dates.
4.  **Membership Flow - Opportunities (Donations/Merchandise)**: Updates entry point fields on Contacts to either "Donation" or "Merchandise" and updates membership dates.
5.  **Membership Flow - Opportunities (Soft Credits)**: Updates membership fields if a Contact receives a soft credit for a donation.

These automations ensure seamless rollups of membership actions and maintain accurate data on Contacts.

#### **Reporting on Memberships**

POW uses a **Membership Dashboard** to track key membership metrics, including:

  - Membership growth trends.
  - Renewal rates for Current members.
  - Churn rates (members who transition from Current to Expired).

This dashboard provides a comprehensive view of membership performance and trends.

## Custom Automation

  - ### Workflow Rules
      
    1.  **\*\*Account Partner/Org Stage - Current:\*\* When an organization has donated within the last 365 days, they will be marked as current**
    2.  **\*\*Account Foundation Stage - Lapsed:\*\* When an organization account hasn't donated in greater than 365 days but less than 730 days, this workflow changes the account stage to Lapsed**
    3.  **\*\*Account Foundation Stage - Lost:\*\* A foundation account's stage will change to lost after not donating for over 730 days**
    4.  **\*\*Account Partner Stage - Lapsed:\*\* When a partner account hasn't donated in greater than 365 days but less than 730 days, this workflow changes the account stage to Lapsed**
    5.  **\*\*Account Partner Stage - Lost:\*\* A partner account's stage will change to lost after not donating for over 730 days**
    6.  **\*\*Alliance Member One Year Anniversary\*\***
    7.  **\*\*Partner Contract Expiring:\*\* When a partnership’s renewal date is within the next 30 days, this workflow triggers a task to the account owner of that partner.** 
    8.  **\*\*Capitalization of Name:\*\* Capitalizes first and last name on a contact**
    9.  **\*\*Case - Media Requests:\*\* Assigns the case to related user and sends an email alert to the user.**
    10. **\*\*Case - Memberships:\*\* Assigns the case to related user and sends an email alert to the user.**
    11. **\*\*Case - Partnerships:\*\* Assigns the case to related user and sends an email alert to the user.**
    12. **\*\*Case - Events and Fundraising:\*\* Assigns the case to related user and sends an email alert to the user.**
    13. **\*\*Case - POW International:\*\* Assigns the case to related user and sends an email alert to the user.**
    14. **\*\*Case - Merchandise:\*\* Assigns the case to related user and sends an email alert to the user.**
    15. **\*\*Case - Donor Relations:\*\* Assigns the case to related user and sends an email alert to the user.**
    16. **\*\*Case - Other:\*\* Assigns the case to related user and sends an email alert to the user.**
    17. **\*\*KnowWho Contact No email list:\*\* Removes any KnowWho contacts from POW and POW AF email lists (POW = No and POW AF = No on the contact)**
  - ### Process Builders
      
    1.  **DS data transfer from Leads to Accounts and Contacts after conversion:** DS data transfer from Leads to Accounts and Contacts after conversion
  - ### Flows
      
    1.  **\*\*Account: Bypass Dupe Rule Scheduled Flow:\*\* Runs daily to find and revert accounts that have duplication rule exemption.**
    2.  **\*\*Account - Update Billing State:\*\* Updates billing state based on zip code. Optimized Flow for fast field Updates (before-save). Includes duplicate rule workaround checkbox. International exemption criteria included.**
    3.  **\*\*Alliance Registration Email Alert:\*\* Sends an email alert to the alliance group captain when a new alliance member is added** 
    4.  **\*\*Campaign Member Status:\*\* Sets campaign member status for Event Attendee campaign types. Campaign member statuses are ‘To Invite’, ‘Invited’, and ‘Registered’**
    5.  **\*\*Campaign Flow:\*\* Sets OKR type on the campaign record to either ‘Fundraise’, if the campaign is a Classy campaign, or ‘Mobilize’, if the campaign is a Quorum campaign**
    6.  **\*\*Classy Recurring Donations Main Flow:\*\* Creates a task assigned to a user if a recurring donation amount is changed. This flow also will change ‘Pledged’ recurring donations/opportunities to ‘Closed Lost’ if the recurring donation is no longer active.**
    7.  **\*\*Contact Stages - v2:\*\* Updates contact stages to either ‘Current’ or ‘Lasped’. Current = Donated within the last 18 months and ‘Lasped’ if the contacts last donation is greater than 18 months ago.** 
    8.  **\*\*Contact - Update State from Zip Code:\*\* Updates the contacts Zip Code based on their State if they don’t have any other address information**
    9.  **\*\*Data Retention Policy - Contact Archive Scheduled Flow:\*\* Sets ‘Archived’ = TRUE based on POW’s Data Retention Policy**
    10. **\*\*Engagement Record Creation:\*\* Creates the engagement record and links its ID back to the contact, so touch points can be counted per constituent** 
    11. **\*\*Engagement - Attendee:\*\* When someone attends an event, records the engagement and notes whether the attendee is an Alliance member**
    12. **\*\*Engagement - Emails:\*\* Links logged email activity to the contact's engagement record**
    13. **\*\*Engagement - Campaign Member:\*\* Adds campaign participation to the contact's engagement counts**
    14. **\*\*Grant Tasks:\*\* Creates a reminder task 28 days before a grant opportunity's close date so reporting deadlines are met**
    15. **\*\*Membership Flow - Campaign Membership Type:\*\* Sets the Membership Campaign Type on campaigns (Donation for Classy, Advocacy Action for CiviClick/P2A, Event Attendee for Blackthorn)**
    16. **\*\*Membership Flow - Event Attendee 2:\*\* Marks event attendance as a membership action and updates the contact's membership entry point and dates**
    17. **\*\*Membership Flow - Campaigns (P2A/Opt In) 2:\*\* Marks advocacy actions and opt-ins as membership actions and updates membership dates**
    18. **\*\*Membership Flow - Opportunities (Donations/Merchandise) 3:\*\* Marks donations and merchandise purchases as membership actions and updates membership dates**
    19. **\*\*Membership Flow - Opportunities (Soft Credits):\*\* Extends membership when a contact receives soft credit for a gift**
    20. **\*\*POW Opportunity Flow:\*\* Post-save opportunity processing (task assignment and field updates on qualifying gifts)**
    21. **\*\*Recurring Donor Level Task - 30 or 90 Days:\*\* Creates recurring-donor stewardship check-in tasks at 30 or 90 days since the last touch**

  - ### Apex Triggers

    The org has three Apex triggers, all auto-generated by the rollup engine to keep engagement counts current (campaign members, tasks, and event attendees). There is no hand-written trigger logic — automation is built declaratively in Flows.

  - ### Automation Dependencies

    Three things to know before asking for automation changes:

    1.  **The five Membership Flows work as a set.** Each entry point (donations, events, advocacy, opt-ins, soft credits) updates the same membership fields — a change to one flow is always reviewed against the other four so membership status stays accurate org-wide.
    2.  **NPSP runs its own automation** on contacts, accounts, donations, and campaigns (household management, giving rollups, payments). Custom automation is added through Resin so it cooperates with NPSP rather than fighting it.
    3.  **Calculated fields recalculate.** Giving totals, engagement counts, membership dates, and stage fields are maintained by automation — hand edits to them are overwritten on the next run.

## Custom Integrations

  

# **Higher Logic Integration (POW Connected)**

## **Overview**

**POW Connected** ([pow.connectedcommunity.org](https://pow.connectedcommunity.org)) is POW's online community platform, hosted by **Higher Logic**. A custom-built, real-time integration pushes community activity from Higher Logic into Salesforce so that chapters, community members, and community events are visible in the CRM alongside all other constituent data.

The sync is **one-way (Higher Logic → Salesforce)** and event-driven: whenever certain activities happen in POW Connected, Higher Logic immediately sends a webhook notification to Salesforce, which processes it within seconds.

|  |  |
| :-: | :-: |
| Higher Logic activity | Salesforce result  |
| A community (chapter) is created | \*\*Account\*\* with record type \*Higher Logic Community\* |
| A user account is created | \*\*Contact\*\* (matched to an existing Contact when possible) |
| A user joins a community | \*\*Affiliation\*\* between the Contact and the community Account |
| A community event is created | \*\*Campaign\*\* with record type \*Event\*, plus a Blackthorn \*\*Event Partner\*\* linking the hosting community's Account |
| A user registers for an event | \*\*Campaign Member\*\* with status \*Registered\* |
| A user attends an event | \*\*Campaign Member\*\* with status \*Attended\* |

## **Architecture**

1.  **Higher Logic** is configured (Settings → External Content → Activity Sync, provider type *Webhook Activity POST*) to POST a JSON payload to Salesforce for subscribed activity types.
2.  The payload arrives at a **public Salesforce Site endpoint**: https://pow.my.salesforce-sites.com/higherlogic/services/apexrest/higherlogic/activity  
    (note the higherlogic Site path prefix — the same path without the prefix belongs to a different Site whose guest user has no access to this webhook and returns 403)
3.  The Apex REST class HigherLogicActivityWebhook validates the body, reads two fields — ActivityCode and ObjectType — and decides which of five processing routes applies (or ignores the message).
4.  Processing happens **asynchronously** in a Queueable Apex job (HigherLogicActivityProcessor), so the webhook responds to Higher Logic quickly and record creation happens a few seconds later.

**Authentication:** the endpoint is deliberately unauthenticated — Higher Logic's webhook sender does not support custom auth headers. The endpoint runs as the Site Guest User in system mode. Higher Logic sends from outbound IP 184.72.108.89 if IP restriction is ever desired. A Shared\_Secret\_\_c config field exists but is reserved for future use.

**Source code:** GitHub repo j-bouchard/protectourwinters-higherlogic (SFDX project, includes Apex tests).

## **Route decision logic**

Matching on ActivityCode (and sometimes ObjectType) is case-insensitive:

|  |  |  |
| :-: | :-: | :-: |
| \\\# | Route | Triggers when  |
| 1 | Create Community Account | ActivityCode = communitycreate, OR contains create with ObjectType = community |
| 2 | Create User Contact | ActivityCode = contactcreate, OR contains create with ObjectType = contact |
| 3 | Join Community (Affiliation) | ActivityCode = communitymemberjoin/communityjoin, OR contains join with ObjectType = communitymember |
| 4 | Create Event Campaign | ActivityCode = eventcreate, OR contains create with ObjectType = calendarevent/event |
| 5a | Attend Event | ActivityCode contains attend |
| 5b | Register for Event | ActivityCode contains regist or rsvp |
| — | Ignore | Anything else (returns HTTP 200 "Ignored", nothing processed) |

Note: routes 5a/5b use loose contains matching because the exact Higher Logic ActivityCode strings for registration/attendance were not observable when the code was written. **\[TO VERIFY\]** When live register/attend payloads are captured (Site Guest User debug log, lines prefixed \[HL\]), record the actual ActivityCode values here.

## **Field mappings**

The processor reads each value from the first payload key present (listed in priority order below).

**Route 1 — Community → Account**

|  |  |  |
| :-: | :-: | :-: |
| Salesforce field | Source payload key(s) | Notes  |
| HL\\\_Community\\\_ID\\\_\\\_c | CommunityKey, CommunityId, CommunityID, CommunityGuid, CommunityGUID, Key | External ID; upsert key (re-sends update, never duplicate) |
| Name | CommunityName, CommunityTitle, Community, Name, Title | Defaults to "Higher Logic Community" if absent |
| RecordTypeId | — | \*Higher\\\_Logic\\\_Community\* record type (configurable) |

**Route 2 — User → Contact**

|  |  |  |
| :-: | :-: | :-: |
| Salesforce field | Source payload key(s) | Notes  |
| HL\\\_Contact\\\_ID\\\_\\\_c | ContributorKey, ContributorMemberKey, ContactKey, AgentContactKey, Key | External ID |
| Email + npe01\\\_\\\_HomeEmail\\\_\\\_c (Home Email) | pb\\\_emailaddress, Email, email, EmailAddress | Written to both fields |
| FirstName | pb\\\_firstname, FirstName, firstName, ContributorFirstName |   |
| LastName | pb\\\_lastname, LastName, lastName, ContributorLastName | Defaults to "HL User" if absent |
| Phone | pb\\\_phone1, Phone, phone |   |
| Mailing address fields | pb\\\_address1/pb\\\_city/pb\\\_state/pb\\\_postalcode/pb\\\_country (and standard-name variants) |   |

**Contact matching** (used by routes 2, 3, and 5) checks in priority order and updates the first match instead of creating a duplicate: 1. HL\_Contact\_ID\_\_c (Higher Logic's user key) 2. npe01\_\_HomeEmail\_\_c (Home Email) 3. Email (standard/preferred email)

When a match is found, non-blank incoming values overwrite the existing Contact's name, phone, email, and mailing address; blank values leave existing data untouched.

**Route 3 — Join → Affiliation**

Finds the Account by HL\_Community\_ID\_\_c and the Contact via the matching logic above (creating the Contact from the payload if no match). Creates an npe5\_\_Affiliation\_\_c linking them, skipping if one already exists. If the community Account doesn't exist yet, the join is logged and skipped. **\[TO VERIFY\]** Affiliation role/status fields are left blank — confirm whether a role value (e.g. "Community Member") should be set.

**Route 4 — Event → Campaign**

|  |  |  |
| :-: | :-: | :-: |
| Salesforce field | Source payload key(s) / value | Notes  |
| HL\\\_Event\\\_ID\\\_\\\_c | EventKey, CalendarEventKey, Key | External ID; upsert key |
| Name | Title, EventTitle, Name | Defaults to "Higher Logic Event" |
| StartDate / EndDate | Date01/Date02, pb\\\_eventstart/pb\\\_eventend, StartDate/EndDate | Start defaults to today if unparseable |
| Description | ActivityDescription/Description + LinkUrl | Link appended as "HL Link: …" |
| RecordTypeId | — | \*Event\* record type (configurable) |
| Type / Status | — | Hardcoded "Event" / "Planned" |
| OKR\\\_Type\\\_\\\_c | — | Hardcoded "fundraise" \*\*\\\[TO VERIFY — see Known Limitations\\\]\*\* |
| HL\\\_Event\\\_Type\\\_\\\_c | — | Hardcoded "Chapter Meeting" |
| Host\\\_\\\_c | — | Hardcoded "Community Hosted" |

Side effects: seeds *Registered* and *Attended* Campaign Member statuses on the new Campaign, and creates a Blackthorn Event Partner (conference360\_\_Sponsor\_\_c) linking the hosting community's Account to the Campaign (skipped if the community Account isn't in Salesforce yet).

**Route 5 — Register / Attend → Campaign Member**

Finds the Campaign by HL\_Event\_ID\_\_c (from EventKey, CalendarEventKey, ParentKey, or Key) and the Contact via the matching logic (creating one if needed). Creates or updates a Campaign Member with status *Registered* or *Attended*. A member already marked *Attended* is never downgraded back to *Registered*. If the Campaign doesn't exist (registration arrives before the event was synced), the message is logged and skipped.

## **Configuration**

  - **Custom metadata:** HL\_Webhook\_Config\_\_mdt, record Default:
  - Account\_RecordType\_DeveloperName\_\_c = Higher\_Logic\_Community
  - Campaign\_Event\_RecordType\_DeveloperName\_\_c = Event
  - Shared\_Secret\_\_c = (unused, reserved)
  - **Permission set:** *HL Integration Fields* — grants admins read/edit on the three HL external ID fields plus HL\_Event\_Type\_\_c. The integration itself runs in system mode and does not need it.
  - **Custom fields:** Account.HL\_Community\_ID\_\_c, Contact.HL\_Contact\_ID\_\_c, Campaign.HL\_Event\_ID\_\_c (all external IDs), Campaign.HL\_Event\_Type\_\_c.

## **Webhook responses**

|  |  |
| :-: | :-: |
| Response | Meaning  |
| 400 Missing body | Empty request body |
| 400 Invalid JSON | Body not parseable as JSON |
| 200 Ignored | Valid message, but activity type not handled |
| 200 OK: queued \\\<ROUTE\\\> | Message accepted; async job enqueued |
| 403 FORBIDDEN ("no access to Apex class") | Wrong Site URL (missing higherlogic prefix) or guest profile lost Apex class access |

## **Troubleshooting**

**Something didn't sync from POW Connected:** 1. Confirm the endpoint is live (safe — creates no data): curl -X POST -H "Content-Type: application/json" -d '' https://pow.my.salesforce-sites.com/higherlogic/services/apexrest/higherlogic/activity → expect Missing body (HTTP 400). A 403 or Site error page instead means the URL/prefix is wrong, the Site is down, or the Guest User profile lost access to the Apex classes. 2. Check for failed async jobs: Setup → **Apex Jobs**, or query AsyncApexJob for HigherLogicActivityProcessor with status *Failed* — the ExtendedStatus column shows the error. 3. Check whether the activity type is one Higher Logic actually sends the webhook for (subscription list is configured on the Higher Logic side under Settings → External Content → Activity Sync). 4. For deeper debugging, enable a debug log on the Site Guest User — all integration log lines are prefixed \[HL\], including the full raw payload of every incoming request. 5. A registration/attendance that arrives for an event not yet in Salesforce is skipped silently (see Route 5) — re-sending after the event exists will process normally.

**Who to contact:** Joe Bouchard (Resin LLC) — Salesforce admin and integration owner. Higher Logic platform support: support.higherlogic.com.

## **Known limitations & design notes**

1.  One-way sync only; nothing flows from Salesforce back to Higher Logic. Creates and updates sync; deletions do not.
2.  OKR\_Type\_\_c is set to lowercase fundraise on every HL event campaign. POW's OKR reporting elsewhere uses Fundraise/Mobilize — **\[TO VERIFY\]** confirm the picklist value and whether "fundraise" is the right OKR classification for community events at all.
3.  Every HL event is typed HL\_Event\_Type\_\_c = "Chapter Meeting" regardless of the actual event type.
4.  **Membership program interaction \[TO VERIFY\]:** Team POW membership flows count event attendance via Blackthorn attendee records. HL event attendance creates Campaign Members, not Blackthorn attendees — confirm whether attending an HL community event should count as a membership action, and if so, extend the membership flows.
5.  Route 5 ActivityCode matching is intentionally loose until real payloads are captured (see Route decision logic).
6.  Engagement score sync (HL → Salesforce) was scoped as a separate build — **\[TO VERIFY\]** current status; it is not part of this webhook integration.

  
  

# Shopify Integration 

## Overview

POW's merchandise store runs on Shopify (built and fulfilled by Brist, live since September 2025, replacing the former WooCommerce store). A custom-built, real-time integration pushes store activity from Shopify into Salesforce so that merchandise orders, buyers, and refunds appear in the CRM alongside all other constituent and giving data.

The sync is one-way (Shopify → Salesforce) and event-driven: whenever certain activities happen in the store, Shopify immediately sends a webhook notification to Salesforce, which processes it synchronously within seconds.

|  |  |
| :-: | :-: |
| Shopify activity | Salesforce result |
| An order is placed / paid / updated / fulfilled | Opportunity with record type \*Merchandise\* (stage Closed Won), plus Product records for each line item |
| An order is cancelled | The order's Opportunity moves to \*Closed Lost\* and cancellation fields are set |
| An order is deleted | The order's Opportunity and its Products are deleted |
| A customer is created / updated | Contact (matched to an existing Contact by email when possible) |
| A refund is issued | The order's Payment record is updated with the refund amount/items, and the refunded Product is flagged |
| A customer changes email marketing consent | The Contact's Email Opt Out setting is updated |

## Architecture

1.  Shopify is configured (Settings → Notifications → Webhooks) to POST a JSON payload to Salesforce for each subscribed order, customer, and refund event. \[TO VERIFY\] Confirm the exact list of subscribed webhook topics in the Shopify admin.
2.  The payload arrives at a public Salesforce Site endpoint (Site: *ShopifyIntegration*, path prefix *ShopifyWebhook*): https://protectourwinters.my.salesforce-sites.com/ShopifyWebhook/services/apexrest/shopify/
3.  The Apex REST class ShopifyOrderWebhook verifies the request signature, reads the X-Shopify-Topic header, and routes the message to the matching handler (or ignores it).
4.  Processing happens synchronously — the record is created/updated in the same request and Salesforce returns the result to Shopify immediately. (Unlike the Higher Logic integration, there is no asynchronous queue.)

Authentication: every request carries an X-Shopify-Hmac-Sha256 header, which the class verifies with HMAC-SHA256 against a shared secret stored in the Shopify\_Config\_\_c custom setting (Webhook\_Secret\_\_c). A request that fails verification is rejected with HTTP 401 and no records are touched. The shared secret must match the webhook signing secret configured in Shopify; if it is ever rotated, update it in both places.

Source code: GitHub repo j-bouchard/pow-shopify-salesforce (SFDX project, includes Apex tests and a field-mapping reference).

Health check: a companion class ShopifyPing answers GET .../services/apexrest/shopify/ping with pong. (Present in sandbox; not currently deployed to production.)

## Topic routing (decision logic)

Matching on the X-Shopify-Topic header is case-insensitive:

|  |  |  |
| :-: | :-: | :-: |
| Route | Triggers when topic is | Effect |
| Order → Opportunity | orders/create, orders/paid, orders/updated, orders/fulfilled | Upsert Contact + Opportunity + Product line items |
| Cancel | orders/cancelled | Same upsert, but Opportunity → \*Closed Lost\* with cancel fields set |
| Delete | orders/delete | Delete the Opportunity and its Products |
| Customer → Contact | customers/create, customers/update | Upsert Contact |
| Consent | customers\\\_email\\\_marketing\\\_consent/update | Set Contact \*Email Opt Out\* |
| Refund | refunds/create, refunds/update | Update the Payment's refund fields + flag refunded Products |
| Ignore | anything else | Returns HTTP 200 "ignored", nothing processed |

## Field mappings

Records are matched (not duplicated) on external-ID fields, so the same order or line item always maps to the same Salesforce record.

Order → Opportunity (record type *Merchandise*; upsert key Shopify\_Order\_Id\_\_c)

|  |  |  |
| :-: | :-: | :-: |
| Salesforce field (Opportunity) | Shopify source | Notes |
| Shopify\\\_Order\\\_Id\\\_\\\_c | order id | External ID / match key |
| Name | order name | e.g. \\\#1023; falls back to "Shopify Order {id}" |
| Amount | order total\\\_price | Full total paid = subtotal + tax + shipping. Not reduced by refunds |
| StageName | — | \*Closed Won\* (\*Closed Lost\* if cancelled) |
| CloseDate | — | Date the webhook is processed |
| Fund\\\_Designation\\\_\\\_c | — | Set to \*POW\* |
| npsp\\\_\\\_Primary\\\_Contact\\\_\\\_c | order customer | The matched buyer Contact |
| Cancelled\\\_\\\_c / Cancelled\\\_At\\\_\\\_c / Cancel\\\_Reason\\\_\\\_c | cancelled\\\_at, cancel\\\_reason | Set only on cancellation |

Order line items → Product (upsert key Shopify\_Order\_Line\_Item\_Id\_\_c)

|  |  |  |
| :-: | :-: | :-: |
| Salesforce field (Product2) | Shopify source | Notes |
| Shopify\\\_Order\\\_Line\\\_Item\\\_Id\\\_\\\_c | line item id | External ID / match key |
| Name | line item title | Product name |
| ProductCode | line item sku | SKU |
| Opportunity\\\_\\\_c | — | Links the product to its order |
| Refunded\\\_\\\_c | (set by refund event) | Flagged true if that SKU is refunded |

Customer → Contact (matched by Email; existing Contact updated, otherwise created)

|  |  |  |
| :-: | :-: | :-: |
| Salesforce field (Contact) | Shopify source | Notes |
| Email | email / contact\\\_email | Match key |
| FirstName / LastName | first\\\_name / last\\\_name | LastName defaults to "Shopify Customer" if blank |
| Phone | phone | From customer webhooks |
| Mailing address fields | default\\\_address.address1 / city / zip / province\\\_code / country\\\_code | Falls back to full state/country names when codes are absent |

Refund → Payment + Product

|  |  |  |
| :-: | :-: | :-: |
| Salesforce field | Shopify source | Notes |
| npe01\\\_\\\_OppPayment\\\_\\\_c.Refund\\\_Amount\\\_\\\_c | refund transactions\\\[\\\].amount (kind = refund) | Summed and added to any existing refund total |
| npe01\\\_\\\_OppPayment\\\_\\\_c.Refunded\\\_Items\\\_\\\_c | refund refund\\\_line\\\_items\\\[\\\].line\\\_item.title/sku | Readable list of refunded items, appended |
| Product2.Refunded\\\_\\\_c | refund refund\\\_line\\\_items\\\[\\\].line\\\_item.sku | Matches the order's Products by SKU |

Email marketing consent → Contact

|  |  |  |
| :-: | :-: | :-: |
| Salesforce field | Shopify source | Notes |
| Contact.HasOptedOutOfEmail | email\\\_marketing\\\_consent.state | \*subscribed\* → opted in (false); anything else → opted out (true) |

## Reporting notes (important for finance)

  - The Opportunity Amount is gross — Shopify's total\_price, including tax and shipping — and is not reduced when an order is refunded. Refunds are recorded separately on the order's Payment record (Refund\_Amount\_\_c). To report *net* merchandise revenue, subtract Refund\_Amount\_\_c from Amount (or report on Payments).
  - A refund does not change the Opportunity stage — it stays *Closed Won*. Only a cancellation moves it to *Closed Lost*. This is deliberate, so historical/closed-period revenue is preserved.
  - All merchandise orders carry Fund\_Designation\_\_c = POW and the *Merchandise* record type, which is how they are separated from donations in reports.

## Monitoring / how to confirm it's running

The integration is healthy whenever new merchandise Opportunities keep appearing. To check, run a report (or SOQL) for Opportunities where Shopify\_Order\_Id\_\_c is not blank, sorted by Created Date — the newest record should be recent.

*As of 2026-08-10: live and processing normally — \~234 orders in the trailing 30 days, 2,567 orders total since go-live on 2025-09-23, with no gaps.*

  
  

### Integration Reference (Tools, Data Flow, and Sync Frequency)

The table below summarizes every integration touching Salesforce, which direction data flows, how often, and what to check first when something looks wrong.

| Tool | What it does | Direction | Frequency | If it looks wrong, check first |
|---|---|---|---|---|
| Classy (Classy for NPSP) | Online fundraising — donations and recurring giving | Classy → Salesforce | Near real-time | The Classy campaign/opportunity record; then ask Resin to check the sync log |
| Blackthorn Events | Event management, ticketing, attendee tracking | Inside Salesforce (payments via Stripe) | Real-time | The Event and Attendee records; attendance status drives membership and training metrics |
| Mailchimp (via Cazoomi SyncApps) | Email marketing audience sync | Salesforce → Mailchimp (audience), Mailchimp → Salesforce (bounce data) | Scheduled batches | Whether the contact has POW = Yes and Email Opt Out unchecked — that pair controls audience membership |
| Formstack | Donor, event, and Team POW opt-in forms | Formstack → Salesforce | Real-time | The Form Submission record on the contact |
| Shopify | Merchandise store (replaced WooCommerce, Sept 2025) | Shopify → Salesforce | Real-time (webhook) | The Merchandise opportunity and its Order ID; see the Shopify Integration chapter |
| Higher Logic (POW Connected) | Online community platform | Higher Logic → Salesforce | Real-time (webhook) | See the Higher Logic Integration chapter's troubleshooting section |
| CiviClick | Advocacy actions (replaced Quorum, Jan 2026) | CiviClick → Salesforce | Real-time (webhook) | The advocacy campaign and campaign member records |
| DonorSearch 360io | Wealth screening | DonorSearch → Salesforce | On screening runs | DS fields on the contact/account |
| 360MatchPro | Corporate matching gifts | 360MatchPro → Salesforce | As matches occur | Matching Gift opportunities |
| Cloudingo | Duplicate merging and scheduled data-retention deletes | Works on Salesforce data | Weekly schedules | Ask Resin — merge and delete filters are managed there |
| Gmail Extension | Logs staff email to constituent records | Gmail → Salesforce | As staff log emails | Whether the email was logged from the extension |
| Google Ads | Lead capture from ad campaigns | Google Ads → Salesforce | Real-time | The Lead record and its source fields |
| KnowWho | Legislator contact data | KnowWho → Salesforce | Sync active | Note: the Data Governance Committee is deciding this dataset's future (2026) |

**Integration patterns:** the modern integrations (Shopify, Higher Logic, CiviClick, Google Ads) use real-time webhooks — custom code in Salesforce receives each event within seconds. The older integrations (Classy, Mailchimp, DonorSearch) use scheduled or vendor-managed syncs. No integration deletes Salesforce data except Cloudingo's retention filters, which are governed by the Data Retention Policy.

## Custom Reports and Dashboards

Salesforce reports answer "how are we doing?" questions from live data; dashboards collect the most important reports into a single view. This chapter maps the dashboards and reports staff use most, and how to get a new one.

### Key Dashboards

| Dashboard | Folder | What it answers |
|---|---|---|
| **POW Development Forecasting** | Development | Forward-looking revenue: expected donations and progress toward fundraising goals |
| **POW Development Analysis** | Development | Historical giving: trends, donor retention, campaign and event performance |
| **Membership Dashboard** | Memberships | Team POW growth, renewal, and churn |
| **Alliance OKRs — Leadership View** | Organizational Health Dashboards | Leadership's view of alliance training and engagement against 2026 OKRs (total trainings, alliance members trained/engaged) |
| **Alliance Dashboard / Alliance Engagement OKRs / Alliance User Journey** | Programs | Day-to-day alliance program tracking: engagement, graduates, member journeys |

### Key Reports

- **Donation reports** live in the Development folders — giving by record type, campaign, and time period, including recurring donation reports for Classy and GoFundMe. Reports comparing this year's donors to last year's (the classic LYBUNT/SYBUNT retention views) are built on the standard NPSP giving fields.
- **OKR reports** live in the "2025-2029 Objectives and Key Results" folder — for example, *Training to 150+ Alliance Members 2026* counts alliance members who attended events tagged as trainings or summits.
- **Alliance training reports** — *Alliance — Trainings* feeds the Leadership View dashboard; each 2026 Coaching Camp also has its own attendance report in the "2026 POW Alliance Coaching Camps" folder.
- **Data quality reports** — duplicate contact/account reports support the Cloudingo dedupe process.

### Custom Report Types

Report types define which objects and fields a report can use. The org has **38 custom report types**, grouped roughly as: Contacts & Accounts (9), Donations & Finance (7), Campaigns & Events (5), Forms & Submissions (6), Engagement (2), Data Quality (4), plus Alliance, Partnerships, Advocacy, and system types. If you can't build the report you need, the usual reason is that no report type joins the objects you want — ask Resin, adding one is quick.

### Getting a new report or dashboard

Describe the question you're trying to answer (not the report layout) in a request to Resin — most reports are turned around within a support cycle. Staff with report-builder access can also clone any existing report and adjust filters; save personal experiments to your private folder so shared folders stay curated.

## Security and Access Control

Who can see and edit what. Access is layered: your **profile** sets your baseline, your **role** determines whose records you can see, and **permission sets** add specific extra abilities on top.

### Profiles

Staff profiles mirror departments: Executive Management, Fundraising and Development, Comms and Marketing, Program Staff, Advocacy, and Partnerships, plus admin profiles (held by Resin and designated staff). Alliance team captains use dedicated Alliance Captain profiles with focused access to alliance member records. A set of integration-only profiles (Shopify, CiviClick, sync users, and similar) exists for the automated connections described in the Integrations chapters — no person logs in with those.

### Roles

The role hierarchy mirrors the org chart — CEO at the top, then COO / VP Campaigns / VP Development / VP Marketing & Communications branches, each with their directors, managers, and coordinators, plus a Team Captains branch (Bike, Climb, Creative, Run, Science, Ski, Snowboard). Managers can see the records their teams own; peers in different branches don't automatically see each other's private records.

### Sharing Rules

Most day-to-day data (contacts, donations, campaigns) is broadly visible to staff — the org favors openness so departments can see the whole constituent picture. The exceptions are managed through record types and layouts rather than heavy sharing restrictions: for example, Alliance Member contacts have a dedicated permission set that both grants access and **prevents changing a contact's Alliance record type** — that guardrail protects alliance data from accidental re-typing.

### Permission Sets

| Permission set | Grants |
|---|---|
| View Donations | Read-only access to donations, payments, and recurring donations |
| View and Edit Donations | Create/edit donations and recurring donations |
| View and Edit Donations & Payments | The above plus payment records and accounting allocations |
| Alliance Record Type Access | Visibility into Alliance Member contacts |
| Alliance Record Type — Prevention of Change | Blocks changing a contact's Alliance record type |
| Case Full Access | Full case management (used by the departments that work queues) |
| Batch Gift Entry | NPSP batch gift entry for high-volume donation entry |
| MFA / No MFA | Controls multi-factor authentication requirements per user |

The **Communications queue** (memberships@protectourwinters.org) routes membership cases to the staff who work them.

### Requesting access changes

Access changes (new user, department move, extra permissions, offboarding) go through Resin. Say what the person needs to *do* — the right profile/permission-set combination follows from that. Offboarding requests should come in promptly; deactivating a user never deletes their historical records.

## Data Management

### Data Import & Export Processes

**Most records arrive through integrations** — Classy, Formstack, Shopify, Blackthorn, CiviClick, and Higher Logic create and update the bulk of constituent data automatically. Manual imports (event lists, sign-on CSVs, sweepstakes entries) are the exception and follow a standard playbook:

1. Confirm the target campaign exists before importing campaign members.
2. **Match by email against existing contacts and leads first** — importing without matching creates duplicates that the dedupe process then has to merge.
3. Bring address columns along when the source has them — incomplete addresses are the org's most persistent data-quality gap; don't add to it.
4. Be deliberate about the POW field: POW = Yes puts the person in the Mailchimp audience.
5. Set campaign member status explicitly (To Invite / Invited / Registered / Attended / Responded depending on campaign type).

Large or unusual imports should go through Resin. **Exports:** the L2 voter dataset is the archival model — the master data lives in Google Drive, with only actively-linked records kept in Salesforce. The same export-to-Drive pattern applies to any dataset the Data Governance Committee decides to archive.

### Data Validation Rules

The org runs deliberately light on hard validation — one active validation rule exists (on Partnership Deliverables, requiring either a POW Deliverable or a Partner Action, not both). Data quality is instead enforced by automation (state/zip auto-population, name capitalization, country normalization), duplicate rules, and the Cloudingo dedupe process. This keeps fast-moving integration data flowing without validation errors, at the cost of relying on downstream cleanup — the trade-off is a standing Data Governance Committee topic (see the address-completeness watch item in the committee's health snapshots).

### Data Retention Policy

**Purpose****  
****  
**The purpose of this data retention policy is to establish clear guidelines for the storage, archiving, and deletion of data within Salesforce and related systems. This policy ensures compliance with operational needs, minimizes storage costs, and enhances data management efficiency.

**Data Retention Guidelines**

**1. Contact Records**

  - **Retention Period:** Retain indefinitely unless marked as 'Archived' based on specific criteria.
  - **Archival or Deletion Criteria:**
      
      - Mark contacts as 'Archived' if they meet **all** the following conditions:
          
          - No gifts
          - No affiliations
          - Email opt-out = true
          - Not an Alliance member
          - Not a Team POW member
          - No advocacy actions
          - Hasn’t attended an event
          - Created date is greater than three years ago

**2. Campaign Records and Campaign Members**

  - **Retention Period:**
      
      - Retain active campaigns indefinitely unless they meet specific criteria for deletion.
  - **Archival or Deletion Criteria:**
      
      - Campaigns with no contacts and created more than 90 days ago will be deleted, **excluding the following types of campaigns:**
          
          - Event-related campaigns.
          - Classy campaigns.
          - Phone2Action campaigns.
      - **No campaign members will be deleted.**
  - **Campaign Owner Responsibility:**
      
      - Campaign owners are responsible for regularly reviewing and cleaning up their campaigns if they are no longer needed.

**3. Email Activity**

  - **Mailchimp Activity Data:**
      
      - Retain Mailchimp email activity data (e.g., received, opened, clicked) **in the activity pane on the contact record for 30 days.**
      - All email activity data older than 30 days will be deleted.
      - **Retention Applies to All Contacts:** This includes Alliance members.
  - **Gmail Messages:**
      
      - Gmail messages will never be deleted.

**4. Form Submissions**

  - **Retention Period:** Retain Formstack submissions for up to three years.
  - **Archival or Deletion Criteria:**
      
      - Delete Formstack submissions older than three years, **excluding Alliance forms.**
      - This deletion policy does not affect any data tied to a contact record. For example:
          
          - If a contact signs up for Team POW through a form, all submitted data (e.g., address, email) will remain on the contact record, but the actual form submission will be deleted.

**Retention of Other Data**

Unless otherwise specified in this policy, **all other data is retained indefinitely** to ensure data integrity, compliance, and support for ongoing organizational needs.

**Processes for Maintaining Guidelines**

**Contacts**

  - A **scheduled flow** runs once a week in Salesforce to identify contacts that meet the archival criteria.
  - The flow automatically **checks the 'Archived' checkbox** for these contacts.

**Campaigns**

  - A **delete filter in Cloudingo** identifies campaigns that meet the deletion criteria.
  - Campaigns fitting these criteria are automatically deleted **90 days after their creation date.**

**Mailchimp Activity**

  - A **delete filter in Cloudingo** automates the removal of Mailchimp email activity older than 30 days.

**Form Submissions**

  - A **delete filter in Cloudingo** automates the removal of Formstack submissions older than three years, except for those associated with Alliance forms.

**Implementation and Oversight**

**1. Data Review Schedule**

  - Conduct quarterly data reviews to ensure adherence to retention guidelines.
  - Review archived data annually to determine if further action (e.g., deletion) is needed.

**2. Storage Solutions**

  - Use Salesforce for active data critical to daily operations.
  - Move archival data to cost-effective solutions like AWS S3, Google Drive, or a data lake for long-term storage.

**3. Stakeholder Involvement**

  - Collaborate with department leads to identify high-priority data for retention.
  - Establish a cross-functional data governance committee to monitor and enforce this policy.

**Policy Review**

This policy will be reviewed annually to align with evolving organizational needs and technical capabilities. Adjustments will be made as necessary to maintain data quality and operational efficiency.

### Duplicate Management Strategy

Effective data management is crucial for maintaining the integrity of our Salesforce system. Duplicate management plays a key role in ensuring that our data remains accurate and clean. Below is an outline of the tools and strategies we use to prevent and manage duplicate records.

#### Duplicate Rules in Salesforce

Duplicate rules help detect and manage potential duplicate records during data entry or updates. These rules trigger alerts or take actions when records with similar information are identified.

**Contact Duplicate Rules:**

  - **POW Contact - Email Only:** This rule matches on exact email only. It is designed to catch duplicate contacts based solely on the email address.
  - **NPSP Contact Personal Email Match:** This rule identifies duplicates based on a fuzzy match for first name, an exact match for last name, and an exact match for personal email. It’s particularly useful for managing personal email variations.
  - **Contact Address:** This rule is set up to catch duplicates based on an exact match for last name and mailing state, a fuzzy match for first name and mailing city, and an exact match for mailing zip. It helps identify potential duplicates based on partial address information.
  - **Contact Phone:** This rule matches on an exact mobile phone number, along with exact matches for first name and last name, ensuring duplicate contacts are flagged if phone numbers and names align.

**Account Duplicate Rule:**

  - **POW Account:** We use the Salesforce **Standard Account Matching Rule**, which compares account name and billing address to identify duplicates. This rule looks for an exact match on account name and a fuzzy match on billing street address to account for minor variations like abbreviations or misspellings in account names and addresses.

#### Matching Rules in Salesforce

Matching rules are the foundation that support duplicate rules by defining how Salesforce compares records to identify potential duplicates. They specify which fields to compare and whether to apply exact or fuzzy matching criteria.

Matching rules and duplicate rules work together in Salesforce to prevent and manage duplicates. Matching rules determine how records are compared—whether through strict exact matches or more flexible fuzzy matches. These rules are linked to duplicate rules, which then act on the identified duplicates. When a duplicate rule is triggered, it checks records based on the criteria set by the matching rule and either alerts the user, blocks the record creation, or allows the user to decide on further action.

#### Cloudingo

Cloudingo provides advanced duplicate management functionality and integrates with Salesforce. It allows us to automate duplicate checks, apply custom filters, and manually review potential duplicates. Cloudingo's filters are designed to match our Salesforce duplicate and matching rules, maintaining consistency across platforms.

We run duplicate merges on a weekly basis using Cloudingo, based on the following criteria. All KnowWho contacts and Alliance contacts are not included:

  - **Contact (Email + Full Name):** This filter runs weekly and merges contacts that have an exact match on email, an exact match on last name, and a fuzzy match on first name. This process excludes KnowWho contacts and Alliance members to ensure specific records are not impacted by automatic merges.
  - **\*\*Contact Personal and Alternate Email Cross Match:\*\* This filter runs weekly and merges contacts that have an exact match between personal email and alternate email.**
  - **\*\*Contact Personal and Work Email Cross Match:\*\* This filter runs weekly and merges contacts that have an exact match between personal email and work email.**
  - **\*\*Contact Work and Alternate Email Cross Match:\*\* This filter runs weekly and merges contacts that have an exact match between alternate email and work email.**
  - **\*\*Contact (Phone Number & exact name):\*\* This filter does not run automatically. If run, it will merge contacts that have an exact match on phone number and full name.**
  - **Contact Full Name + Address:** This filter does not run automatically. If run, it will merge contacts that have an exact match on address and full name.
  - **\*\*Account Full Name + Address:\*\* This filter does not run automatically. If run, it will merge accounts with an exact match on account name and billing address**

<!-- end list -->


## Engagement and Communication

### Email Templates

Mass email lives in **Mailchimp**, not Salesforce — audience membership is driven by the POW and POW Action Fund fields on the contact, and campaign content/templates are built in Mailchimp. Inside Salesforce, email templates power the automated notifications: case routing alerts to department owners, the partner contract expiration notice, alliance registration alerts to team captains, and volunteer signup/thank-you emails.

### Campaigns and Campaign Hierarchies

Campaigns track every outreach activity — emails, fundraisers, events, advocacy actions, direct mail. The naming convention is:

> **[Launch Date] [Name of Activity] [Type of Activity]** — e.g. "2026-06 Coaching Camp Truckee Event"

Parent campaigns group related child campaigns (an event series, a multi-channel appeal) so results roll up. Campaign types that matter to automation: **Classy** campaigns count as fundraising, **CiviClick/Phone2Action** campaigns count as advocacy actions (and toward Team POW membership), **Blackthorn event** campaigns track attendance. The OKR Type field (Recruit / Train / Mobilize / Fundraise / Support / Validation) ties campaigns to the strategic plan — set it when creating a campaign so OKR reporting stays complete.

### Engagement Plans and Levels

Two systems measure constituent depth:

- **Donor Levels** (NPSP Levels, based on 18-month giving): Ally under $1k → Advocate $1k–5k → Enthusiast $5k–10k → Champion $10k–25k → Titan over $25k. Assigned automatically; Previous Donor Level keeps the prior value.
- **Engagement records** track touch points per constituent — events attended, campaigns joined, trainings completed, invitations received. Automated rollups count these into totals used by the alliance and program dashboards. Staff don't edit engagement counts by hand; they update automatically from attendance and campaign membership.

### Custom Email Alerts and Automations

The alerts staff will notice: new **cases** are auto-assigned by category (Media, Memberships, Partnerships, Events & Fundraising, POW International, Merchandise, Donor Relations, Other) with an email to the owning department; **partner contract expiration** creates a task and alert 30 days before renewal; **alliance registrations** notify the relevant team captain; **stewardship tasks** are created automatically for notable gifts ($500–999 one-time gifts, recurring donor check-ins at 30/90 days, grant deadlines 28 days out). If you receive one of these alerts, it's yours to action — the automation stops at notifying you.

## User Training and Adoption

### Key User Roles and Responsibilities

- **Every staff member** owns the accuracy of records their work touches — log your constituent interactions, keep campaign membership current, and action the cases and tasks routed to you.
- **Department leads** own their case queues (Media, Memberships, Partnerships, Events & Fundraising, POW International, Merchandise, Donor Relations) and, through the Data Governance Committee, the quality of their department's data.
- **The Data Governance Committee** (department representatives plus the executive sponsor) decides data policy: retention, structure changes, and who owns which dataset.
- **Resin** administers the system: builds, fixes, integrations, access, and this manual.

### Training Materials

- **This manual** is the primary reference — it's searchable, and it's regenerated as the system changes, so it doesn't go stale.
- **Live training sessions** are scheduled with Resin as needed — onboarding a new hire, rolling out a new feature, or a refresher for a team. Ask via the support path below.
- **Trailhead** (Salesforce's free learning platform) covers general Salesforce skills; the NPSP trail is the best general-purpose supplement to this manual.

### User Guides for Specific Features

The process chapters of this manual are the feature guides: Donations Management, the Membership Program, the integration chapters (Higher Logic, Shopify), and Engagement and Communication each explain how staff work with that area day-to-day. Start with the chapter, then ask Resin if the answer isn't there — questions that come up repeatedly get folded back into the manual.

### Ongoing Support and Feedback Loops

- **Something's broken or confusing:** email Joe Bouchard (Resin) with what you were doing, what you expected, and what happened. Screenshots help.
- **Requesting a change or new feature:** send the business need (what you're trying to accomplish, not the technical solution) — it gets scoped, built, reviewed, and deployed through Resin's managed process.
- **Recurring forum:** the biweekly Resin check-in with the executive sponsor covers priorities; the Data Governance Committee handles policy-level decisions.

## System Maintenance and Governance

### How Changes Get Made (Release Management)

All configuration and code changes go through Resin's managed pipeline: each change is developed against a copy of the org, reviewed, tested, and only then deployed to production — with every change tracked in version control, so there is a complete history of what changed and when. NPSP and other managed packages are updated on Salesforce's release cadence; Resin monitors those upgrades. Staff should never make setup-level changes directly in production — request them instead, so the change is tested and recorded.

### Backup and Restore

- **Configuration** (fields, automation, layouts, code) is fully version-controlled by Resin — any configuration change can be traced and restored.
- **Deleted records** sit in the Salesforce Recycle Bin for 15 days and can be restored from there.
- **Archived data** follows the Data Retention Policy: contact records are flagged (never deleted), and datasets moved out of Salesforce (like L2 voter data) are retained in Google Drive.
- Gmail-logged emails are never deleted, and donor giving history is retained indefinitely.

### System Health Checks

- A **data health snapshot** (storage, record counts, opt-out trend, address completeness) is produced for the Data Governance Committee at least quarterly.
- **Storage** is actively monitored — data storage runs near its allocation, and retention/cleanup work is prioritized when it climbs.
- **Weekly automated jobs** keep data current: the contact archive flow (retention policy), contact stage recalculation, Cloudingo merges, and the duplicate-rule bypass reset.

### Audit Trail for Key Changes

Salesforce's Setup Audit Trail records the last 180 days of configuration changes and who made them; Resin's version control preserves the full change history beyond that. Record-level field history is enabled selectively — if your team needs history tracking on a specific field, request it (history starts from the day it's turned on, so it pays to enable it before you need it).

### Recent Changes (last 12 months)

| When | What changed |
|---|---|
| Aug 2026 | Data Retention Policy annual review; data health snapshot with storage remediation plan; duplicate rule review |
| Jun–Aug 2026 | 2026 Alliance Coaching Camps and Stoke Fest events built out in Blackthorn with OKR training tracking |
| Feb 2026 | End of Year Gift checkbox and Preferred Communication Method picklist added to Contact |
| Jan–Feb 2026 | CiviClick replaced Quorum for advocacy; Higher Logic (POW Connected) community integration went live |
| Sep 2025 | Shopify replaced WooCommerce for merchandise, with real-time order sync |

## Technical Debt and Cleanup

Every long-lived Salesforce org accumulates configuration that newer tools have superseded. Documenting it keeps it managed rather than mysterious. None of the items below affect day-to-day use; they're listed so the cleanup plan is visible.

### Overview of Existing Technical Debt

- **71 legacy Workflow Rules** (account/partner stages, case routing, name capitalization, contract expiry alerts, alliance prospect tracking). They work, but Salesforce has retired the Workflow Rules technology in favor of Flows — new automation is built as Flows, and the old rules are slated for migration.
- **One legacy Process Builder** (DonorSearch data transfer on lead conversion) — same retirement story.
- **Draft and obsolete Flows** — 8 drafts and 13 obsolete flows from past iterations remain in the org. Inactive, but scheduled for archival to reduce clutter and naming-collision risk.
- **A handful of dormant fields** — e.g., a legacy Alliance Training/Summit checkbox on events superseded by the OKR Alliance Training Type picklist, and some underused grant and partner contract fields. Candidates for consolidation.

### Plans for Reducing Technical Debt

| Item | Plan |
|---|---|
| Obsolete/draft Flow cleanup | Scheduled cleanup pass (Q4 2026) |
| Workflow Rules → Flow migration | Phased plan for 2027 — case routing and account-stage rules first |
| Dormant field consolidation | Reviewed alongside the migration, with committee sign-off on any field retirement |
| Storage (activity records) | Retention options being brought to the Data Governance Committee (see the retention policy's activity-records note) |

### Custom Code and Its Purpose

The org runs deliberately light on custom code — automation is built declaratively (Flows) wherever possible. The custom code that exists:

- **Integration webhooks:** Shopify order processing, CiviClick advocacy actions, Google Ads lead capture — the real-time receivers described in the Integrations chapters.
- **Community site controllers:** login, registration, and password pages for the constituent-facing site.
- **Rollup triggers:** three auto-generated triggers that power the engagement rollup counts (campaign members, tasks, event attendees).
- **A country-normalization batch job.**

All custom code has test coverage and changes only through the managed release process.

## Future Enhancements

The working roadmap, in rough priority order. Items marked *(decision pending)* are with the Data Governance Committee or leadership.

| Enhancement | Status |
|---|---|
| **Storage remediation** — retention options for activity records (the largest storage consumer), plus recycle-bin cleanup | Proposal to committee, Sept 2026 |
| **KnowWho dataset decision** — keep, archive to Drive, or drop, now that CiviClick is live | *(decision pending — Q3 2026 committee packet)* |
| **Alliance training rollup fix** — re-point the Leadership View dashboard's training tiles at the OKR training tags all 2026 camps already carry | Scoped, awaiting sign-off |
| **Address-quality improvement** — entry-point validation and/or enrichment to reverse the incomplete-address trend | Proposal after a data owner is named (OKR working session) |
| **Membership structure changes** — paid membership model, intake form, possible "Outdoor State" rebrand | *(decision pending — confirmed active or shelved in Q3 packet)* |
| **Higher Logic metrics buildout** — which community metrics to track in Salesforce | Awaiting POW requirements |
| **OKR tracking in Salesforce** — definitions, dashboards, and data owners for the 2026 plan | OKR working session output |
| **Workflow Rule → Flow migration** | 2027 planning |
| **Einstein / AI features** | Not currently planned; revisit as Salesforce's nonprofit AI offerings mature |

This manual is updated as items ship — see Recent Changes in the System Maintenance chapter.

## Appendix

### Glossary of Terms

| Term | Meaning |
|---|---|
| **NPSP** | Nonprofit Success Pack — Salesforce's free nonprofit foundation; provides households, donations, recurring gifts, and rollups |
| **Contact / Account** | A person / an organization (or household). NPSP creates a Household Account automatically for every contact |
| **Opportunity** | Any revenue record — donation, grant, event ticket, merchandise order, matching gift, or partner commitment (see record types) |
| **Record Type** | A variant of an object with its own picklists and layout — e.g., Contact: general vs. Alliance Member; Opportunity: Donation vs. Grant vs. Merchandise |
| **Campaign / Campaign Member** | An outreach activity / a person's connection to it (invited, registered, attended, responded) |
| **Flow** | Salesforce's automation tool — the "if this happens, do that" logic described in the Custom Automation chapter |
| **Workflow Rule** | The older generation of automation, still running for some legacy rules; being migrated to Flows |
| **Rollup** | An automatically calculated total (giving totals, engagement counts). Never edit rollup fields by hand — they recalculate and overwrite |
| **Soft Credit** | Credit for a gift someone influenced but didn't pay (e.g., a spouse's gift). NPSP tracks these alongside hard credits |
| **Archived (contact flag)** | Retention-policy marker for long-inactive, opted-out, non-donor contacts. Archived contacts are excluded from email and reporting defaults but never deleted |
| **Team POW membership** | POW's custom membership definition — any qualifying action (donation, opt-in, merch, event, advocacy) in the last 365 days. See the Membership Program chapter |
| **TDTM** | NPSP's trigger management framework — the reason custom automation on core objects is added carefully, through Resin |

### Useful Resources

- **NPSP documentation:** help.salesforce.com → Nonprofit Success Pack
- **Trailhead** (free Salesforce training): trailhead.salesforce.com — start with "Nonprofit Success Pack Basics"
- **Salesforce status** (is it down?): status.salesforce.com
- **This manual's companions:** the Data Retention Policy and the Data Governance Committee's health snapshots (Drive: DataGovernanceCommittee folder)

### Contact Information for Key Support

| Need | Contact |
|---|---|
| System administration, builds, fixes, access, training | **Joe Bouchard — Resin LLC** (joebouchard@resin.team) |
| Data governance policy and priorities | **Hannah Rennicke** (executive sponsor) and the Data Governance Committee department reps |
| Membership case inbox | memberships@protectourwinters.org (routes to the Communications queue) |
| Salesforce login/outage issues | Check status.salesforce.com, then Resin |
