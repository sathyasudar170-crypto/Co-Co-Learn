# Task: Debug and Optimize SQL

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
