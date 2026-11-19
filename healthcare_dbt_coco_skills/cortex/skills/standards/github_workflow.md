# GitHub Workflow Standard

Git operations require explicit user authorization.

## Before commit
1. Show `git status`.
2. Review the diff.
3. Confirm no credentials, private keys, tokens, local environment files, or generated artifacts are included.
4. Summarize files changed.
5. Ask for approval to commit.

## Before push
1. Confirm the intended branch and remote.
2. Confirm the commit contents.
3. Ask for explicit approval to push.
4. Never force-push unless the user explicitly requests it and understands the impact.

## Secrets
Never add passwords, Snowflake private keys, access tokens, `.env` files, or credential-bearing profiles to Git.
Use `.gitignore` and secret-safe configuration.
