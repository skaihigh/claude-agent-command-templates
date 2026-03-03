# Dual-Remote Git Workflow for Shared Development

This guide walks you through best practices to collaborate using both a personal and an organization repository for the same project.

## Goals

- Develop primarily in your personal repo (`skaihigh/claude-agent-command-templates`)
- Publish and sync stable versions/branches to your organization's repo (`Brilliant-AS/claude-agent-command-templates`)
- Allow coworkers to make PRs in the org repo and bring those changes back to your personal repo
- Optionally, merge or cherry-pick changes to either repo as needed

---

## 1. Set up the repository and remotes

1. **Clone your personal repo (replace `<your-folder>`):**
    ```bash
    git clone git@github.com:skaihigh/claude-agent-command-templates.git <your-folder>
    cd <your-folder>
    ```

2. **Add the organization repo as an additional remote:**
    ```bash
    git remote add brilliant git@github.com:Brilliant-AS/claude-agent-command-templates.git
    ```

3. **Verify remotes:**
    ```bash
    git remote -v
    # Should show both 'origin' (your repo) and 'brilliant' (org repo)
    ```

---

## 2. Regular development workflow

- Do your regular coding, branching, and pushes to your personal (`origin`) repo.
- Make sure your default/main branch is up to date:
    ```bash
    git checkout main
    git pull origin main
    ```

---

## 3. Publishing changes to the org repo

- When ready to publish a feature or release:
    ```bash
    # Push your local branch to the org repo
    git push brilliant your-branch:your-branch
    # Or publish main
    git push brilliant main:main
    ```

- Optionally, open a PR from your branch in the Brilliant-AS repo for code review.

---

## 4. Handling PRs and contributions from coworkers

- Review and merge coworker PRs via the GitHub UI in the org repo as usual.

- To bring merged changes from org repo into your personal repo:
    ```bash
    git fetch brilliant
    git checkout main
    git merge brilliant/main
    # Resolve any conflicts if prompted
    git push origin main
    ```

---

## 5. General branch maintenance and sync

- To list branches from the org repo:
    ```bash
    git fetch brilliant
    git branch -r
    ```

- To bring a specific feature branch from the org repo:
    ```bash
    git fetch brilliant some-feature-branch
    git checkout -b some-feature-branch brilliant/some-feature-branch
    # Push to your origin if you wish
    git push origin some-feature-branch
    ```

- Cherry-pick specific commits if you do NOT want to merge all changes:
    ```bash
    git fetch brilliant
    git cherry-pick <commit_sha>
    git push origin main
    ```

---

## 6. Tips

- Keep README or CONTRIBUTING files updated to explain this setup to new contributors.
- Use branch protection and PR reviews in the org repo for safe collaboration.
- Sync regularly to avoid conflicts between remotes.

---

## 7. Troubleshooting

- **Common issue: "refusing to merge unrelated histories"**
    - Only ever change history (rebase, force-push) in one place (ideally personal repo), then push clean history to the org repo.
- **Conflicts**: Follow `git status` instructions and carefully resolve differences before pushing to either remote.

---

## 8. Diagram

```
                +------------------------+
    (PRs)       |    Brilliant-AS Repo   |
    [coworkers] ---->        ||          |
                             ||          |
    [your commits]           || <------
    (origin)           [merge/fetch]     |
     skaihigh Repo <----||---------------
                +------------------------+
```

---

## 9. Further reading

- [GitHub docs: Working with multiple remotes](https://docs.github.com/en/repositories/creating-and-managing-repositories/managing-repository-branches/configuring-remotes)
- [Git basics: Syncing repositories](https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes)

---

Happy coding!