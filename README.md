# jinjat-dbt ([dbt Docs](https://jinjat-data.github.io/dbt_jinjat/))

Macros that are used by [Jinjat](https://jinjat.com) to operate. 

# Contents
- [jinjat-dbt](#jinjat-dbt)
- [Contents](#contents)
- [Installation instructions](#installation-instructions)
- [Macros](#macros)
  - [request (source)](#refine_app-source)
    - [Arguments:](#arguments)
    - [Usage:](#usage)
  - [refine_app (source)](#refine_app-source)
    - [Arguments:](#arguments-1)
    - [Usage:](#usage-1)
  - [ (source)](#refine_app-source)
    - [Arguments:](#arguments-1)
    - [Usage:](#usage-1)

# Installation instructions

New to dbt packages? Read more about them [here](https://docs.getdbt.com/docs/building-a-dbt-project/package-management/).

1. Include this package in your `packages.yml` file — check [here](https://hub.getdbt.com/jinjat-data/jinjat_dbt/latest/) for the latest version number:
```yml
packages:
  - package: jinjat-data/jinjat_dbt
    version: X.X.X ## update to latest version here
```
2. Run `dbt deps` to install the package.

# Macros
## generate_source ([source](macros/generate_source.sql))
This macro generates lightweight YAML for a [Source](https://docs.getdbt.com/docs/using-sources),
which you can then paste into a schema file.

### Arguments
* `schema_name` (required): The schema name that contains your source data
* `database_name` (optional, default=target.database): The database that your
source data is in.
* `table_names` (optional, default=none): A list of tables that you want to generate the source definitions for.
* `generate_columns` (optional, default=False): Whether you want to add the
column names to your source definition.
* `include_descriptions` (optional, default=False): Whether you want to add 
description placeholders to your source definition.
* `include_data_types` (optional, default=False): Whether you want to add data
types to your source columns definitions.
* `table_pattern` (optional, default='%'): A table prefix / postfix that you
want to subselect from all available tables within a given schema.
* `exclude` (optional, default=''): A string you want to exclude from the selection criteria
* `name` (optional, default=schema_name): The name of your source

### Usage:
1. Copy the macro into a statement tab in the dbt Cloud IDE, or into an analysis file, and compile your code

```
{{ codegen.generate_source('raw_jaffle_shop') }}
```

Alternatively, call the macro as an [operation](https://docs.getdbt.com/docs/using-operations):

```
$ dbt run-operation generate_source --args 'schema_name: raw_jaffle_shop'
```

or

```
# for multiple arguments, use the dict syntax
$ dbt run-operation generate_source --args '{"schema_name": "jaffle_shop", "database_name": "raw", "table_names":["table_1", "table_2"]}'
```

Including data types:

```
$ dbt run-operation generate_source --args '{"schema_name": "jaffle_shop", "generate_columns": "true", "include_data_types": "true"}'
```

2. The YAML for the source will be logged to the command line

```
version: 2

sources:
  - name: raw_jaffle_shop
    database: raw
    tables:
      - name: customers
        description: ""
      - name: orders
        description: ""
      - name: payments
        description: ""
```

3. Paste the output in to a schema `.yml` file, and refactor as required.
