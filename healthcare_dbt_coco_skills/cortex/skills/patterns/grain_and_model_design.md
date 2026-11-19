# Pattern: Grain and Model Design

Always define grain before writing SQL.

## Grain statement
Use the form: "One row represents one [business event/entity] identified by [key]."

Examples (illustrative; verify against source data and business rules):
- One row per appointment.
- One row per billing record.
- One row per patient.
- One row per doctor.
- One row per treatment.

## Design checks
- Is the grain atomic and unambiguous?
- Can joins multiply rows?
- Does the model combine entities with different grains?
- Are measures additive, semi-additive, or non-additive?
- Are dates tied to a clear business event?
- Does the model require historical tracking?

Do not use an example grain as proof of the actual project grain. Verify the SQL and business requirements.
