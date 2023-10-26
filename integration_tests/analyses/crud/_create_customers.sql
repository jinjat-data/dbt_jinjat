{%- set payload = jinjat.request().body %}
INSERT INTO
    {{ ref('customers') }}
    ({% for key, value in payload.items() %}
        {{ jinjat.quote_identifier(key) }}

        {% if not loop.last %},{% endif %}
    {% endfor %})
VALUES
    ({% for key, value in payload.items() %}
        {{ jinjat.quote_literal(value) }}

        {% if not loop.last %},{% endif %}
    {% endfor %})