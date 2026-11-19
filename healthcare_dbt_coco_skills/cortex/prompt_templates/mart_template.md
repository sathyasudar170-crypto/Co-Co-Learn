# Mart Model Template

## Dimension design checklist
- Grain: one row per defined dimension entity/version.
- Natural key: verified source business identifier.
- Surrogate key: generated only when required by project design.
- Attributes: descriptive business context.
- History: Type 1/Type 2 only according to an explicit requirement and available history.

## Fact design checklist
- Grain: one row per clearly defined business event.
- Foreign keys: map to the actual dimension key columns.
- Measures: numeric business events/quantities with clear definitions.
- Dates: identify the business event represented by each date key.
- Additivity: document measure behavior where relevant.

Produce SQL and schema YAML consistent with existing project conventions.
