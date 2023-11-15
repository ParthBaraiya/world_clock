# Contributing Guidelines

## Contribute to Project
- Take a fork from the base repository.
- Create a new branch from the `develop` branch.
- Check [Commit and PR guidelines](https://github.com/ParthBaraiya/world_clock/blob/master/CONTRIBUTING.md#commit-and-pr-guidelines).
- Do necessary changes in your branch.
- Push branch on forked remote.
- Create a PR on base repository's `develop` branch.

## Issue Guidelines
- Provide as much details as you can while creating an issue.
- If possible, attach an image or video link in which an issue is visible.
- If it's an feature request, describe your request with as much details as possible.
- If possible, attach an reference link that can help others to understand what you want to include.
- Do not use any kind of abusive language while describing an issue or PR.
- Be polite to others while doing communication in an issue or PR.

## Commit and PR guidelines
- One Branch/PR Must contain only one feature implementation or bug fix. If there are multiple 
  bug fixes or feature implementations, create separate branches and make the changes in 
  respective branch.
- After completing implementation, update major, minor, patch version based on the changes that you
  have made.
    - Update major version if there are any breaking changes.
    - Update minor version if there is a new feature implemented.
    - Update patch version if there are bug fixes.
- Update `CHANGELOG.md` file with respective version and changes that you have made.
  - Include the issue link (If possible)
  - Include the author's User name with link to the github profile (If you want)
  - Any version that's been added in changelog should have a suffix `[Unreleased]`. This suffix 
    will be removed once we push the change in `master` branch.
- All commit messages for a feature implementation should start with `:sparkles:`.
- All commit message for a bug fix should start with `:bug:`.
- Describe the changes that you have made and it's effect on the application. Attach images or 
  video if possible.
- Include the issue link with commit message and PR description if possible.
- Make sure there are no analytical issues in the project.
- Any direct PRs on `master` branch will be rejected without review unless it's created by one of 
  the collaborators of this repository.