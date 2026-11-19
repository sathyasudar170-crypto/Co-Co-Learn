# Task: Document Models and Build a Data Dictionary

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
