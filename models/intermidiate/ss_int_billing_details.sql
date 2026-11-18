{{ config(materialized='view', schema='PRACTICE') }}

with billing as (

    select
        bill_id,
        patient_id,
        treatment_id,
        bill_date,
        amount,
        payment_method,
        payment_status
    from {{ ref('ss_stg_billing') }}

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

treatments as (

    select
        treatment_id,
        appointment_id,
        treatment_type,
        description     as treatment_description,
        cost            as treatment_cost,
        treatment_date
    from {{ ref('ss_stg_treatments') }}

),

appointments as (

    select
        appointment_id,
        doctor_id,
        appointment_date,
        appointment_time,
        reason_for_visit,
        status          as appointment_status
    from {{ ref('ss_stg_appointments') }}

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

)

select
    -- billing
    b.bill_id,
    b.bill_date,
    b.amount,
    b.payment_method,
    b.payment_status,

    -- patient
    b.patient_id,
    p.patient_first_name,
    p.patient_last_name,
    p.gender,
    p.date_of_birth,
    p.contact_number,
    p.address,
    p.insurance_provider,
    p.insurance_number,
    p.patient_email,

    -- treatment
    b.treatment_id,
    t.treatment_type,
    t.treatment_description,
    t.treatment_cost,
    t.treatment_date,

    -- appointment (via treatment)
    t.appointment_id,
    ap.appointment_date,
    ap.appointment_time,
    ap.reason_for_visit,
    ap.appointment_status,

    -- doctor (via appointment)
    ap.doctor_id,
    d.doctor_first_name,
    d.doctor_last_name,
    d.specialization,
    d.doctor_phone_number,
    d.years_experience,
    d.hospital_branch,
    d.doctor_email

from billing as b
left join patients as p
    on b.patient_id = p.patient_id
left join treatments as t
    on b.treatment_id = t.treatment_id
left join appointments as ap
    on t.appointment_id = ap.appointment_id
left join doctors as d
    on ap.doctor_id = d.doctor_id
