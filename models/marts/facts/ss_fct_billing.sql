{{ config(materialized='table', schema='PRACTICE') }}

select
    -- billing
    b.bill_id,
    b.bill_date,
    b.amount,
    b.payment_method,
    b.payment_status,

    -- dimension surrogate keys
    dp.patient_sk,
    dd.doctor_sk,
    dt.treatment_sk,

    -- date keys
    ddt_bill.date_key                   as bill_date_key,
    ddt_treat.date_key                  as treatment_date_key,

    -- business keys for traceability
    b.patient_id,
    b.doctor_id,
    b.treatment_id,

    -- treatment cost from intermediate
    b.treatment_cost,

    -- fact measure
    1                                   as bill_count

from {{ ref('ss_int_billing_details') }} as b
left join {{ ref('ss_dim_patients') }} as dp
    on b.patient_id = dp.patient_id
left join {{ ref('ss_dim_doctors') }} as dd
    on b.doctor_id = dd.doctor_id
left join {{ ref('ss_dim_treatments') }} as dt
    on b.treatment_id = dt.treatment_id
left join {{ ref('ss_dim_date') }} as ddt_bill
    on b.bill_date = ddt_bill.full_date
left join {{ ref('ss_dim_date') }} as ddt_treat
    on b.treatment_date = ddt_treat.full_date
