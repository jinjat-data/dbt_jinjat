{% macro generate_metrics_query(metric_name) %}
    {%- set req = request({"params": {"metric": "revenue"}}) %}
    {%- set query_params = req.query %}

    select * 
    from {{ metrics.calculate(
        metric(req.params.metric),
        grain=query_params.grain,
        dimensions=['customer_status']
    ) }}
{% endmacro %}

{% macro metrics_single_query(metric_name, out) %}
    {% set files = {
            out or "": generate_metrics_query(metric_name)
       }
    %}

    {{ return(files) }}
{% endmacro %}