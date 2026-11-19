# Pattern: Safe Joins and Cardinality

Before writing a join:
1. Identify the left-side grain.
2. Identify the right-side grain.
3. Identify the join columns from actual SQL.
4. Determine expected cardinality: one-to-one, many-to-one, one-to-many, or many-to-many.
5. Confirm whether the join can multiply rows.
6. Choose `LEFT JOIN` or `INNER JOIN` based on business requirements, not habit.
7. Preserve unmatched records when required for reconciliation.
8. Validate row counts and duplicate keys only when execution is authorized.

Do not assume a join path solely from similarly named columns.
