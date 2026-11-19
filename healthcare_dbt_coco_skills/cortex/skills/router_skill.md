# Healthcare dbt Router Skill

Read `SKILL.md` first. This router selects the appropriate task skill. The user can simply say "Use Healthcare dbt skills"; do not ask them to repeat standards or template instructions.

## Routing
- source / source YAML / source wrapper -> `tasks/create_source_model.md`
- staging / clean raw entity -> `tasks/create_staging_model.md`
- intermediate / join staging models -> `tasks/create_intermediate_model.md`
- dimension / fact / star schema / mart -> `tasks/create_mart_model.md`
- publish / reporting view -> `tasks/create_publish_model.md`
- demo / synthetic sample data -> `tasks/generate_demo_data.md`
- end-to-end pipeline -> `tasks/generate_full_pipeline.md`
- descriptions / schema YAML / data dictionary / dbt docs -> `tasks/document_models.md`
- tests / data quality / key review -> `tasks/validate_models.md`
- error / compilation issue / slow SQL / optimization -> `tasks/debug_optimize_sql.md`
- lineage / dependencies / DAG -> `tasks/review_lineage.md`
- incremental / merge / watermark / late arriving data -> `tasks/create_incremental_model.md`
- KPI / metric / business measure -> `tasks/define_metrics.md`

If multiple areas are requested, sequence the relevant tasks and stay within the user's requested scope.

## Mandatory process
1. Inspect repository tree, `dbt_project.yml`, source YAML, macros, packages, relevant SQL and schema YAML.
2. Read the selected task instructions.
3. Read referenced template(s), standards, and patterns.
4. Verify all referenced columns and model names from project files.
5. State grain and key/join design for model work.
6. Edit only the requested files.
7. Run static review; do not execute SQL/dbt unless explicitly authorized.
8. Report exact files changed and validation level.

## Project reference
Known database/schema: `COCO_PRACTICE_DB.PRACTICE`.
Known raw tables: `SOURCE_APPOINTMENTS`, `SOURCE_BILLING`, `SOURCE_DOCTORS`, `SOURCE_PATIENTS`, `SOURCE_TREATMENTS`.
Known prefixes: `ss_stg_`, `ss_int_`, `ss_dim_`, `ss_fct_`.
Verify all of these against current project configuration before use.

## Default safety
No new database/schema; no warehouse queries; no dbt execution; no unrelated edits; no Git commit/push without explicit approval.
