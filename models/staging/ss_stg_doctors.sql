
{{ config(
    materialized='view',
    schema='PRACTICE'
) }}

with source as (

    select * from {{ source('healthcare_raw', 'SOURCE_DOCTORS') }}

),

renamed as (

    select
        nullif(trim(doctor_id), '')        as doctor_id,
        nullif(trim(first_name), '')       as first_name,
        nullif(trim(last_name), '')        as last_name,
        nullif(trim(specialization), '')   as specialization,
        trim(to_varchar(phone_number))     as phone_number,
        years_experience::integer          as years_experience,
        nullif(trim(hospital_branch), '')  as hospital_branch,
        lower(nullif(trim(email), ''))     as email

    from source

)

select * from renamed
