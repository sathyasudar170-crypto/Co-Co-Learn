# Pattern: Keys and Relationships

## Key types
- Natural/business key: identifier from the operational source, such as a source patient identifier.
- Surrogate key: warehouse-generated identifier for a dimension row.
- Foreign key: a column that references a key in another model.

## Rules
- Inspect actual dimension and fact SQL to establish key mapping.
- A column named `patient_sk` should not automatically be assumed to reference `patient_id`; verify whether it stores the dimension surrogate key.
- Fact foreign keys should reference the corresponding dimension key actually stored in the fact.
- For a Type 1 dimension, one row per current business entity is typical.
- For Type 2 dimensions, the natural key can have multiple historical rows; relationships may require surrogate keys and effective-date logic.
- Check nullability and unknown-member handling explicitly.
