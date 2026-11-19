# YAML and Documentation Standards

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
