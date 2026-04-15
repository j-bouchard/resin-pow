# POW Reports & Dashboards
Generated: 2026-04-15 | Org: protectourwinters.org

## Overview

Reports and dashboards were **not included** in the metadata retrieval. This is
common — Salesforce report/dashboard metadata is stored in folder-based structures
that often require explicit folder names in the package.xml rather than wildcards.

## Next Steps

To retrieve reports and dashboards, run these queries against the org to identify
folder names, then update the package.xml with specific folder references:

### Identify Report Folders
```bash
sf data query --query "SELECT Id, Name, DeveloperName, Type FROM Folder WHERE Type = 'Report' ORDER BY Name" --target-org production --json
```

### Identify Dashboard Folders
```bash
sf data query --query "SELECT Id, Name, DeveloperName, Type FROM Folder WHERE Type = 'Dashboard' ORDER BY Name" --target-org production --json
```

### List Reports
```bash
sf data query --query "SELECT Name, DeveloperName, FolderName, Description, Format FROM Report WHERE IsDeleted = false ORDER BY FolderName, Name" --target-org production --json
```

### List Dashboards
```bash
sf data query --query "SELECT Title, DeveloperName, FolderName, Description FROM Dashboard WHERE IsDeleted = false ORDER BY FolderName, Title" --target-org production --json
```

### Update package.xml
Once you have the folder names, add them as specific members:

```xml
<types>
    <members>FolderName1</members>
    <members>FolderName1/ReportName1</members>
    <members>FolderName2</members>
    <members>FolderName2/ReportName2</members>
    <name>Report</name>
</types>
```

Then re-run `sf project retrieve start --manifest package.xml -o production`.

## Note

This file will be updated with full report/dashboard inventory after the next
`/snapshot-org` run with org query access. The metadata retrieval captures
report *definitions* but the live org queries capture the full inventory including
folder structure and access details.
