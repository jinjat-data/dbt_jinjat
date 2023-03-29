{% macro quote_identifier(value) %}
    {% set col_name = adapter.dispatch('quote_identifier', 'jinjat')(value) %}
    {{ return(col_name) }}
{% endmacro %}

{% macro default__quote_identifier(identifier) %}
    {% set quoted_identifier = '"' + identifier + '"' %}
    {{ return(quoted_identifier) }}
{% endmacro %}

{% macro quote_literal(value) %}
    {% set literal_value = adapter.dispatch('quote_literal_value', 'jinjat')(value) %}
    {{ return(literal_value) }}
{% endmacro %}

{% macro default__quote_literal_value(value) %}
    {% if value is not defined %}
        {{ return('NULL') }}
    {% else %}
        {% set value_native = value | as_native %}
        {% if value_native == True or value_native == False %}
            {{ return(value_native) }}
        {% else %}
            {% set value_str = value ~ ''  %}
            {% if modules.re.match('^\d+$', value_str) %}
                {{ return(value) }}
            {% else %}
                {% set quoted_value = "'" + modules.re.sub(
                    "\'",
                    "''",
                    value_str
                ) + "'" %}
                {{ return(quoted_value) }}
            {% endif %}
        {% endif %}
    {% endif %}
{% endmacro %}
