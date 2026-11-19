# Task: Design or Create an Incremental Model

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
