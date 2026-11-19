# Task: Create or Update Source Definitions

## Use when
The user asks to declare raw tables in dbt sources or create a source-layer wrapper model.

## Read
- `prompt_templates/source_template.md`
- `standards/project_standards.md`
- `standards/sql_standards.md`

## Workflow
1. Inspect current source YAML and raw table names.
2. Verify database, schema, and exact source table names from project files or user-provided metadata.
3. Prefer dbt `source()` declarations for raw tables; do not create wrapper models unless requested or the architecture requires them.
4. Add freshness/loaded-at configuration only when the required timestamp column and policy are confirmed.
5. Avoid changing credentials or target configuration.
6. Report exact YAML/SQL files changed.
