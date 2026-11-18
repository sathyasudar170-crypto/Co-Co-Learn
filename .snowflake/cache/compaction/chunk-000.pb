
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
∏›Ù◊ ec232c16d7110bbfc31ac4e65f972f41
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
∏›Ù◊ ab10ab543885ac068b52221feef7c88b
`
2models/intermidiate/ss_int_appointment_details.sql*
∏›Ù◊ f08efad5ed45eaaf8ce1bb8ad56dfcdc
\
.models/intermidiate/ss_int_billing_details.sql*
∏›Ù◊ 010ae461a65be4fd6bae26839906765a
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
∏›Ù◊ fea5fdac7e98b4cb3d271e0dab621908
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
∏›Ù◊ 80ef63abb4b2f02d5059ce5766d78df9
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
∏›Ù◊ 1843c86030ecd3c5c7644c9d98917bcd
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
∏›Ù◊ 79e0d11b8dc0f2cf26dbca4a43ac637e
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
∏›Ù◊ a6db94f1044f64d97d77a135bee1cd81
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
∏›Ù◊ 042d29623153fbe67f4c04525b83bfa9
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
∏›Ù◊ a098f5eec33dcf1eff288b9a6d79c3d9