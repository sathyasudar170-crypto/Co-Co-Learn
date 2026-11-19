# Project Standards

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
