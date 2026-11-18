{{ config(materialized='table', schema='PRACTICE') }}

with all_dates as (

    select appointment_date as dt from {{ ref('ss_stg_appointments') }} where appointment_date is not null
    union
    select bill_date as dt from {{ ref('ss_stg_billing') }} where bill_date is not null
    union
    select treatment_date as dt from {{ ref('ss_stg_treatments') }} where treatment_date is not null
    union
    select date_of_birth as dt from {{ ref('ss_stg_patients') }} where date_of_birth is not null
    union
    select registration_date as dt from {{ ref('ss_stg_patients') }} where registration_date is not null

)

select
    to_number(to_char(dt, 'YYYYMMDD'))  as date_key,
    dt                                  as full_date,
    year(dt)                            as year,
    quarter(dt)                         as quarter,
    month(dt)                           as month_number,
    monthname(dt)                       as month_name,
    day(dt)                             as day_number,
    dayname(dt)                         as day_name,
    case when dayofweek(dt) in (0, 6) then true else false end as is_weekend
from all_dates
