{{ config(
    materialized='view',
    schema='PRACTICE'
) }}

with source as (

    select * from {{ source('healthcare_raw', 'SOURCE_PATIENTS') }}

),

renamed as (

    select
        nullif(trim(patient_id), '')          as patient_id,
        nullif(trim(first_name), '')          as first_name,
        nullif(trim(last_name), '')           as last_name,
        nullif(trim(gender), '')              as gender,
        date_of_birth::date                   as date_of_birth,
        trim(to_varchar(contact_number))      as contact_number,
        nullif(trim(address), '')             as address,
        registration_date::date               as registration_date,
        nullif(trim(insurance_provider), '')  as insurance_provider,
        nullif(trim(insurance_number), '')    as insurance_number,
        lower(nullif(trim(email), ''))        as email

    from source

)

select * from renamed
