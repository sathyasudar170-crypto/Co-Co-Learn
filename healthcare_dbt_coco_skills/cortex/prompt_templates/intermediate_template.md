# Intermediate Model Template

```sql
{{ config(materialized='view') }}

with <upstream_cte_1> as (

    select
        -- Explicit columns
    from {{ ref('<upstream_model>') }}

),

<upstream_cte_2> as (

    select
        -- Explicit columns
    from {{ ref('<upstream_model>') }}

),

joined as (

    select
        -- Explicit business output columns
    from <upstream_cte_1> as a
    left join <upstream_cte_2> as b
        on a.<verified_key> = b.<verified_key>

)

select
    -- Explicit final output columns
from joined
```

Before using: replace all placeholders, state the grain, verify join cardinality, and prefer explicit final columns over `SELECT *`.
