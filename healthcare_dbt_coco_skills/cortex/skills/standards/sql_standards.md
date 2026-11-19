# SQL Development Standards

- Use readable, lowercase SQL keywords and consistent indentation.
- Use descriptive CTE names such as `source`, `renamed`, `deduplicated`, `joined`, and `final`.
- Select explicit columns in final model outputs; avoid `SELECT *` in production-facing models.
- Use `source()` for declared raw sources and `ref()` for dbt models.
- Cast columns explicitly where the source type is not suitable for downstream use.
- Use `NULLIF(TRIM(column), '')` for blank-string cleanup only when the column is textual.
- Normalize email casing only when appropriate for the business use.
- Do not silently replace missing keys with arbitrary values.
- Avoid accidental fan-out from one-to-many joins.
- Keep transformations deterministic where possible.
- Use `COALESCE` only when the fallback has a justified business meaning.
- Do not invent columns, data types, accepted values, or business logic.
- Add comments for non-obvious business rules.
- Preserve existing project formatting and macro conventions.
