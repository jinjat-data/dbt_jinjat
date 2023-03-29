# jinjat-dbt ([dbt Docs](https://jinjat-data.github.io/dbt_jinjat/))

Macros that are used by [Jinjat](https://jinjat.com) to operate. 

# Contents
- [jinjat-dbt](#jinjat-dbt)
- [Contents](#contents)
- [Installation instructions](#installation-instructions)
- [Macros](#macros)
  - [Constructing queries](#constructing-queries)
    - [limit_query](#limit-query)
    - [generate_select](#generate-select)
    - [generate_where](#generate-where)
    - [limit_query](#limit-query)
  - [request (source)](#refine_app-source)
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

## Constructing queries

### limit_query ([source](macros/query/construct_select.sql))
This macro takes a SQL query as a parameter and applies LIMIT to it.

#### Arguments
* `sql` (required): The SQL query that you want to apply the limit
* `limit` (required): The limit

#### Usage:

```
$ dbt run-operation limit_query --args 'sql: "select * from customer", limit: 1000'

> select * from (select * from customer) limit 1000
```

### generate_select ([source](macros/query/construct_select.sql))
This macro generates the inner body of SELECT. It takes an array of columns and quotes them. 

#### Arguments
* `selects`: An array of columns to quote, the default is `[*]`

#### Usage:

```
$ dbt run-operation generate_select --args 'selects: [col1, col2]'

> "col1", "col2"
```

### generate_where ([source](macros/query/construct_select.sql))
This macro takes an object with `and`, `or` properties and generates a boolean expression that can be used in a WHERE statement. The object can be nested.

#### Arguments
* `filter`: An object that has `and` or `or` properties. Ex: {and: [{field: 'customer_type', operator: 'equals', value: ''}, {or: []}]}

#### Usage:

```
$ dbt run-operation generate_where --args 'filter: {or: []}'

> 
```

### quote_identifier ([source](macros/query/quote.sql))
Quotes table and column identifiers.

#### Arguments
* `value`: The identifier to quote. col1, table_ref, etc.


### quote_literal ([source](macros/query/quote.sql))
Quotes string and number literals

#### Arguments
* `value`: The identifier to quote. col1, table_ref, etc.