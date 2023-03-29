# jinjat-dbt ([dbt Docs](https://jinjat-data.github.io/dbt_jinjat/))

Official macros provided by [Jinjat](https://jinjat.com). 

# Contents
- [jinjat-dbt](#jinjat-dbt)
- [Contents](#contents)
- [Installation instructions](#installation-instructions)
- [Macros](#macros)
  - [`request`](#refine_app-source)
  - [Utility](#utility-macros)
    - [limit_query](#limit_query-source)
    - [generate_select](#generate_select-source)
    - [generate_where](#generate_where-source)
    - [limit_query](#limit_query-source)
  - [Generators](#generators)
    - [refine_app](#refine_app-source)
    - [metrics_query](#metrics-source)

# Installation instructions

New to dbt packages? Read more about them [here](https://docs.getdbt.com/docs/building-a-dbt-project/package-management/).

1. Include this package in your `packages.yml` file — check [here](https://hub.getdbt.com/jinjat-data/jinjat_dbt/latest/) for the latest version number:
```yml
packages:
  - package: jinjat-data/jinjat_dbt
    version: X.X.X ## update to the latest version here
```
2. Run `dbt deps` to install the package.

# Macros

## `request` ([source](macros/query/core/request.sql))

It's the HTTP routing macro for Jinjat that you use in [analyses files](https://docs.getdbt.com/docs/build/analyses). The arguments that you will pass to the macro will be used by dbt to compile your analysis files. If you have the [definition the OpenAPI spec](/reference/openapi#dbt-analysis) for your analysis files, Jinjat automatically generates the test values for you.

> While the following arguments are optional, you need to use them to make sure dbt compiles. Therefore; you at least need to define OpenAPI spec (recommended) or pass values that make dbt compile.

#### Arguments
* `method`: The HTTP status code. Can be one of GET, POST, PUT, PATCH, DELETE and OPTIONS. If not defined, Jinjat will forward all the status codes to the analysis
* `query`: A dictionary of query parameters
* `body`: The body payload of the HTTP request
* `headers`: A dictionary of HTTP headers
* `params`: A dictionary of path parameters

#### Usage:

Let's say you have `./analyses/example_endpoint.sql` file as follows:

```sql
{%- set query_params = request(query={"status": "shipped"}).query %}

select  order_date, 
        count(*) as orders, 
        count(distinct customer_id) as users
from {{ ref('orders') }} 
group by order_date
where status = '{{query_params.status}}'
```

Let's compile your analysis:

```bash
$ dbt compile

```

Now, let's look at the `target/analyses/example_endpoint.sql`. We should see something similar to:

```sql
select  order_date, 
        count(*) as orders, 
        count(distinct customer_id) as users
from orders
group by order_date
where status = 'shipped'
```

> Jinjat will patch this macro when you start Jinjat with `jinjat serve` to return the user HTTP request data instead of the parameters that you pass as arguments.

---

## Utility Macros

The utility macros let you construct SELECT queries easily.

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
$ dbt run-operation generate_where --args 'filter: {and: [{field: 'customer_type', operator: 'equals', value: 'premium'}, {or: [{field: 'country', operator: 'equals', value: 'USA'}, {field: 'gender', operator: 'equals', value: 'male'}]}]}'

> customer_type = 'premium' AND (country = 'USA' OR gender = 'male')
``` 

### quote_identifier ([source](macros/query/quote.sql))
Quotes table and column identifiers.

#### Arguments
* `value`: The identifier to quote. col1, table_ref, etc.


### quote_literal ([source](macros/query/quote.sql))
Quotes string and number literals.

#### Arguments
* `value`: The identifier to quote. col1, table_ref, etc.

---

## Generators

### refine_app ([source](macros/generator/refine_app/refine_app.sql))



```
$ jinjat generate refine_app --args 'to: ref("customers")'

                               
└── analyses
    └── crud
        ├── _list_customers.sql ✔️
        ├── _id
        │   └── _get_customers.sql ✔️
        └── schema.yml ✔️
3 files will be created. Type enter to continue >
``` 

### metrics_query ([source](macros/generator/metrics/metrics_query.sql))

```
$ jinjat generate metrics_query --args 'metric_name: revenue'

                               
└── analyses
    └── metrics
        ├── revenue.sql ✔️
        └── schema.yml ✔️
2 files will be created. Type enter to continue >
``` 