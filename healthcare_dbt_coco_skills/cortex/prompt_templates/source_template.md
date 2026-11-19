# Source Definition Template

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
