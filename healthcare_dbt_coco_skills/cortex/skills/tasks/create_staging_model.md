# Task: Create a Staging Model

## Use when
The user requests a staging model for a raw source.

## Read
- `prompt_templates/staging_template.md`
- `standards/project_standards.md`
- `standards/sql_standards.md`
- `standards/yaml_documentation_standards.md`
- `patterns/grain_and_model_design.md`

## Workflow
1. Inspect source YAML and the relevant existing staging model.
2. Verify actual source columns and types; never invent them.
3. Use one staging model per source entity unless project architecture says otherwise.
4. Standardize names, trim textual values where appropriate, cast dates/times/numbers safely, and preserve source identifiers.
5. Avoid complex business joins in staging.
6. Define the grain and key candidates.
7. Add or update schema YAML descriptions.
8. Recommend tests only when justified.
9. Do not run dbt unless explicitly authorized.
