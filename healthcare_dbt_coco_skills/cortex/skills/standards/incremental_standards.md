# Incremental Model Standards

- Use incremental materialization only when data volume, refresh needs, and source change behavior justify it.
- Confirm a reliable unique key and incremental watermark/change-detection column.
- Define first-run/full-refresh behavior.
- Consider updates to old records, late-arriving data, deletes, and backfills.
- Choose an appropriate strategy (`merge`, `delete+insert`, `append`, etc.) only after checking adapter/version support and project conventions.
- Ensure incremental filters do not permanently miss late updates.
- Do not add an incremental model based only on a guessed timestamp.
- Do not execute or deploy without explicit approval.
