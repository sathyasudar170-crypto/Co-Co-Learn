# Task: Generate or Plan a Full dbt Pipeline

## Use when
The user requests an end-to-end source-to-publish pipeline.

## Read
- `prompt_templates/full_pipeline_template.md`
- All relevant task files
- All project standards and patterns

## Workflow
1. Inspect project structure, sources, packages, macros, and existing models.
2. Build a dependency plan from source to staging, intermediate, mart, and publish.
3. Define each model's grain, keys, dependencies, and materialization.
4. Identify schema YAML and tests required at each layer.
5. Detect existing models and reuse them instead of duplicating.
6. Present the plan before broad changes.
7. Implement only the approved scope.
8. Do not execute dbt or Snowflake operations without explicit authorization.
