# Incremental Model Design Template

Document before coding:
- Model purpose and grain
- Unique key
- Incremental change-detection column
- Strategy and adapter compatibility
- First-run behavior
- Updates and late-arriving records
- Delete handling
- Backfill/full-refresh procedure
- Tests and documentation

Do not write executable incremental SQL until all required inputs are verified.
