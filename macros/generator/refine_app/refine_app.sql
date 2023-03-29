{% macro refine_app(to, out_dir, model_name) %}
    {% if not to.startswith('ref(') and not to.startswith('source(') %}
        {{ exceptions.raise_compiler_error(to ~ " is not valid, you can only `ref('seed_or_model')` and `source('source_name', 'table_name')` supported") }}
    {% endif %}
    
    {% set is_read_only = to.startswith('ref(') %}

    {% set files = {
            "analyses/" ~ out_dir ~ "/_list_" ~ model_name ~ ".sql": generate_jinjat_refine_app_list(to),
            "analyses/" ~ out_dir ~ "/_id/_get_" ~ model_name ~ ".sql": generate_jinjat_refine_app_get(to),
            "analyses/" ~ out_dir ~ "/schema.yml": generate_refine_jinjat_app_yml(to, is_read_only),
       }
    %}

    {% if not is_read_only %}
        {% do files.update({
            "analyses/" ~ out_dir ~ "/_create_" ~ model_name ~ ".sql": generate_jinjat_refine_app_create(to),
            "analyses/" ~ out_dir ~ "/_id/_delete_" ~ model_name ~ ".sql": generate_jinjat_refine_app_delete(to),
            "analyses/" ~ out_dir ~ "/_id/_patch_" ~ model_name ~ ".sql": generate_jinjat_refine_app_path(to),
        }) %}
    {% endif %}

    {{ return(files)}}

{% endmacro %}