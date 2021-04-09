# tazkrtak

[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

Transportation Tickets Payment

## Version Control Guidelines

### Commits Convention

The [Conventional Commits specification](https://www.conventionalcommits.org/en/v1.0.0/)
should be followed using the following types:

| Type       | Related Changes                                                  |
| :--------- | :--------------------------------------------------------------- |
| `style`    | Restyling widgets or Updating theme, without affecting any logic |
| `feat`     | Introducing new feature                                          |
| `fix`      | Fixing a bug                                                     |
| `refactor` | Code change that neither fixes a bug nor adds a feature          |
| `ci`       | Updating GitHub Actions workflow or adding new one               |
| `chore`    | Changes not related to application code, like updating README    |

### Merging Workflow

- The [GitHub Workflow](https://guides.github.com/introduction/flow/) should be followed.
- PRs should be [Squashed and Merged](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-request-merges#squash-and-merge-your-pull-request-commits) into master.
- It's preferred to enable auto merge on your PRs.

## Getting started

1. Install [derry](https://pub.dev/packages/derry): `flutter pub global activate derry`
1. Add Pub's cache folder _`(C:\Users\USER\AppData\Roaming\Pub\Cache\bin)`_ to your `PATH`.
1. Run `derry build`\* to get dependencies and generate missing files.

> \* For Git bash: use `derry.bat` instead of `derry`
