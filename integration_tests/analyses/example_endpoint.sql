{%- set query = jinjat.request().query %}

select 1 as test where 1 = {{query.number or 1}}