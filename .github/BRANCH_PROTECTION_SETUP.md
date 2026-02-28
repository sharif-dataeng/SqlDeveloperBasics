# Branch Protection Rules Setup Guide

Follow these steps to enable branch protection on the `main` branch in GitHub.

## Steps to Configure

1. Go to **https://github.com/sharif-dataeng/SqlDeveloperBasics/settings/branches**
2. Click **"Add branch protection rule"** (or **"Add rule"** under "Branch protection rules")
3. Under **"Branch name pattern"**, enter: `main`

## Recommended Rules

Enable the following settings:

### Required Pull Request Reviews
- [x] **Require a pull request before merging**
  - [x] Require approvals: **1** (minimum)
  - [x] Dismiss stale pull request approvals when new commits are pushed
  - [x] Require review from Code Owners

### Status Checks
- [x] **Require status checks to pass before merging**
  - [x] Require branches to be up to date before merging
  - Search and add: `Validate PR` (from the GitHub Actions workflow)

### Additional Protections
- [x] **Do not allow bypassing the above settings** (optional, even for admins)
- [x] **Restrict who can push to matching branches** (optional)
  - Add only repo admins or the deployment bot
- [ ] Require signed commits (optional)
- [ ] Require linear history (optional — enforces squash/rebase merges)

4. Click **"Create"** to save the rule.

## What This Achieves

| Rule | Effect |
|------|--------|
| No direct push to `main` | All changes must go through a pull request |
| At least 1 approval required | Peer review before merge |
| CODEOWNERS review required | Designated reviewers are auto-requested |
| Status checks must pass | The `PR Validation` workflow must succeed |
| Stale approvals dismissed | Re-review needed after new commits |

## Files Added to Support These Rules

| File | Purpose |
|------|---------|
| `.github/CODEOWNERS` | Auto-assigns reviewers based on file paths |
| `.github/pull_request_template.md` | Standardized PR description template |
| `.github/workflows/pr-validation.yml` | CI checks for PRs targeting `main` |
