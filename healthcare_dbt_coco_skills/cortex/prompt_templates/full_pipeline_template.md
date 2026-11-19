# Full Pipeline Template

Plan the pipeline in dependency order:

1. Source declarations
2. Staging models
3. Intermediate transformations
4. Dimensions and facts
5. Publish/reporting models
6. Schema YAML documentation
7. Data quality tests
8. Dependency/lineage review

For each model provide:
- Name and layer
- Purpose
- Grain
- Upstream dependencies
- Key columns and relationships
- Materialization recommendation
- Tests and documentation

Inspect existing files and reuse valid models. Do not generate duplicates.
