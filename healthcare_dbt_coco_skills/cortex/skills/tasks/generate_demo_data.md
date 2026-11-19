# Task: Generate Demo Data

## Use when
The user asks for synthetic sample data for learning or demonstrations.

## Read
- `prompt_templates/demo_data_template.md`
- `standards/project_standards.md`

## Workflow
1. Confirm requested entities, row counts, format, and relationships.
2. Inspect actual source column names and constraints.
3. Generate clearly synthetic data; never represent it as real patient data.
4. Keep primary/foreign key relationships consistent.
5. Use fictional names, contact details, and identifiers.
6. Do not use real patient information.
7. Do not load data into Snowflake unless explicitly authorized.
