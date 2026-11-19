# Task: Create a Publish Model

## Use when
The user requests a reporting-facing model, curated view, or stable consumer interface.

## Read
- `prompt_templates/publish_template.md`
- `standards/project_standards.md`
- `standards/sql_standards.md`
- `standards/yaml_documentation_standards.md`

## Workflow
1. Inspect the mart models and existing publish models.
2. Confirm intended consumers and business definitions.
3. Select only required columns and approved metrics.
4. Preserve metric definitions consistently; do not redefine KPIs silently.
5. Add descriptions and document filters/aggregation grain.
6. Use a view or existing project convention unless otherwise requested.
