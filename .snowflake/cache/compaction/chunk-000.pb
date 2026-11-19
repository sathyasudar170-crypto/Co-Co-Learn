

Hhealthcare_dbt_coco_skills/cortex/prompt_templates/demo_data_template.md˜# Demo Data Template

Generate synthetic data only.

For each entity, specify:
- Confirmed column names and types
- Desired row count
- Primary/natural key uniqueness
- Foreign key relationships
- Valid date and status ranges only when confirmed
- Output format (CSV/SQL/seed)

Use fictional personal details. Do not load data into a live database without explicit approval.
*
ÃØ˙◊ 8beb5101c255bdfc34715f65b62328d2
ú
Lhealthcare_dbt_coco_skills/cortex/prompt_templates/documentation_template.mdü# dbt Documentation Template

For each model:
- Model name
- Business purpose
- Layer
- Grain
- Upstream dependencies
- Key columns and verified relationships

For each output column:
- Exact column name
- Business meaning
- Data type only if confirmed
- Key role if verified
- Source lineage where known

Generate/update schema YAML and a Markdown data dictionary only as requested. Avoid duplicate model entries.
*
ÃØ˙◊ f459fc1e6ce1ed3aa54b70db55510ab1
á
Lhealthcare_dbt_coco_skills/cortex/prompt_templates/full_pipeline_template.mdä# Full Pipeline Template

Plan the pipeline in dependency order:

1. Source declarations
2. Staging models
3. Intermediate transformations
4. Dimensions and facts
5. Publish/reporting models
6. Schema YAML documentation
7. Data quality tests
8. Dependency/lineage review

For each model provide:
- Name and layer
- Purpose
- Grain
- Upstream dependencies
- Key columns and relationships
- Materialization recommendation
- Tests and documentation

Inspect existing files and reuse valid models. Do not generate duplicates.
*
ÃØ˙◊ 792fa714dabf96fa916880d4dda2eed8
Ç
Jhealthcare_dbt_coco_skills/cortex/prompt_templates/incremental_template.mdá# Incremental Model Design Template

Document before coding:
- Model purpose and grain
- Unique key
- Incremental change-detection column
- Strategy and adapter compatibility
- First-run behavior
- Updates and late-arriving records
- Delete handling
- Backfill/full-refresh procedure
- Tests and documentation

Do not write executable incremental SQL until all required inputs are verified.
*
ÃØ˙◊ 77065daadea3b2c8e695ff2fd33814ee
ö
Khealthcare_dbt_coco_skills/cortex/prompt_templates/intermediate_template.mdû# Intermediate Model Template

```sql
{{ config(materialized='view') }}

with <upstream_cte_1> as (

    select
        -- Explicit columns
    from {{ ref('<upstream_model>') }}

),

<upstream_cte_2> as (

    select
        -- Explicit columns
    from {{ ref('<upstream_model>') }}

),

joined as (

    select
        -- Explicit business output columns
    from <upstream_cte_1> as a
    left join <upstream_cte_2> as b
        on a.<verified_key> = b.<verified_key>

)

select
    -- Explicit final output columns
from joined
```

Before using: replace all placeholders, state the grain, verify join cardinality, and prefer explicit final columns over `SELECT *`.
*
ÃØ˙◊ 209d9a1458797acb8b820d3dc3643446

Chealthcare_dbt_coco_skills/cortex/prompt_templates/mart_template.md¸# Mart Model Template

## Dimension design checklist
- Grain: one row per defined dimension entity/version.
- Natural key: verified source business identifier.
- Surrogate key: generated only when required by project design.
- Attributes: descriptive business context.
- History: Type 1/Type 2 only according to an explicit requirement and available history.

## Fact design checklist
- Grain: one row per clearly defined business event.
- Foreign keys: map to the actual dimension key columns.
- Measures: numeric business events/quantities with clear definitions.
- Dates: identify the business event represented by each date key.
- Additivity: document measure behavior where relevant.

Produce SQL and schema YAML consistent with existing project conventions.
*
ÃØ˙◊ 25a0d6a57758ffaa73a27fce41aff0ee
π
Fhealthcare_dbt_coco_skills/cortex/prompt_templates/metrics_template.md¬# KPI / Metric Definition Template

| Field | Definition |
|---|---|
| Metric name | Business-approved name |
| Purpose | What decision it supports |
| Formula | Exact calculation |
| Grain | Level at which it is calculated |
| Date basis | Event/reporting date |
| Filters | Included/excluded records |
| Null/zero handling | Explicit behavior |
| Source | Verified models and columns |
| Approval status | Confirmed / Needs Business Confirmation |
*
ÃØ˙◊ 6986c0c1f449b22e64783ce3bc0ad008
À
Fhealthcare_dbt_coco_skills/cortex/prompt_templates/publish_template.md‘# Publish Model Template

A publish model is a stable reporting-facing interface built from approved mart models.

Document:
- Intended consumer/use case
- Output grain
- Included dimensions and measures
- Metric definitions and filters
- Refresh/materialization expectations

Use explicit columns and preserve agreed business definitions.
*
ÃØ˙◊ 349ec88cec193eda8bfe01b04f793590
“
Ehealthcare_dbt_coco_skills/cortex/prompt_templates/source_template.md‹# Source Definition Template

Use this template when declaring raw inputs in dbt.

Required inputs:
- Exact database and schema
- Exact raw table names
- Confirmed loaded-at column, if freshness is required
- Existing source YAML conventions

Expected output:
- Valid dbt `sources` YAML
- Source and table descriptions where supported by confirmed information
- Optional freshness configuration only when justified

Do not invent columns, freshness rules, or source metadata.
*
ÃØ˙◊ 5749aee081c8d68a43e95a4b3347c46c
ì
Fhealthcare_dbt_coco_skills/cortex/prompt_templates/staging_template.mdú# Staging Model Template

```sql
{{ config(materialized='view') }}

with source as (

    select
        -- Explicit source columns, verified from source metadata
    from {{ source('<source_name>', '<source_table>') }}

),

renamed as (

    select
        -- Standardized names and safe casts
    from source

)

select
    -- Explicit final output columns
from renamed
```

Adapt to the actual source columns and project macros. The example is a structural guide, not executable SQL until placeholders are replaced with verified values.
*
ÃØ˙◊ b84a3728bc485bb53c10687b5cb81ce2
Ñ
Khealthcare_dbt_coco_skills/cortex/skills/patterns/grain_and_model_design.mdà# Pattern: Grain and Model Design

Always define grain before writing SQL.

## Grain statement
Use the form: "One row represents one [business event/entity] identified by [key]."

Examples (illustrative; verify against source data and business rules):
- One row per appointment.
- One row per billing record.
- One row per patient.
- One row per doctor.
- One row per treatment.

## Design checks
- Is the grain atomic and unambiguous?
- Can joins multiply rows?
- Does the model combine entities with different grains?
- Are measures additive, semi-additive, or non-additive?
- Are dates tied to a clear business event?
- Does the model require historical tracking?

Do not use an example grain as proof of the actual project grain. Verify the SQL and business requirements.
*
ÀØ˙◊ 2634ac3d67e793849ec910be701242b1
Ï
Khealthcare_dbt_coco_skills/cortex/skills/patterns/keys_and_relationships.md# Pattern: Keys and Relationships

## Key types
- Natural/business key: identifier from the operational source, such as a source patient identifier.
- Surrogate key: warehouse-generated identifier for a dimension row.
- Foreign key: a column that references a key in another model.

## Rules
- Inspect actual dimension and fact SQL to establish key mapping.
- A column named `patient_sk` should not automatically be assumed to reference `patient_id`; verify whether it stores the dimension surrogate key.
- Fact foreign keys should reference the corresponding dimension key actually stored in the fact.
- For a Type 1 dimension, one row per current business entity is typical.
- For Type 2 dimensions, the natural key can have multiple historical rows; relationships may require surrogate keys and effective-date logic.
- Check nullability and unknown-member handling explicitly.
*
ÀØ˙◊ 1c343ada307048f7b0d4bf877a1d1f46
∆
?healthcare_dbt_coco_skills/cortex/skills/patterns/safe_joins.md÷# Pattern: Safe Joins and Cardinality

Before writing a join:
1. Identify the left-side grain.
2. Identify the right-side grain.
3. Identify the join columns from actual SQL.
4. Determine expected cardinality: one-to-one, many-to-one, one-to-many, or many-to-many.
5. Confirm whether the join can multiply rows.
6. Choose `LEFT JOIN` or `INNER JOIN` based on business requirements, not habit.
7. Preserve unmatched records when required for reconciliation.
8. Validate row counts and duplicate keys only when execution is authorized.

Do not assume a join path solely from similarly named columns.
*
ÀØ˙◊ 1aaf3df83c515b04a3509e097b5e96fd
¨
8healthcare_dbt_coco_skills/cortex/skills/router_skill.md√# Healthcare dbt Router Skill

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
*
ÀØ˙◊ 3c4d09e50895dfe93745141c5d74c03f
±
Ehealthcare_dbt_coco_skills/cortex/skills/standards/github_workflow.mdª# GitHub Workflow Standard

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
*
ÀØ˙◊ 525e786257ad96789c12b857b36ed00e
•
Khealthcare_dbt_coco_skills/cortex/skills/standards/incremental_standards.md©# Incremental Model Standards

- Use incremental materialization only when data volume, refresh needs, and source change behavior justify it.
- Confirm a reliable unique key and incremental watermark/change-detection column.
- Define first-run/full-refresh behavior.
- Consider updates to old records, late-arriving data, deletes, and backfills.
- Choose an appropriate strategy (`merge`, `delete+insert`, `append`, etc.) only after checking adapter/version support and project conventions.
- Ensure incremental filters do not permanently miss late updates.
- Do not add an incremental model based only on a guessed timestamp.
- Do not execute or deploy without explicit approval.
*
ÀØ˙◊ 26ca3d630ebb7012647f98f3981788af
¸
Ghealthcare_dbt_coco_skills/cortex/skills/standards/metrics_standards.mdÑ# Metrics and KPI Standards

For each metric document:
- Business name and purpose
- Exact formula
- Numerator and denominator, if applicable
- Grain and aggregation level
- Date basis and reporting period
- Filters and exclusions
- Null/zero handling
- Additivity and known limitations
- Source model/columns

Do not invent a KPI definition. If stakeholders have not defined it, propose a candidate definition and label it `Needs Business Confirmation`.
Keep definitions consistent across marts and publish models.
*
ÀØ˙◊ 00cc0b4813a4172deb05f0c5fdea7b7f
≠
Ghealthcare_dbt_coco_skills/cortex/skills/standards/project_standards.mdµ# Project Standards

## Project identity
- Project: Healthcare Analytics dbt project.
- Database reference: `COCO_PRACTICE_DB`.
- Existing schema reference: `PRACTICE`.
- Never create another schema. Confirm the configured dbt target before any execution.

## Known source tables
- `SOURCE_APPOINTMENTS`
- `SOURCE_BILLING`
- `SOURCE_DOCTORS`
- `SOURCE_PATIENTS`
- `SOURCE_TREATMENTS`

The source YAML currently uses source name `healthcare_raw` and database/schema `COCO_PRACTICE_DB.PRACTICE`. Inspect the live project YAML before relying on this.

## Model layers
1. Source definitions: declare raw inputs using dbt `sources`.
2. Staging: one model per source entity; rename, cast, standardize, and perform light cleanup.
3. Intermediate: combine and transform staging models for reusable business logic.
4. Mart: dimensions and facts designed for analytics.
5. Publish: stable reporting-facing models/views for downstream consumers.

## Naming
Known prefixes:
- `ss_stg_`
- `ss_int_`
- `ss_dim_`
- `ss_fct_`

Check the repository before choosing names for source wrappers or publish models; do not impose `ss_src_` or `ss_pub_` if the existing project uses another convention.

## Materialization guidance
- Staging and intermediate models are commonly views unless the project has a reason to persist them.
- Dimensions and facts may be tables or incremental models depending on volume, refresh requirements, and existing conventions.
- Publish models are commonly views.
- Never change materialization globally without explicit approval.

## Source of truth
Existing SQL, YAML, macros, dbt_project.yml, package configuration, and actual source definitions take precedence over assumptions in prompts or examples.
*
ÀØ˙◊ 6a92b30bca58e3a671a164a317aa491e
Ù
Chealthcare_dbt_coco_skills/cortex/skills/standards/sql_standards.mdÄ# SQL Development Standards

- Use readable, lowercase SQL keywords and consistent indentation.
- Use descriptive CTE names such as `source`, `renamed`, `deduplicated`, `joined`, and `final`.
- Select explicit columns in final model outputs; avoid `SELECT *` in production-facing models.
- Use `source()` for declared raw sources and `ref()` for dbt models.
- Cast columns explicitly where the source type is not suitable for downstream use.
- Use `NULLIF(TRIM(column), '')` for blank-string cleanup only when the column is textual.
- Normalize email casing only when appropriate for the business use.
- Do not silently replace missing keys with arbitrary values.
- Avoid accidental fan-out from one-to-many joins.
- Keep transformations deterministic where possible.
- Use `COALESCE` only when the fallback has a justified business meaning.
- Do not invent columns, data types, accepted values, or business logic.
- Add comments for non-obvious business rules.
- Preserve existing project formatting and macro conventions.
*
ÀØ˙◊ e7e4399c935b993f44de35a53b481951
÷

Ghealthcare_dbt_coco_skills/cortex/skills/standards/testing_standards.mdﬁ	# Data Quality Testing Standards

Use built-in dbt generic tests where appropriate:
- `not_null`
- `unique`
- `accepted_values`
- `relationships`

Test selection rules:
- `unique` is justified only when the column should identify one row at the model's declared grain.
- `not_null` is justified only when null is invalid by business rules or model contract.
- `relationships` must reference the correct parent model and key column, including surrogate-to-surrogate relationships where applicable.
- `accepted_values` requires a confirmed, governed list of allowed values.
- Do not assume a primary key is unique simply because its name ends in `_id` or `_sk`.
- Do not test a fact foreign key against a natural key if the fact stores a surrogate key.
- Consider nullable foreign keys and late-arriving dimensions.
- Refunds, reversals, zero-value transactions, and historical statuses may be valid; do not impose arbitrary positivity/range tests.

Custom tests and package tests:
- Clearly label tests that require custom SQL or an installed package.
- Do not present invented test names as built-in dbt tests.
- Check `packages.yml` and installed dependencies before recommending package macros.
- Do not run tests unless explicitly authorized.
*
ÀØ˙◊ 7f45734663b7a7ff57a5079dcba22291
¸
Rhealthcare_dbt_coco_skills/cortex/skills/standards/yaml_documentation_standards.md˘# YAML and Documentation Standards

- Follow the installed dbt version's supported schema YAML syntax and the project's existing style.
- Use `version: 2` when consistent with the project.
- Add one model entry per model; update existing entries rather than creating duplicates.
- Every model description should explain business purpose, contents, and grain.
- Describe every output column that is important to users; aim for complete column coverage.
- Descriptions must explain business meaning, not merely repeat the column name.
- Identify key columns and relationships only when verified from SQL.
- Keep source declarations in the existing source YAML structure.
- Do not put unverified data types in descriptions; dbt schema YAML column `data_type` should only be used when supported and appropriate for the project's dbt version.
- Keep the data dictionary aligned with the actual final model columns.
- Mark uncertain meanings as `Needs Verification` in review notes rather than presenting guesses as facts.
*
ÀØ˙◊ 8607868bc46f828f351fb7a25f90beb6
ÿ
Fhealthcare_dbt_coco_skills/cortex/skills/tasks/create_staging_model.md·# Task: Create a Staging Model

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
*
ÀØ˙◊ 237ad6d41ecf9b067f4f67b8879bff32
¢
@healthcare_dbt_coco_skills/cortex/skills/tasks/define_metrics.md±# Task: Define Metrics and KPIs

Read `standards/metrics_standards.md`, inspect relevant mart and publish models, and confirm business definitions.

For each KPI:
1. Define business meaning.
2. Identify source columns and model grain.
3. Write an exact formula.
4. State filters, exclusions, date basis and null handling.
5. Identify whether it is additive.
6. Identify the model/view where it should be calculated.
7. Mark unconfirmed definitions `Needs Business Confirmation`.

Do not silently choose business definitions or change existing KPI calculations.
*
ÀØ˙◊ 99d48df459b58a4f0ca0e62df706a480
˙
Ahealthcare_dbt_coco_skills/cortex/skills/tasks/document_models.mdà# Task: Document Models and Build a Data Dictionary

## Use when
The user requests automated dbt documentation.

## Read
- `prompt_templates/full_pipeline_template.md` only if documenting a whole pipeline
- `standards/yaml_documentation_standards.md`
- `standards/testing_standards.md`

## Workflow
1. Inspect every requested model SQL file and existing schema YAML.
2. List actual output columns from each model.
3. Write a business-purpose description and grain statement for each model.
4. Describe each output column using verified lineage and logic.
5. Document natural keys, surrogate keys, and foreign keys only when confirmed.
6. Update schema YAML without duplicate model entries.
7. Create/update a Markdown data dictionary if requested.
8. Mark uncertain meaning as `Needs Verification`.
9. Do not run `dbt docs generate` unless explicitly authorized because it may access warehouse metadata.
*
ÀØ˙◊ 8145146bd2d895ce28a973e26e8dc1d8
Ï
Dhealthcare_dbt_coco_skills/cortex/skills/tasks/generate_demo_data.md˜# Task: Generate Demo Data

## Use when
The user asks for synthetic sample data for learning or demonstrations.

## Read
- `prompt_templates/demo_data_template.md`
- `standards/project_standards.md`

## Workflow
1. Confirm requested entities, row counts, format, and relationships.
2. Inspect actual source column names and constraints.
3. Generate clearly synthetic data; never represent it as real patient data.
4. Keep primary/foreign key relationships consistent.
5. Use fictional names, contact details, and identifiers.
6. Do not use real patient information.
7. Do not load data into Snowflake unless explicitly authorized.
*
ÀØ˙◊ 9f04958350eee1c617f7ffa8945994d2
ı
Hhealthcare_dbt_coco_skills/cortex/skills/tasks/generate_full_pipeline.md¸# Task: Generate or Plan a Full dbt Pipeline

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
*
ÀØ˙◊ 610bf5aeb988d99a4bce5ea87e248f5a
§
@healthcare_dbt_coco_skills/cortex/skills/tasks/review_lineage.md≥# Task: Review Data Lineage and DAG

Inspect dbt `ref()` and `source()` calls, model SQL, YAML and project structure.

Return:
- upstream sources for each requested model;
- downstream dependencies where discoverable from project files;
- layer-by-layer flow;
- join keys and relationship assumptions;
- potential circular dependencies or missing references;
- a Mermaid DAG if useful.

Do not invent lineage based on model names. Distinguish code-derived lineage from runtime/catalog lineage. Do not run dbt docs or query Snowflake unless explicitly authorized.
*
ÀØ˙◊ ebff0873a35b58d6498f444eccc37ef4
Û
Ahealthcare_dbt_coco_skills/cortex/skills/tasks/validate_models.mdÅ# Task: Validate Models and Data Quality

## Use when
The user requests a review of SQL, model relationships, tests, or data quality.

## Read
- `standards/testing_standards.md`
- `patterns/grain_and_model_design.md`
- `patterns/keys_and_relationships.md`
- `patterns/safe_joins.md`

## Workflow
1. Inspect SQL and YAML for the requested models.
2. Confirm model grain from SQL.
3. Verify key columns and relationship targets.
4. Review join cardinality and potential fan-out.
5. Review tests for correctness and whether they are built-in, package-provided, or custom.
6. Separate static code review from data-level validation.
7. Do not claim rows pass tests without executing tests against data.
8. Do not execute SQL/dbt or scan tables unless explicitly authorized.
*
ÀØ˙◊ 6931e8dba6c5b0e56d6dd358b9846d1d
ˇ
$healthcare_dbt_coco_skills/README.md™# Healthcare dbt CoCo Skills

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
*
 Ø˙◊ 57a056a7a9ab85288dfd18f4b646e9b3
Ã)
1healthcare_dbt_coco_skills/cortex/skills/SKILL.mdÍ(# Healthcare Analytics ‚Äî Master CoCo Skill

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
*
 Ø˙◊ 4fded1fa4506df79ad2b4206b546134d
ø
Jhealthcare_dbt_coco_skills/cortex/skills/tasks/create_incremental_model.mdƒ# Task: Design or Create an Incremental Model

Read `prompt_templates/mart_template.md`, `standards/incremental_standards.md`, `standards/sql_standards.md`, and relevant key/join patterns.

Workflow:
1. Confirm why incremental processing is needed.
2. Inspect source update behavior and available timestamp/change columns.
3. Define grain and unique key.
4. Define handling for inserts, updates, late-arriving changes, deletes and backfills.
5. Confirm adapter and dbt version support.
6. Recommend strategy and explain trade-offs.
7. Implement only after user approves the design if behavior is materially uncertain.
8. Add schema docs and tests.
9. Do not execute or deploy without explicit authorization.
*
 Ø˙◊ 8f4962ba9297556f0aad6feb88fceb98
û
Khealthcare_dbt_coco_skills/cortex/skills/tasks/create_intermediate_model.md¢# Task: Create an Intermediate Model

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
*
 Ø˙◊ 9b2a26f3ce227018c2240c30e3ad1419
Ö	
Chealthcare_dbt_coco_skills/cortex/skills/tasks/create_mart_model.mdë# Task: Create a Mart Model (Dimensions and Facts)

## Use when
The user requests a dimension, fact, or analytics mart model.

## Read
- `prompt_templates/mart_template.md`
- `standards/project_standards.md`
- `standards/sql_standards.md`
- `patterns/grain_and_model_design.md`
- `patterns/keys_and_relationships.md`
- `patterns/safe_joins.md`
- `standards/testing_standards.md`

## Workflow
1. Identify whether the requested model is a dimension or fact.
2. State and justify its grain.
3. Inspect upstream models and existing dimensions/facts.
4. For dimensions, identify natural key, surrogate key strategy, attributes, and history requirements.
5. For facts, identify event grain, dimension foreign keys, measures, and relevant dates.
6. Verify every key mapping from actual SQL.
7. Check join cardinality and avoid fact duplication.
8. Choose materialization consistent with project standards.
9. Add schema YAML, descriptions, and justified tests.
10. Do not introduce SCD Type 2 unless requested and the required history data exists.
*
 Ø˙◊ 952cf7970f60966685bf0360d67c0b04
°
Fhealthcare_dbt_coco_skills/cortex/skills/tasks/create_publish_model.md™# Task: Create a Publish Model

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
*
 Ø˙◊ eb8bc65d159bf77e4442c69b9fbd4bae
ˆ
Ehealthcare_dbt_coco_skills/cortex/skills/tasks/create_source_model.mdÄ# Task: Create or Update Source Definitions

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
*
 Ø˙◊ fadc37bb60069db5ea2b77c0b718d142
é
Dhealthcare_dbt_coco_skills/cortex/skills/tasks/debug_optimize_sql.mdô# Task: Debug and Optimize SQL

Read `standards/sql_standards.md`, `patterns/safe_joins.md`, and inspect relevant SQL, macros, adapter/version and error logs.

Workflow:
1. Capture the exact error or performance symptom.
2. Inspect the affected model and upstream dependencies.
3. Identify likely syntax, reference, type, join fan-out, filtering, or materialization issue.
4. Separate confirmed cause from hypotheses.
5. Propose the smallest safe fix.
6. Explain expected impact and any trade-offs.
7. Edit only requested files.
8. Do not execute SQL/dbt or query warehouse unless explicitly authorized.
9. Do not claim performance improvement without measurement.
*
 Ø˙◊ 62f44febc0cf76aec116adc5b15b3c97
˚
	README.md¡Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
*
ﬁÙ◊ cf3bc63e1153390947590443cf0dfbdf
z
Untitled.sql>select * from coco_practice_db.practice.ss_int_billing_details*
óº˙◊ e92ce2ac04c8b2fbe3f5441237d0e8e8
Â
.models/intermidiate/ss_int_billing_details.sqlÜ{{ config(materialized='view', schema='PRACTICE') }}

-- Grain: one row per billing record, identified by bill_id.
-- Billing joins to treatments (many-to-one via treatment_id), then to
-- appointments (many-to-one via appointment_id), then to doctors
-- (many-to-one via doctor_id). No fan-out risk in this chain.

with billing as (

    select
        bill_id,
        patient_id,
        treatment_id,
        bill_date,
        amount,
        payment_method,
        payment_status
    from {{ ref('ss_stg_billing') }}

),

patients as (

    select
        patient_id,
        first_name  as patient_first_name,
        last_name   as patient_last_name,
        gender,
        date_of_birth,
        contact_number,
        address,
        insurance_provider,
        insurance_number,
        email       as patient_email
    from {{ ref('ss_stg_patients') }}

),

treatments as (

    select
        treatment_id,
        appointment_id,
        treatment_type,
        description     as treatment_description,
        cost            as treatment_cost,
        treatment_date
    from {{ ref('ss_stg_treatments') }}

),

appointments as (

    select
        appointment_id,
        doctor_id,
        appointment_date,
        appointment_time,
        reason_for_visit,
        status          as appointment_status
    from {{ ref('ss_stg_appointments') }}

),

doctors as (

    select
        doctor_id,
        first_name      as doctor_first_name,
        last_name       as doctor_last_name,
        specialization,
        phone_number    as doctor_phone_number,
        years_experience,
        hospital_branch,
        email           as doctor_email
    from {{ ref('ss_stg_doctors') }}

),

joined as (

    select
        -- billing
        b.bill_id,
        b.bill_date,
        b.amount,
        b.payment_method,
        b.payment_status,

        -- patient
        b.patient_id,
        p.patient_first_name,
        p.patient_last_name,
        p.gender,
        p.date_of_birth,
        p.contact_number,
        p.address,
        p.insurance_provider,
        p.insurance_number,
        p.patient_email,

        -- treatment
        b.treatment_id,
        t.treatment_type,
        t.treatment_description,
        t.treatment_cost,
        t.treatment_date,

        -- appointment (via treatment)
        t.appointment_id,
        ap.appointment_date,
        ap.appointment_time,
        ap.reason_for_visit,
        ap.appointment_status,

        -- doctor (via appointment)
        ap.doctor_id,
        d.doctor_first_name,
        d.doctor_last_name,
        d.specialization,
        d.doctor_phone_number,
        d.years_experience,
        d.hospital_branch,
        d.doctor_email

    from billing as b
    left join patients as p
        on b.patient_id = p.patient_id
    left join treatments as t
        on b.treatment_id = t.treatment_id
    left join appointments as ap
        on t.appointment_id = ap.appointment_id
    left join doctors as d
        on ap.doctor_id = d.doctor_id

)

select
    bill_id,
    bill_date,
    amount,
    payment_method,
    payment_status,
    patient_id,
    patient_first_name,
    patient_last_name,
    gender,
    date_of_birth,
    contact_number,
    address,
    insurance_provider,
    insurance_number,
    patient_email,
    treatment_id,
    treatment_type,
    treatment_description,
    treatment_cost,
    treatment_date,
    appointment_id,
    appointment_date,
    appointment_time,
    reason_for_visit,
    appointment_status,
    doctor_id,
    doctor_first_name,
    doctor_last_name,
    specialization,
    doctor_phone_number,
    years_experience,
    hospital_branch,
    doctor_email
from joined
*
˛∏˙◊ 619db252fd70583842ab5a0ba35924a4
ì
2models/intermidiate/ss_int_appointment_details.sql∞{{ config(materialized='view', schema='PRACTICE') }}

-- Grain: one row per appointment, identified by appointment_id.
-- Treatments are pre-aggregated to avoid fan-out from the one-to-many
-- relationship between appointments and treatments.

with appointments as (

    select
        appointment_id,
        patient_id,
        doctor_id,
        appointment_date,
        appointment_time,
        reason_for_visit,
        status
    from {{ ref('ss_stg_appointments') }}

),

patients as (

    select
        patient_id,
        first_name  as patient_first_name,
        last_name   as patient_last_name,
        gender,
        date_of_birth,
        contact_number,
        address,
        insurance_provider,
        insurance_number,
        email       as patient_email
    from {{ ref('ss_stg_patients') }}

),

doctors as (

    select
        doctor_id,
        first_name      as doctor_first_name,
        last_name       as doctor_last_name,
        specialization,
        phone_number    as doctor_phone_number,
        years_experience,
        hospital_branch,
        email           as doctor_email
    from {{ ref('ss_stg_doctors') }}

),

treatments_agg as (

    select
        appointment_id,
        count(*)                as treatment_count,
        sum(cost)               as total_treatment_cost,
        min(treatment_date)     as earliest_treatment_date,
        max(treatment_date)     as latest_treatment_date
    from {{ ref('ss_stg_treatments') }}
    group by appointment_id

),

joined as (

    select
        -- appointment
        a.appointment_id,
        a.appointment_date,
        a.appointment_time,
        a.reason_for_visit,
        a.status,

        -- patient
        a.patient_id,
        p.patient_first_name,
        p.patient_last_name,
        p.gender,
        p.date_of_birth,
        p.contact_number,
        p.address,
        p.insurance_provider,
        p.insurance_number,
        p.patient_email,

        -- doctor
        a.doctor_id,
        d.doctor_first_name,
        d.doctor_last_name,
        d.specialization,
        d.doctor_phone_number,
        d.years_experience,
        d.hospital_branch,
        d.doctor_email,

        -- treatments (aggregated to preserve appointment grain)
        coalesce(t.treatment_count, 0)  as treatment_count,
        t.total_treatment_cost,
        t.earliest_treatment_date,
        t.latest_treatment_date

    from appointments as a
    left join patients as p
        on a.patient_id = p.patient_id
    left join doctors as d
        on a.doctor_id = d.doctor_id
    left join treatments_agg as t
        on a.appointment_id = t.appointment_id

)

select
    appointment_id,
    appointment_date,
    appointment_time,
    reason_for_visit,
    status,
    patient_id,
    patient_first_name,
    patient_last_name,
    gender,
    date_of_birth,
    contact_number,
    address,
    insurance_provider,
    insurance_number,
    patient_email,
    doctor_id,
    doctor_first_name,
    doctor_last_name,
    specialization,
    doctor_phone_number,
    years_experience,
    hospital_branch,
    doctor_email,
    treatment_count,
    total_treatment_cost,
    earliest_treatment_date,
    latest_treatment_date
from joined
*
Í∏˙◊ c699660bb53634d897de9af97dc3d6b9
™
$models/staging/ss_stg_treatments.sql’{{ config(
    materialized='view',
    schema='PRACTICE'
) }}

with source as (

    select
        treatment_id,
        appointment_id,
        treatment_type,
        description,
        cost,
        treatment_date
    from {{ source('healthcare_raw', 'SOURCE_TREATMENTS') }}

),

renamed as (

    select
        nullif(trim(treatment_id), '')     as treatment_id,
        nullif(trim(appointment_id), '')   as appointment_id,
        nullif(trim(treatment_type), '')   as treatment_type,
        nullif(trim(description), '')      as description,
        cost::number(12,2)                 as cost,
        treatment_date::date               as treatment_date

    from source

)

select
    treatment_id,
    appointment_id,
    treatment_type,
    description,
    cost,
    treatment_date
from renamed
*
÷≤˙◊ 590a8856c97011225663d2bd246e549f
æ
"models/staging/ss_stg_patients.sqlÎ
{{ config(
    materialized='view',
    schema='PRACTICE'
) }}

with source as (

    select
        patient_id,
        first_name,
        last_name,
        gender,
        date_of_birth,
        contact_number,
        address,
        registration_date,
        insurance_provider,
        insurance_number,
        email
    from {{ source('healthcare_raw', 'SOURCE_PATIENTS') }}

),

renamed as (

    select
        nullif(trim(patient_id), '')          as patient_id,
        nullif(trim(first_name), '')          as first_name,
        nullif(trim(last_name), '')           as last_name,
        nullif(trim(gender), '')              as gender,
        date_of_birth::date                   as date_of_birth,
        trim(to_varchar(contact_number))      as contact_number,
        nullif(trim(address), '')             as address,
        registration_date::date               as registration_date,
        nullif(trim(insurance_provider), '')  as insurance_provider,
        nullif(trim(insurance_number), '')    as insurance_number,
        lower(nullif(trim(email), ''))        as email

    from source

)

select
    patient_id,
    first_name,
    last_name,
    gender,
    date_of_birth,
    contact_number,
    address,
    registration_date,
    insurance_provider,
    insurance_number,
    email
from renamed
*
Œ≤˙◊ 3ea5c5a7e345dc1664350b6838b6607d
È
!models/staging/ss_stg_doctors.sqló{{ config(
    materialized='view',
    schema='PRACTICE'
) }}

with source as (

    select
        doctor_id,
        first_name,
        last_name,
        specialization,
        phone_number,
        years_experience,
        hospital_branch,
        email
    from {{ source('healthcare_raw', 'SOURCE_DOCTORS') }}

),

renamed as (

    select
        nullif(trim(doctor_id), '')        as doctor_id,
        nullif(trim(first_name), '')       as first_name,
        nullif(trim(last_name), '')        as last_name,
        nullif(trim(specialization), '')   as specialization,
        trim(to_varchar(phone_number))     as phone_number,
        years_experience::integer          as years_experience,
        nullif(trim(hospital_branch), '')  as hospital_branch,
        lower(nullif(trim(email), ''))     as email

    from source

)

select
    doctor_id,
    first_name,
    last_name,
    specialization,
    phone_number,
    years_experience,
    hospital_branch,
    email
from renamed
*
≈≤˙◊ 87192ee70ccde491500ab02713b9a86f

!models/staging/ss_stg_billing.sqlû{{ config(
    materialized='view',
    schema='PRACTICE'
) }}

with source as (

    select
        bill_id,
        patient_id,
        treatment_id,
        bill_date,
        amount,
        payment_method,
        payment_status
    from {{ source('healthcare_raw', 'SOURCE_BILLING') }}

),

renamed as (

    select
        nullif(trim(bill_id), '')          as bill_id,
        nullif(trim(patient_id), '')       as patient_id,
        nullif(trim(treatment_id), '')     as treatment_id,
        bill_date::date                    as bill_date,
        amount::number(12,2)               as amount,
        nullif(trim(payment_method), '')   as payment_method,
        nullif(trim(payment_status), '')   as payment_status

    from source

)

select
    bill_id,
    patient_id,
    treatment_id,
    bill_date,
    amount,
    payment_method,
    payment_status
from renamed
*
Ω≤˙◊ 8511a2fe4fbad4bd9afd593cc8463874
˚
&models/staging/ss_stg_appointments.sql§{{ config(
    materialized='view',
    schema='PRACTICE'
) }}

with source as (

    select
        appointment_id,
        patient_id,
        doctor_id,
        appointment_date,
        appointment_time,
        reason_for_visit,
        status
    from {{ source('healthcare_raw', 'SOURCE_APPOINTMENTS') }}

),

renamed as (

    select
        nullif(trim(appointment_id), '')   as appointment_id,
        nullif(trim(patient_id), '')       as patient_id,
        nullif(trim(doctor_id), '')        as doctor_id,
        appointment_date::date             as appointment_date,
        appointment_time::time             as appointment_time,
        nullif(trim(reason_for_visit), '') as reason_for_visit,
        nullif(trim(status), '')           as status

    from source

)

select
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date,
    appointment_time,
    reason_for_visit,
    status
from renamed*
¥≤˙◊ 29ebf14c318d32d4402141c451303ea3
´
*models/marts/facts/ss_fct_appointments.sql–{{ config(materialized='table', schema='PRACTICE') }}

select
    -- appointment
    appt.appointment_id,
    appt.appointment_date,
    appt.appointment_time,
    appt.status,

    -- dimension surrogate keys
    dp.patient_sk,
    dd.doctor_sk,

    -- date key
    ddt.date_key                        as appointment_date_key,

    -- business keys for traceability
    appt.patient_id,
    appt.doctor_id,

    -- aggregated treatment measures from intermediate
    appt.treatment_count,
    appt.total_treatment_cost,
    appt.earliest_treatment_date,
    appt.latest_treatment_date,

    -- fact measure
    1                                   as appointment_count

from {{ ref('ss_int_appointment_details') }} as appt
left join {{ ref('ss_dim_patients') }} as dp
    on appt.patient_id = dp.patient_id
left join {{ ref('ss_dim_doctors') }} as dd
    on appt.doctor_id = dd.doctor_id
left join {{ ref('ss_dim_date') }} as ddt
    on appt.appointment_date = ddt.full_date
*
Ü˘Ù◊ e25813b6f895ee84013d1aa57f03cfca
•	
%models/marts/facts/ss_fct_billing.sqlœ{{ config(materialized='table', schema='PRACTICE') }}

select
    -- billing
    b.bill_id,
    b.bill_date,
    b.amount,
    b.payment_method,
    b.payment_status,

    -- dimension surrogate keys
    dp.patient_sk,
    dd.doctor_sk,
    dt.treatment_sk,

    -- date keys
    ddt_bill.date_key                   as bill_date_key,
    ddt_treat.date_key                  as treatment_date_key,

    -- business keys for traceability
    b.patient_id,
    b.doctor_id,
    b.treatment_id,

    -- treatment cost from intermediate
    b.treatment_cost,

    -- fact measure
    1                                   as bill_count

from {{ ref('ss_int_billing_details') }} as b
left join {{ ref('ss_dim_patients') }} as dp
    on b.patient_id = dp.patient_id
left join {{ ref('ss_dim_doctors') }} as dd
    on b.doctor_id = dd.doctor_id
left join {{ ref('ss_dim_treatments') }} as dt
    on b.treatment_id = dt.treatment_id
left join {{ ref('ss_dim_date') }} as ddt_bill
    on b.bill_date = ddt_bill.full_date
left join {{ ref('ss_dim_date') }} as ddt_treat
    on b.treatment_date = ddt_treat.full_date
*
Ü˘Ù◊ 30c58e95441d10170808b426a902a528
—	
'models/marts/dimensions/ss_dim_date.sql˘{{ config(materialized='table', schema='PRACTICE') }}

with all_dates as (

    select appointment_date as dt from {{ ref('ss_stg_appointments') }} where appointment_date is not null
    union
    select bill_date as dt from {{ ref('ss_stg_billing') }} where bill_date is not null
    union
    select treatment_date as dt from {{ ref('ss_stg_treatments') }} where treatment_date is not null
    union
    select date_of_birth as dt from {{ ref('ss_stg_patients') }} where date_of_birth is not null
    union
    select registration_date as dt from {{ ref('ss_stg_patients') }} where registration_date is not null

)

select
    to_number(to_char(dt, 'YYYYMMDD'))  as date_key,
    dt                                  as full_date,
    year(dt)                            as year,
    quarter(dt)                         as quarter,
    month(dt)                           as month_number,
    monthname(dt)                       as month_name,
    day(dt)                             as day_number,
    dayname(dt)                         as day_name,
    case when dayofweek(dt) in (0, 6) then true else false end as is_weekend
from all_dates
*
öÛÙ◊ 679a7da2f87f93da3d5f2258f0dac30f
—
-models/marts/dimensions/ss_dim_treatments.sqlÛ{{ config(materialized='table', schema='PRACTICE') }}

select
    md5(treatment_id)   as treatment_sk,
    treatment_id,
    appointment_id,
    treatment_type,
    description,
    cost,
    treatment_date
from {{ ref('ss_stg_treatments') }}
*
îÛÙ◊ e0cd7639aa15a157f8a8bde821b507d6
È
*models/marts/dimensions/ss_dim_doctors.sqlé{{ config(materialized='table', schema='PRACTICE') }}

select
    md5(doctor_id)      as doctor_sk,
    doctor_id,
    first_name,
    last_name,
    specialization,
    phone_number,
    years_experience,
    hospital_branch,
    email
from {{ ref('ss_stg_doctors') }}
*
êÛÙ◊ 91086876886085382bf806851c5becf3
ä
+models/marts/dimensions/ss_dim_patients.sqlÆ{{ config(materialized='table', schema='PRACTICE') }}

select
    md5(patient_id)     as patient_sk,
    patient_id,
    first_name,
    last_name,
    gender,
    date_of_birth,
    contact_number,
    address,
    insurance_provider,
    insurance_number,
    email
from {{ ref('ss_stg_patients') }}
*
ÇÛÙ◊ ceb4621c39daf2cb2106b492824a13d2
æ
macros/generate_schema_name.sqlÓ
{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- if custom_schema_name is not none -%}
        {{ custom_schema_name | trim }}
    {%- else -%}
        {{ target.schema }}
    {%- endif -%}

{%- endmacro %}
*
ﬁÙ◊ aab72ad9cd4df8e6e658d9a7f07948db
À5
%models/marts/facts/fct_healthcare.ymlı4version: 2

models:
  - name: ss_fct_appointments
    description: >
      Appointment fact table containing one row per appointment, identified by appointment_id.
      Sources from ss_int_appointment_details and joins to patient, doctor, and date
      dimensions for surrogate and date keys. Includes aggregated treatment measures
      (count, total cost, earliest/latest treatment date) carried forward from the
      intermediate model. Materialized as a table.
    columns:
      - name: appointment_id
        description: >
          Natural business key identifying each appointment. Grain key for this fact.
        tests:
          - unique
          - not_null
      - name: appointment_date
        description: Calendar date of the appointment.
      - name: appointment_time
        description: Scheduled time of the appointment.
      - name: status
        description: Current status of the appointment (e.g. scheduled, completed, cancelled).
      - name: patient_sk
        description: >
          Surrogate foreign key referencing ss_dim_patients.
          Resolved by joining the intermediate patient_id to the dimension.
        tests:
          - not_null
          - relationships:
              arguments:
                to: ref('ss_dim_patients')
                field: patient_sk
      - name: doctor_sk
        description: >
          Surrogate foreign key referencing ss_dim_doctors.
          Resolved by joining the intermediate doctor_id to the dimension.
        tests:
          - not_null
          - relationships:
              arguments:
                to: ref('ss_dim_doctors')
                field: doctor_sk
      - name: appointment_date_key
        description: >
          Integer date key (YYYYMMDD) referencing ss_dim_date for the appointment date.
        tests:
          - not_null
          - relationships:
              arguments:
                to: ref('ss_dim_date')
                field: date_key
      - name: patient_id
        description: Business key for the patient, retained for traceability.
        tests:
          - not_null
      - name: doctor_id
        description: Business key for the doctor, retained for traceability.
        tests:
          - not_null
      - name: treatment_count
        description: >
          Number of treatments associated with this appointment.
          Defaults to 0 when no treatments exist, carried from the intermediate model.
        tests:
          - not_null
      - name: total_treatment_cost
        description: >
          Sum of all treatment costs for this appointment.
          NULL when no treatments exist.
      - name: earliest_treatment_date
        description: >
          Earliest treatment date among treatments for this appointment.
          NULL when no treatments exist.
      - name: latest_treatment_date
        description: >
          Latest treatment date among treatments for this appointment.
          NULL when no treatments exist.
      - name: appointment_count
        description: >
          Constant measure (always 1) for counting appointments in aggregations.
        tests:
          - not_null

  - name: ss_fct_billing
    description: >
      Billing fact table containing one row per billing record, identified by bill_id.
      Sources from ss_int_billing_details and joins to patient, doctor, treatment,
      and date dimensions for surrogate and date keys. Includes treatment cost
      carried forward from the intermediate model. Materialized as a table.
    columns:
      - name: bill_id
        description: >
          Natural business key identifying each billing record. Grain key for this fact.
        tests:
          - unique
          - not_null
      - name: bill_date
        description: Date the bill was issued.
      - name: amount
        description: Billed amount.
      - name: payment_method
        description: Method of payment used (e.g. insurance, credit card, cash).
      - name: payment_status
        description: Current payment status of the bill (e.g. paid, pending, overdue).
      - name: patient_sk
        description: >
          Surrogate foreign key referencing ss_dim_patients.
          Resolved by joining the intermediate patient_id to the dimension.
        tests:
          - not_null
          - relationships:
              arguments:
                to: ref('ss_dim_patients')
                field: patient_sk
      - name: doctor_sk
        description: >
          Surrogate foreign key referencing ss_dim_doctors.
          Resolved by joining the intermediate doctor_id to the dimension.
          May be NULL when the billing record's treatment lacks an appointment
          or the appointment lacks a doctor reference.
        tests:
          - relationships:
              arguments:
                to: ref('ss_dim_doctors')
                field: doctor_sk
      - name: treatment_sk
        description: >
          Surrogate foreign key referencing ss_dim_treatments.
          Resolved by joining the intermediate treatment_id to the dimension.
        tests:
          - not_null
          - relationships:
              arguments:
                to: ref('ss_dim_treatments')
                field: treatment_sk
      - name: bill_date_key
        description: >
          Integer date key (YYYYMMDD) referencing ss_dim_date for the bill date.
        tests:
          - not_null
          - relationships:
              arguments:
                to: ref('ss_dim_date')
                field: date_key
      - name: treatment_date_key
        description: >
          Integer date key (YYYYMMDD) referencing ss_dim_date for the treatment date.
          May be NULL when the billing record's treatment reference does not resolve.
        tests:
          - relationships:
              arguments:
                to: ref('ss_dim_date')
                field: date_key
      - name: patient_id
        description: Business key for the patient, retained for traceability.
        tests:
          - not_null
      - name: doctor_id
        description: >
          Business key for the doctor, retained for traceability.
          May be NULL when the join chain (billing to treatment to appointment to doctor)
          does not fully resolve.
      - name: treatment_id
        description: Business key for the treatment, retained for traceability.
        tests:
          - not_null
      - name: treatment_cost
        description: >
          Cost of the individual treatment associated with this billing record,
          carried from the intermediate model.
      - name: bill_count
        description: >
          Constant measure (always 1) for counting billing records in aggregations.
        tests:
          - not_null
*
òø˙◊ 3380cca431858c5db71ac8fe1bd237e9
ƒ+
*models/marts/dimensions/dim_healthcare.ymlÈ*version: 2

models:
  - name: ss_dim_patients
    description: >
      Patient dimension containing one row per patient, identified by patient_id.
      Includes a surrogate key (patient_sk) generated via md5(patient_id) and all
      patient demographic and insurance attributes from the staging layer.
      Type 1 dimension: reflects current patient state only.
    columns:
      - name: patient_sk
        description: >
          Surrogate key for the patient dimension, generated as md5(patient_id).
          Referenced by fact tables as a foreign key.
        tests:
          - unique
          - not_null
      - name: patient_id
        description: Natural business key identifying each patient from the source system.
        tests:
          - unique
          - not_null
      - name: first_name
        description: Patient's first name.
      - name: last_name
        description: Patient's last name.
      - name: gender
        description: Patient's reported gender.
      - name: date_of_birth
        description: Patient's date of birth.
      - name: contact_number
        description: Patient's contact phone number.
      - name: address
        description: Patient's mailing or residential address.
      - name: insurance_provider
        description: Name of the patient's insurance provider.
      - name: insurance_number
        description: Patient's insurance policy number.
      - name: email
        description: Patient's email address, lowercased for consistency.

  - name: ss_dim_doctors
    description: >
      Doctor dimension containing one row per doctor, identified by doctor_id.
      Includes a surrogate key (doctor_sk) generated via md5(doctor_id) and all
      doctor professional attributes from the staging layer.
      Type 1 dimension: reflects current doctor state only.
    columns:
      - name: doctor_sk
        description: >
          Surrogate key for the doctor dimension, generated as md5(doctor_id).
          Referenced by fact tables as a foreign key.
        tests:
          - unique
          - not_null
      - name: doctor_id
        description: Natural business key identifying each doctor from the source system.
        tests:
          - unique
          - not_null
      - name: first_name
        description: Doctor's first name.
      - name: last_name
        description: Doctor's last name.
      - name: specialization
        description: Medical specialization of the doctor.
      - name: phone_number
        description: Doctor's contact phone number.
      - name: years_experience
        description: Number of years of professional experience.
      - name: hospital_branch
        description: Hospital branch where the doctor primarily practices.
      - name: email
        description: Doctor's email address, lowercased for consistency.

  - name: ss_dim_treatments
    description: >
      Treatment dimension containing one row per treatment, identified by treatment_id.
      Includes a surrogate key (treatment_sk) generated via md5(treatment_id) and all
      treatment attributes from the staging layer.
      Type 1 dimension: reflects current treatment state only.
    columns:
      - name: treatment_sk
        description: >
          Surrogate key for the treatment dimension, generated as md5(treatment_id).
          Referenced by fact tables as a foreign key.
        tests:
          - unique
          - not_null
      - name: treatment_id
        description: Natural business key identifying each treatment from the source system.
        tests:
          - unique
          - not_null
      - name: appointment_id
        description: Foreign key referencing the appointment during which this treatment was performed.
        tests:
          - not_null
      - name: treatment_type
        description: Category or type of treatment administered.
      - name: description
        description: Free-text description of the treatment performed.
      - name: cost
        description: Cost of the treatment.
      - name: treatment_date
        description: Date the treatment was performed.

  - name: ss_dim_date
    description: >
      Date dimension containing one row per calendar date derived from all date
      columns across staging models (appointment_date, bill_date, treatment_date,
      date_of_birth, registration_date). Identified by date_key (YYYYMMDD integer).
      Provides calendar attributes for time-based analysis in fact tables.
    columns:
      - name: date_key
        description: >
          Integer surrogate key in YYYYMMDD format, derived from to_number(to_char(full_date, 'YYYYMMDD')).
          Referenced by fact tables as a date foreign key.
        tests:
          - unique
          - not_null
      - name: full_date
        description: The actual calendar date value.
        tests:
          - unique
          - not_null
      - name: year
        description: Four-digit year extracted from the date.
      - name: quarter
        description: Quarter of the year (1-4).
      - name: month_number
        description: Month number (1-12).
      - name: month_name
        description: Abbreviated month name (e.g. Jan, Feb).
      - name: day_number
        description: Day of the month (1-31).
      - name: day_name
        description: Abbreviated day name (e.g. Mon, Tue).
      - name: is_weekend
        description: Boolean flag indicating whether the date falls on a weekend (Saturday or Sunday).
*
ˇæ˙◊ dcfbf208cb21ea7c594eb3a146624c5f
ÿ?
&models/intermidiate/int_healthcare.ymlÅ?version: 2

models:
  - name: ss_int_appointment_details
    description: >
      Consolidated appointment-level dataset joining appointment, patient, doctor
      and aggregated treatment information from staging models.
      One row per appointment, identified by appointment_id.
      Treatments are pre-aggregated per appointment to avoid fan-out from the
      one-to-many relationship between appointments and treatments.
    columns:
      - name: appointment_id
        description: Unique identifier for each appointment. Grain key for this model.
        tests:
          - unique
          - not_null
      - name: appointment_date
        description: Calendar date of the appointment.
      - name: appointment_time
        description: Scheduled time of the appointment.
      - name: reason_for_visit
        description: Free-text reason the patient provided for the appointment.
      - name: status
        description: Current status of the appointment (e.g. scheduled, completed, cancelled).
      - name: patient_id
        description: Foreign key referencing the patient who scheduled the appointment.
        tests:
          - not_null
          - relationships:
              arguments:
                to: ref('ss_stg_patients')
                field: patient_id
      - name: patient_first_name
        description: Patient's first name, sourced from the patients staging model.
      - name: patient_last_name
        description: Patient's last name, sourced from the patients staging model.
      - name: gender
        description: Patient's reported gender.
      - name: date_of_birth
        description: Patient's date of birth.
      - name: contact_number
        description: Patient's contact phone number.
      - name: address
        description: Patient's mailing or residential address.
      - name: insurance_provider
        description: Name of the patient's insurance provider.
      - name: insurance_number
        description: Patient's insurance policy number.
      - name: patient_email
        description: Patient's email address.
      - name: doctor_id
        description: Foreign key referencing the doctor assigned to the appointment.
        tests:
          - not_null
          - relationships:
              arguments:
                to: ref('ss_stg_doctors')
                field: doctor_id
      - name: doctor_first_name
        description: Doctor's first name, sourced from the doctors staging model.
      - name: doctor_last_name
        description: Doctor's last name, sourced from the doctors staging model.
      - name: specialization
        description: Medical specialization of the doctor.
      - name: doctor_phone_number
        description: Doctor's contact phone number.
      - name: years_experience
        description: Number of years of professional experience for the doctor.
      - name: hospital_branch
        description: Hospital branch where the doctor primarily practices.
      - name: doctor_email
        description: Doctor's email address.
      - name: treatment_count
        description: >
          Number of treatments associated with this appointment.
          Defaults to 0 when no treatments exist.
        tests:
          - not_null
      - name: total_treatment_cost
        description: >
          Sum of treatment costs for all treatments associated with this appointment.
          NULL when no treatments exist.
      - name: earliest_treatment_date
        description: >
          Earliest treatment date among treatments for this appointment.
          NULL when no treatments exist.
      - name: latest_treatment_date
        description: >
          Latest treatment date among treatments for this appointment.
          NULL when no treatments exist.

  - name: ss_int_billing_details
    description: >
      Consolidated billing-level dataset joining billing, patient, treatment,
      appointment and doctor information from staging models.
      One row per billing record, identified by bill_id.
      Joins traverse billing to treatment (many-to-one), treatment to appointment
      (many-to-one), and appointment to doctor (many-to-one). No fan-out risk.
    columns:
      - name: bill_id
        description: Unique identifier for each billing record. Grain key for this model.
        tests:
          - unique
          - not_null
      - name: bill_date
        description: Date the bill was issued.
      - name: amount
        description: Billed amount.
      - name: payment_method
        description: Method of payment used (e.g. insurance, credit card, cash).
      - name: payment_status
        description: Current payment status of the bill (e.g. paid, pending, overdue).
      - name: patient_id
        description: Foreign key referencing the billed patient.
        tests:
          - not_null
          - relationships:
              arguments:
                to: ref('ss_stg_patients')
                field: patient_id
      - name: patient_first_name
        description: Patient's first name, sourced from the patients staging model.
      - name: patient_last_name
        description: Patient's last name, sourced from the patients staging model.
      - name: gender
        description: Patient's reported gender.
      - name: date_of_birth
        description: Patient's date of birth.
      - name: contact_number
        description: Patient's contact phone number.
      - name: address
        description: Patient's mailing or residential address.
      - name: insurance_provider
        description: Name of the patient's insurance provider.
      - name: insurance_number
        description: Patient's insurance policy number.
      - name: patient_email
        description: Patient's email address.
      - name: treatment_id
        description: Foreign key referencing the treatment associated with this bill.
        tests:
          - not_null
          - relationships:
              arguments:
                to: ref('ss_stg_treatments')
                field: treatment_id
      - name: treatment_type
        description: Category or type of treatment administered.
      - name: treatment_description
        description: Free-text description of the treatment performed.
      - name: treatment_cost
        description: Cost of the treatment from the treatments staging model.
      - name: treatment_date
        description: Date the treatment was performed.
      - name: appointment_id
        description: >
          Appointment associated with this billing record, resolved via treatment.
          May be NULL if the treatment lacks an appointment reference.
      - name: appointment_date
        description: Date of the associated appointment. NULL if no appointment link.
      - name: appointment_time
        description: Time of the associated appointment. NULL if no appointment link.
      - name: reason_for_visit
        description: Reason for the associated appointment visit. NULL if no appointment link.
      - name: appointment_status
        description: Status of the associated appointment. NULL if no appointment link.
      - name: doctor_id
        description: >
          Doctor associated with this billing record, resolved via appointment.
          May be NULL if no appointment or doctor link exists.
      - name: doctor_first_name
        description: Doctor's first name. NULL if no doctor link.
      - name: doctor_last_name
        description: Doctor's last name. NULL if no doctor link.
      - name: specialization
        description: Medical specialization of the doctor. NULL if no doctor link.
      - name: doctor_phone_number
        description: Doctor's contact phone number. NULL if no doctor link.
      - name: years_experience
        description: Years of experience for the doctor. NULL if no doctor link.
      - name: hospital_branch
        description: Hospital branch of the doctor. NULL if no doctor link.
      - name: doctor_email
        description: Doctor's email address. NULL if no doctor link.
*
áª˙◊ 2a12e1b573dd7a1be8cfa1125a58a2ad
¡,
!models/staging/stg_healthcare.ymlÔ+version: 2

models:
  - name: ss_stg_appointments
    description: >
      Staged appointment records from the healthcare raw source.
      One row per appointment, identified by appointment_id.
      Applies text trimming, empty-string-to-null conversion, and date/time casting.
    columns:
      - name: appointment_id
        description: Unique identifier for each appointment.
        tests:
          - unique
          - not_null
      - name: patient_id
        description: Foreign key referencing the patient who scheduled the appointment.
        tests:
          - not_null
      - name: doctor_id
        description: Foreign key referencing the doctor assigned to the appointment.
        tests:
          - not_null
      - name: appointment_date
        description: Calendar date of the appointment, cast to date.
      - name: appointment_time
        description: Scheduled time of the appointment, cast to time.
      - name: reason_for_visit
        description: Free-text reason the patient provided for the appointment.
      - name: status
        description: Current status of the appointment (e.g. scheduled, completed, cancelled).

  - name: ss_stg_billing
    description: >
      Staged billing records from the healthcare raw source.
      One row per billing record, identified by bill_id.
      Applies text trimming, empty-string-to-null conversion, date casting, and numeric casting for amounts.
    columns:
      - name: bill_id
        description: Unique identifier for each billing record.
        tests:
          - unique
          - not_null
      - name: patient_id
        description: Foreign key referencing the billed patient.
        tests:
          - not_null
      - name: treatment_id
        description: Foreign key referencing the treatment associated with this bill.
        tests:
          - not_null
      - name: bill_date
        description: Date the bill was issued, cast to date.
      - name: amount
        description: Billed amount, cast to number(12,2).
      - name: payment_method
        description: Method of payment used (e.g. insurance, credit card, cash).
      - name: payment_status
        description: Current payment status of the bill (e.g. paid, pending, overdue).

  - name: ss_stg_doctors
    description: >
      Staged doctor records from the healthcare raw source.
      One row per doctor, identified by doctor_id.
      Applies text trimming, empty-string-to-null conversion, phone formatting, integer casting for experience, and email lowercasing.
    columns:
      - name: doctor_id
        description: Unique identifier for each doctor.
        tests:
          - unique
          - not_null
      - name: first_name
        description: Doctor's first name.
      - name: last_name
        description: Doctor's last name.
      - name: specialization
        description: Medical specialization of the doctor.
      - name: phone_number
        description: Doctor's contact phone number, converted to varchar and trimmed.
      - name: years_experience
        description: Number of years of professional experience, cast to integer.
      - name: hospital_branch
        description: Hospital branch where the doctor primarily practices.
      - name: email
        description: Doctor's email address, lowercased for consistency.

  - name: ss_stg_patients
    description: >
      Staged patient records from the healthcare raw source.
      One row per patient, identified by patient_id.
      Applies text trimming, empty-string-to-null conversion, date casting, phone formatting, and email lowercasing.
    columns:
      - name: patient_id
        description: Unique identifier for each patient.
        tests:
          - unique
          - not_null
      - name: first_name
        description: Patient's first name.
      - name: last_name
        description: Patient's last name.
      - name: gender
        description: Patient's reported gender.
      - name: date_of_birth
        description: Patient's date of birth, cast to date.
      - name: contact_number
        description: Patient's contact phone number, converted to varchar and trimmed.
      - name: address
        description: Patient's mailing or residential address.
      - name: registration_date
        description: Date the patient was registered in the system, cast to date.
      - name: insurance_provider
        description: Name of the patient's insurance provider.
      - name: insurance_number
        description: Patient's insurance policy number.
      - name: email
        description: Patient's email address, lowercased for consistency.

  - name: ss_stg_treatments
    description: >
      Staged treatment records from the healthcare raw source.
      One row per treatment, identified by treatment_id.
      Applies text trimming, empty-string-to-null conversion, date casting, and numeric casting for cost.
    columns:
      - name: treatment_id
        description: Unique identifier for each treatment.
        tests:
          - unique
          - not_null
      - name: appointment_id
        description: Foreign key referencing the appointment during which this treatment was performed.
        tests:
          - not_null
      - name: treatment_type
        description: Category or type of treatment administered.
      - name: description
        description: Free-text description of the treatment performed.
      - name: cost
        description: Cost of the treatment, cast to number(12,2).
      - name: treatment_date
        description: Date the treatment was performed, cast to date.
*
Ê≤˙◊ 462c26700a26b2c14d1d3545f33ccab9
ç
dbt_project.ymlÕ
# Name your project! Project names should contain only lowercase characters
# and underscores. A good package name should reflect your organization's
# name or the intended use of these models
name: 'my_new_project'
version: '1.0.0'
config-version: 2

# This setting configures which "profile" dbt uses for this project.
profile: 'default'

# These configurations specify where dbt should look for different types of files.
# The `model-paths` config, for example, states that models in this project can be
# found in the "models/" directory. You probably won't need to change these!
model-paths: ["models"]
analysis-paths: ["analyses"]
test-paths: ["tests"]
seed-paths: ["seeds"]
macro-paths: ["macros"]
snapshot-paths: ["snapshots"]

target-path: "target"  # directory which will store compiled SQL files
clean-targets:         # directories to be removed by `dbt clean`
  - "target"
  - "dbt_packages"


# Configuring models
# Full documentation: https://docs.getdbt.com/docs/configuring-models

# In dbt, the default materialization for a model is a view. This means, when you run 
# dbt run or dbt build, all of your models will be built as a view in your data platform. 
# The configuration below will override this setting for models in the example folder to 
# instead be materialized as tables. Any models you add to the root of the models folder will 
# continue to be built as views. These settings can be overridden in the individual model files
# using the `{{ config(...) }}` macro.

models:
  my_new_project:
    # Applies to all files under models/example/
    example:
      +materialized: view
*
ﬁÙ◊ 3077c845d034ad3d886cdcd60a76d09f
Í
!models/staging/src_healthcare.ymlò
version: 2

sources:
  - name: healthcare_raw
    database: COCO_PRACTICE_DB
    schema: PRACTICE

    tables:
      - name: SOURCE_APPOINTMENTS
      - name: SOURCE_BILLING
      - name: SOURCE_DOCTORS
      - name: SOURCE_PATIENTS
      - name: SOURCE_TREATMENTS
*
ﬁÙ◊ b1993d852055200a75686abdabb8f3b2