{{ config(materialized='table', schema='PRACTICE') }}

select
    md5(patient_id)     as patient_sk,
    patient_id,
    first_name,
    last_name,
    gender,
    date_of_birth,
    contact_number,
    address,
    insurance_provider,
    insurance_number,
    email
from {{ ref('ss_stg_patients') }}
