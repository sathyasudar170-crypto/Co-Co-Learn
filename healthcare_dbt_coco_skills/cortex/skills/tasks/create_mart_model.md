# Task: Create a Mart Model (Dimensions and Facts)

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
