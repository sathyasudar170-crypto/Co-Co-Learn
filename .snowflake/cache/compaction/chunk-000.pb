
û
	README.mdÁWelcome to your new dbt project!

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
™ºð× d3426972da809704f17cf683a4b2578b
ú
&models/staging/ss_stg_appointments.sql£{{ config(materialized='view') }}

with source as (

    select * from {{ source('healthcare_raw', 'SOURCE_APPOINTMENTS') }}

),

renamed as (

    select
        appointment_id,
        patient_id,
        doctor_id,
        appointment_date,
        appointment_time,
        nullif(trim(reason_for_visit), '') as reason_for_visit,
        nullif(trim(status), '') as status

    from source

)

select * from renamed*
¯Ãð× d9400625d261ddc4ca18365b3ddb65b0
O
!models/staging/ss_stg_billing.sql*
™ºð× 4abeda7c7f58f2fa1927195a35c7fb48
O
!models/staging/ss_stg_doctors.sql*
™ºð× 3de83c6829f1b9dd046f76dc13997bc8
P
"models/staging/ss_stg_patients.sql*
™ºð× e57863dd97bc7944b2ae43327fe35988
R
$models/staging/ss_stg_treatments.sql*
™ºð× c80d0903f686623b71f8f06536f08a0c
Ž
dbt_project.ymlÎ
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
      +materialized: table
*
™ºð× 7f32ae7d1b910b82a4155db932aed006
ê
!models/staging/src_healthcare.yml˜
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
™ºð× 15d9466bc8c561bf05dfeb38e8e6b9b2