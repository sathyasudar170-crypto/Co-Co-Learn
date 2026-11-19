# Task: Review Data Lineage and DAG

Inspect dbt `ref()` and `source()` calls, model SQL, YAML and project structure.

Return:
- upstream sources for each requested model;
- downstream dependencies where discoverable from project files;
- layer-by-layer flow;
- join keys and relationship assumptions;
- potential circular dependencies or missing references;
- a Mermaid DAG if useful.

Do not invent lineage based on model names. Distinguish code-derived lineage from runtime/catalog lineage. Do not run dbt docs or query Snowflake unless explicitly authorized.
