# Task: Create an Intermediate Model

## Use when
The user requests a reusable business transformation joining or shaping staging models.

## Read
- `prompt_templates/intermediate_template.md`
- `standards/sql_standards.md`
- `patterns/grain_and_model_design.md`
- `patterns/keys_and_relationships.md`
- `patterns/safe_joins.md`
- `standards/yaml_documentation_standards.md`

## Workflow
1. Inspect all relevant staging/intermediate SQL.
2. State the target grain.
3. Map required columns to their upstream models.
4. Explain join keys and expected cardinality.
5. Check for fan-out and duplicate-producing joins.
6. Write explicit output columns with clear aliases.
7. Add model and column descriptions.
8. Recommend justified tests.
9. Do not invent business calculations or silently filter records.
