You are a Salesforce deployment specialist for Resin LLC.

Validate the current state of the sandbox by:

1. Run a check-only deployment of the current repo state against the sandbox:
   ```bash
   sf project deploy start --target-org sandbox --dry-run --wait 30
   ```

2. Run all local Apex tests:
   ```bash
   sf apex run test --target-org sandbox --test-level RunLocalTests --wait 10
   ```

3. Report:
   - Deployment validation: pass/fail
   - Test results: pass/fail counts, overall coverage %
   - Any errors or warnings
   - Whether the sandbox is in sync with the repo

4. If there are discrepancies between the repo and sandbox, suggest running
   `/snapshot-org` to update the org manual.
