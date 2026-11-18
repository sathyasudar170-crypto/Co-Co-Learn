
˚
	README.md¡Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
*
ﬁÙ◊ cf3bc63e1153390947590443cf0dfbdf
´
*models/marts/facts/ss_fct_appointments.sql–{{ config(materialized='table', schema='PRACTICE') }}

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
*
Ü˘Ù◊ e25813b6f895ee84013d1aa57f03cfca
•	
%models/marts/facts/ss_fct_billing.sqlœ{{ config(materialized='table', schema='PRACTICE') }}

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
*
Ü˘Ù◊ 30c58e95441d10170808b426a902a528
o
Untitled.sql3select * from coco_practice_db.practice.ss_dim_date*
´ıÙ◊ 3f1493aada762d9d4a7e30a3afad0e74
—	
'models/marts/dimensions/ss_dim_date.sql˘{{ config(materialized='table', schema='PRACTICE') }}

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
*
öÛÙ◊ 679a7da2f87f93da3d5f2258f0dac30f
—
-models/marts/dimensions/ss_dim_treatments.sqlÛ{{ config(materialized='table', schema='PRACTICE') }}

select
    md5(treatment_id)   as treatment_sk,
    treatment_id,
    appointment_id,
    treatment_type,
    description,
    cost,
    treatment_date
from {{ ref('ss_stg_treatments') }}
*
îÛÙ◊ e0cd7639aa15a157f8a8bde821b507d6
È
*models/marts/dimensions/ss_dim_doctors.sqlé{{ config(materialized='table', schema='PRACTICE') }}

select
    md5(doctor_id)      as doctor_sk,
    doctor_id,
    first_name,
    last_name,
    specialization,
    phone_number,
    years_experience,
    hospital_branch,
    email
from {{ ref('ss_stg_doctors') }}
*
êÛÙ◊ 91086876886085382bf806851c5becf3
ä
+models/marts/dimensions/ss_dim_patients.sqlÆ{{ config(materialized='table', schema='PRACTICE') }}

select
    md5(patient_id)     as patient_sk,
    patient_id,
    first_name,
    last_name,
    gender,
    date_of_birth,
    contact_number,
    address,
    insurance_provider,
    insurance_number,
    email
from {{ ref('ss_stg_patients') }}
*
ÇÛÙ◊ ceb4621c39daf2cb2106b492824a13d2
æ
macros/generate_schema_name.sqlÓ
{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- if custom_schema_name is not none -%}
        {{ custom_schema_name | trim }}
    {%- else -%}
        {{ target.schema }}
    {%- endif -%}

{%- endmacro %}
*
ﬁÙ◊ aab72ad9cd4df8e6e658d9a7f07948db
»
2models/intermidiate/ss_int_appointment_details.sqlÂ{{ config(materialized='view', schema='PRACTICE') }}

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

)

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

    -- treatments (aggregated)
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
*
ﬁÙ◊ 0e5cb0a218f93ade1e577a7525d6054f
Ó
.models/intermidiate/ss_int_billing_details.sqlè{{ config(materialized='view', schema='PRACTICE') }}

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
*
ﬁÙ◊ b4a89b4c3e0cc5ca6fd461e36fe48fc6
ﬂ
&models/staging/ss_stg_appointments.sqlà{{ config(
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

select * from renamed*
ﬁÙ◊ 34ba3644de2c50fd18f5bb699077e772
‚
!models/staging/ss_stg_billing.sqlê{{ config(
    materialized='view',
    schema='PRACTICE'
) }}

with source as (

    select * from {{ source('healthcare_raw', 'SOURCE_BILLING') }}

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

select * from renamed
*
ﬁÙ◊ d8eb8f868f521176e8cba0c46b57ea22
ß
!models/staging/ss_stg_doctors.sql’
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
*
ﬁÙ◊ 677392731413b4b349bf0c075680051e
˛
"models/staging/ss_stg_patients.sql´{{ config(
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
*
ﬁÙ◊ bbe3ff66a630be3e94ab88d485f1998d
¥
$models/staging/ss_stg_treatments.sqlﬂ{{ config(
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
*
ﬁÙ◊ fa6ff93fa68b20fe1641ec6d0a6359bb
ç
dbt_project.ymlÕ
# Name your project! Project names should contain only lowercase characters
# and underscores. A good package name should reflect your organization's
# name or the intended use of these models
name: 'my_new_project'
version: '1.0.0'
config-version: 2

# This setting configures which "profile" dbt uses for this project.
profile: 'default'

# These configurations specify where dbt should look for different types of files.
# The `model-paths` config, for example, states that models in this project can be
# found in the "models/" directory. You probably won't need to change these!
model-paths: ["models"]
analysis-paths: ["analyses"]
test-paths: ["tests"]
seed-paths: ["seeds"]
macro-paths: ["macros"]
snapshot-paths: ["snapshots"]

target-path: "target"  # directory which will store compiled SQL files
clean-targets:         # directories to be removed by `dbt clean`
  - "target"
  - "dbt_packages"


# Configuring models
# Full documentation: https://docs.getdbt.com/docs/configuring-models

# In dbt, the default materialization for a model is a view. This means, when you run 
# dbt run or dbt build, all of your models will be built as a view in your data platform. 
# The configuration below will override this setting for models in the example folder to 
# instead be materialized as tables. Any models you add to the root of the models folder will 
# continue to be built as views. These settings can be overridden in the individual model files
# using the `{{ config(...) }}` macro.

models:
  my_new_project:
    # Applies to all files under models/example/
    example:
      +materialized: view
*
ﬁÙ◊ 3077c845d034ad3d886cdcd60a76d09f
Í
!models/staging/src_healthcare.ymlò
version: 2

sources:
  - name: healthcare_raw
    database: COCO_PRACTICE_DB
    schema: PRACTICE

    tables:
      - name: SOURCE_APPOINTMENTS
      - name: SOURCE_BILLING
      - name: SOURCE_DOCTORS
      - name: SOURCE_PATIENTS
      - name: SOURCE_TREATMENTS
*
ﬁÙ◊ b1993d852055200a75686abdabb8f3b2