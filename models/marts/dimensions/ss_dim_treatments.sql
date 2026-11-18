{{ config(materialized='table', schema='PRACTICE') }}

select
    md5(treatment_id)   as treatment_sk,
    treatment_id,
    appointment_id,
    treatment_type,
    description,
    cost,
    treatment_date
from {{ ref('ss_stg_treatments') }}
