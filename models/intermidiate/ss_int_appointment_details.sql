{{ config(materialized='view', schema='PRACTICE') }}

-- Grain: one row per appointment, identified by appointment_id.
-- Treatments are pre-aggregated to avoid fan-out from the one-to-many
-- relationship between appointments and treatments.

with appointments as (

    select
        appointment_id,
        patient_id,
        doctor_id,
        appointment_date,
        appointment_time,
        reason_for_visit,
        status
    from {{ ref('ss_stg_appointments') }}

),

patients as (

    select
        patient_id,
        first_name  as patient_first_name,
        last_name   as patient_last_name,
        gender,
        date_of_birth,
        contact_number,
        address,
        insurance_provider,
        insurance_number,
        email       as patient_email
    from {{ ref('ss_stg_patients') }}

),

doctors as (

    select
        doctor_id,
        first_name      as doctor_first_name,
        last_name       as doctor_last_name,
        specialization,
        phone_number    as doctor_phone_number,
        years_experience,
        hospital_branch,
        email           as doctor_email
    from {{ ref('ss_stg_doctors') }}

),

treatments_agg as (

    select
        appointment_id,
        count(*)                as treatment_count,
        sum(cost)               as total_treatment_cost,
        min(treatment_date)     as earliest_treatment_date,
        max(treatment_date)     as latest_treatment_date
    from {{ ref('ss_stg_treatments') }}
    group by appointment_id

),

joined as (

    select
        -- appointment
        a.appointment_id,
        a.appointment_date,
        a.appointment_time,
        a.reason_for_visit,
        a.status,

        -- patient
        a.patient_id,
        p.patient_first_name,
        p.patient_last_name,
        p.gender,
        p.date_of_birth,
        p.contact_number,
        p.address,
        p.insurance_provider,
        p.insurance_number,
        p.patient_email,

        -- doctor
        a.doctor_id,
        d.doctor_first_name,
        d.doctor_last_name,
        d.specialization,
        d.doctor_phone_number,
        d.years_experience,
        d.hospital_branch,
        d.doctor_email,

        -- treatments (aggregated to preserve appointment grain)
        coalesce(t.treatment_count, 0)  as treatment_count,
        t.total_treatment_cost,
        t.earliest_treatment_date,
        t.latest_treatment_date

    from appointments as a
    left join patients as p
        on a.patient_id = p.patient_id
    left join doctors as d
        on a.doctor_id = d.doctor_id
    left join treatments_agg as t
        on a.appointment_id = t.appointment_id

)

select
    appointment_id,
    appointment_date,
    appointment_time,
    reason_for_visit,
    status,
    patient_id,
    patient_first_name,
    patient_last_name,
    gender,
    date_of_birth,
    contact_number,
    address,
    insurance_provider,
    insurance_number,
    patient_email,
    doctor_id,
    doctor_first_name,
    doctor_last_name,
    specialization,
    doctor_phone_number,
    years_experience,
    hospital_branch,
    doctor_email,
    treatment_count,
    total_treatment_cost,
    earliest_treatment_date,
    latest_treatment_date
from joined
