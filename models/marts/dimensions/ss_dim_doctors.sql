{{ config(materialized='table', schema='PRACTICE') }}

select
    md5(doctor_id)      as doctor_sk,
    doctor_id,
    first_name,
    last_name,
    specialization,
    phone_number,
    years_experience,
    hospital_branch,
    email
from {{ ref('ss_stg_doctors') }}
