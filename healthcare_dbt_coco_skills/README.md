# Healthcare dbt CoCo Skills

This is a reusable instruction framework for the Healthcare Analytics dbt project.

## Start here
Read `cortex/skills/SKILL.md` and `cortex/skills/router_skill.md`.

## Short invocation
You should not need long prompts. Examples:

- `Use Healthcare dbt skills. Recreate all staging models.`
- `Use Healthcare dbt skills. Create an intermediate model for patient appointment summary.`
- `Use Healthcare dbt skills. Create dimensions and facts for the appointment and billing processes.`
- `Use Healthcare dbt skills. Document all models and generate a data dictionary.`
- `Use Healthcare dbt skills. Review data quality tests for all fact models.`
- `Use Healthcare dbt skills. Review the model DAG and explain lineage.`
- `Use Healthcare dbt skills. Design an incremental billing fact model.`
- `Use Healthcare dbt skills. Debug this dbt compilation error.`
- `Use Healthcare dbt skills. Define the appointment and billing KPIs.`

The master skill automatically routes each request to the right task, templates, standards, and patterns.

## Folder structure
- `cortex/prompt_templates/`: reusable structures and templates
- `cortex/skills/SKILL.md`: master skill and project-wide rules
- `cortex/skills/router_skill.md`: automatic task selection
- `cortex/skills/patterns/`: modelling patterns
- `cortex/skills/standards/`: project, SQL, YAML, testing, incremental, metrics and Git standards
- `cortex/skills/tasks/`: focused task instructions

## Known project context (verify before use)
Database: `COCO_PRACTICE_DB`
Schema: `PRACTICE`
Sources: `SOURCE_APPOINTMENTS`, `SOURCE_BILLING`, `SOURCE_DOCTORS`, `SOURCE_PATIENTS`, `SOURCE_TREATMENTS`
Known prefixes: `ss_stg_`, `ss_int_`, `ss_dim_`, `ss_fct_`

## Safety
Default to inspect/edit files only. Do not execute dbt, SQL, Snowflake operations, Git commit, or Git push without explicit user authorization. Never invent columns or business rules, and never create another schema.
