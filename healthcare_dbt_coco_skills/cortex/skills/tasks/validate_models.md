# Task: Validate Models and Data Quality

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
