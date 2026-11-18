{{ config(
    materialized='view',
    schema='PRACTICE'
) }}

with source as (

    select * from {{ source('healthcare_raw', 'SOURCE_APPOINTMENTS') }}

),

renamed as (

    select
        nullif(trim(appointment_id), '')   as appointment_id,
        nullif(trim(patient_id), '')       as patient_id,
        nullif(trim(doctor_id), '')        as doctor_id,
        appointment_date::date             as appointment_date,
        appointment_time::time             as appointment_time,
        nullif(trim(reason_for_visit), '') as reason_for_visit,
        nullif(trim(status), '')           as status

    from source

)

select * from renamed