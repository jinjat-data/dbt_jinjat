{% macro refine_app(to) %}
    {% if not to.startswith('ref(') and not to.startswith('source(') %}
        {{ exceptions.raise_compiler_error(to ~ " is not valid, you can only `ref('seed_or_model')` and `source('source_name', 'table_name')` supported") }}
    {% endif %}
    
    {% set is_read_only = to.startswith('ref(') %}

    {% set files = {
            "analyses/crud/_list_customers.sql": generate_jinjat_refine_app_list(to),
            "analyses/crud/_id/_get_customers.sql": generate_jinjat_refine_app_get(to),
            "analyses/crud/schema.yml": generate_refine_jinjat_app_yml(to, is_read_only),
       }
    %}

    {% if not is_read_only %}
        {% do files.update({
            "analyses/crud/_create_customers.sql": generate_jinjat_refine_app_create(to),
            "analyses/crud/_id/_delete_customers.sql": generate_jinjat_refine_app_delete(to),
            "analyses/crud/_id/_patch_customers.sql": generate_jinjat_refine_app_path(to),
        }) %}
    {% endif %}

    {{ return(files)}}

{% endmacro %}