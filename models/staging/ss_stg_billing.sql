{{ config(
    materialized='view',
    schema='PRACTICE'
) }}

with source as (

    select
        bill_id,
        patient_id,
        treatment_id,
        bill_date,
        amount,
        payment_method,
        payment_status
    from {{ source('healthcare_raw', 'SOURCE_BILLING') }}

),

renamed as (

    select
        nullif(trim(bill_id), '')          as bill_id,
        nullif(trim(patient_id), '')       as patient_id,
        nullif(trim(treatment_id), '')     as treatment_id,
        bill_date::date                    as bill_date,
        amount::number(12,2)               as amount,
        nullif(trim(payment_method), '')   as payment_method,
        nullif(trim(payment_status), '')   as payment_status

    from source

)

select
    bill_id,
    patient_id,
    treatment_id,
    bill_date,
    amount,
    payment_method,
    payment_status
from renamed
