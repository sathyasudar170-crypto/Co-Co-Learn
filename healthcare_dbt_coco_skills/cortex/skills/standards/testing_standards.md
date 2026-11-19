# Data Quality Testing Standards

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
