{{ config(materialized='table', schema='PRACTICE') }}

select
    -- appointment
    appt.appointment_id,
    appt.appointment_date,
    appt.appointment_time,
    appt.status,

    -- dimension surrogate keys
    dp.patient_sk,
    dd.doctor_sk,

    -- date key
    ddt.date_key                        as appointment_date_key,

    -- business keys for traceability
    appt.patient_id,
    appt.doctor_id,

    -- aggregated treatment measures from intermediate
    appt.treatment_count,
    appt.total_treatment_cost,
    appt.earliest_treatment_date,
    appt.latest_treatment_date,

    -- fact measure
    1                                   as appointment_count

from {{ ref('ss_int_appointment_details') }} as appt
left join {{ ref('ss_dim_patients') }} as dp
    on appt.patient_id = dp.patient_id
left join {{ ref('ss_dim_doctors') }} as dd
    on appt.doctor_id = dd.doctor_id
left join {{ ref('ss_dim_date') }} as ddt
    on appt.appointment_date = ddt.full_date
