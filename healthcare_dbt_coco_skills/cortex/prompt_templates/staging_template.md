# Staging Model Template

```sql
{{ config(materialized='view') }}

with source as (

    select
        -- Explicit source columns, verified from source metadata
    from {{ source('<source_name>', '<source_table>') }}

),

renamed as (

    select
        -- Standardized names and safe casts
    from source

)

select
    -- Explicit final output columns
from renamed
```

Adapt to the actual source columns and project macros. The example is a structural guide, not executable SQL until placeholders are replaced with verified values.
