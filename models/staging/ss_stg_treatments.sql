{{ config(
    materialized='view',
    schema='PRACTICE'
) }}

with source as (

    select * from {{ source('healthcare_raw', 'SOURCE_TREATMENTS') }}

),

renamed as (

    select
        nullif(trim(treatment_id), '')     as treatment_id,
        nullif(trim(appointment_id), '')   as appointment_id,
        nullif(trim(treatment_type), '')   as treatment_type,
        nullif(trim(description), '')      as description,
        cost::number(12,2)                 as cost,
        treatment_date::date               as treatment_date

    from source

)

select * from renamed
