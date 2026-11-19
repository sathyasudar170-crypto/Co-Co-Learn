# Healthcare Analytics — Master CoCo Skill

This is the entry point for all work in this repository. When the user says "Use Healthcare dbt skills", read this file and `router_skill.md`, then automatically select and apply the matching task instructions. The user should not need to name individual templates, standards, or patterns.

## 1. Operating principles

- Treat the current project files as the source of truth.
- Inspect before editing. Reuse existing models and YAML; do not create duplicates.
- Never invent source columns, types, keys, relationships, business rules, metric definitions, or accepted values.
- Keep changes within the requested scope.
- Explain important design choices in simple, professional English.
- Mark unresolved facts `Needs Verification`.
- Default to file-only work. Do not run SQL, dbt, or Snowflake operations unless the user explicitly authorizes execution.
- Never create a database or schema. Respect the project's existing database/schema configuration.
- Never commit or push without explicit approval.

## 2. Project context (verify before use)

Known database: `COCO_PRACTICE_DB`
Known schema: `PRACTICE`
Known source tables:
- `SOURCE_APPOINTMENTS`
- `SOURCE_BILLING`
- `SOURCE_DOCTORS`
- `SOURCE_PATIENTS`
- `SOURCE_TREATMENTS`

Known prefixes:
- Staging: `ss_stg_`
- Intermediate: `ss_int_`
- Dimensions: `ss_dim_`
- Facts: `ss_fct_`

These are known reference details, not proof of the current configuration. Inspect `dbt_project.yml`, source YAML, macros, profiles/environment configuration where accessible, and existing model paths.

## 3. Skills available

| Skill area | Task file |
|---|---|
| Source declarations/source wrappers | `tasks/create_source_model.md` |
| Staging models | `tasks/create_staging_model.md` |
| Intermediate models | `tasks/create_intermediate_model.md` |
| Dimensions, facts, marts | `tasks/create_mart_model.md` |
| Publish/reporting models | `tasks/create_publish_model.md` |
| Synthetic/demo data | `tasks/generate_demo_data.md` |
| End-to-end pipeline | `tasks/generate_full_pipeline.md` |
| Model/column docs and data dictionary | `tasks/document_models.md` |
| Data quality tests and model review | `tasks/validate_models.md` |
| SQL debugging and optimization | `tasks/debug_optimize_sql.md` |
| Data lineage and DAG review | `tasks/review_lineage.md` |
| Incremental model design | `tasks/create_incremental_model.md` |
| Metrics and KPI definitions | `tasks/define_metrics.md` |

## 4. Automatic workflow

For every request:
1. Read `router_skill.md`.
2. Identify the task from the request; if ambiguous, ask one focused question.
3. Read the selected task file.
4. Read the relevant prompt template(s).
5. Apply all applicable standards and patterns. Do not ask the user to list them.
6. Inspect existing project files and dependencies.
7. State the grain, keys, join logic, and intended outputs when model design is involved.
8. Make only the requested changes.
9. Perform static checks. Execute dbt/SQL only with explicit permission.
10. Report files changed, validation status, and anything needing verification.

## 5. Model development rules

### Layer responsibilities
- Sources: declare raw tables with dbt `source()` configuration.
- Staging: clean, rename, cast and standardize one source entity; avoid business joins.
- Intermediate: reusable business transformations and joins.
- Mart: dimensions and facts designed around declared grains.
- Publish: stable reporting-facing models and approved metric definitions.

### Naming
Follow existing project naming. Known prefixes are `ss_stg_`, `ss_int_`, `ss_dim_`, and `ss_fct_`. Verify source/publish prefixes before applying.

### Grain and keys
- State one-row-per-what grain before SQL.
- Identify natural/business keys, surrogate keys, and foreign keys from actual SQL.
- Ensure fact foreign keys reference the actual dimension key stored in the fact.
- Check join cardinality and possible row multiplication.
- Do not assume `_id` or `_sk` semantics from names alone.

### SQL
- Use `source()` for declared raw sources and `ref()` for dbt models.
- Prefer explicit column lists in final outputs.
- Use readable CTEs, consistent aliases, and clear casts.
- Avoid `SELECT *` in production-facing outputs.
- Avoid unrequested filters, deduplication, or business calculations.
- Preserve unmatched records when required by the business logic.

### YAML and docs
- Update existing schema YAML instead of duplicating model entries.
- Document model purpose, grain, and output columns.
- Add only justified tests.
- Keep the data dictionary aligned with actual model outputs.

## 6. Validation levels

Always distinguish:
- Static review: SQL/YAML structure and references inspected without execution.
- Parse/compile validation: dbt command executed.
- Data test validation: tests executed against warehouse data.
- Runtime validation: model successfully built in the target.

Never claim a higher level than actually completed.

## 7. Git safety

Before commit or push:
- inspect status and diff;
- check for credentials, private keys, tokens, `.env`, and local profiles;
- summarize exact files;
- obtain explicit user approval for commit and separate approval for push.
