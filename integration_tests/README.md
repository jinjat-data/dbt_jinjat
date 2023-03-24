# Integration tests for dbt_jinjat

# Running locally

```bash
dbt deps && dbt seed && dbt run
```

You should have `jaffle_shop.duckdb` file in your main directory when you run the dbt. Now we can run Jinjat:


```
jinjat serve
```