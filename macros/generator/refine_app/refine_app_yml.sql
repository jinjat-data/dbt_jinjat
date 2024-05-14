{% macro _generate_refine_jinjat_app_yml(to_resource, is_read_only) %}
version: 2

exposures:
  - name: crud
    type: application
    owner:
      name: ""
      email: ""
    meta:
      jinjat:
        refine:
          {%- if not is_read_only -%}
          actions:
            delete: _delete_customers
          {%- endif -%}
          resources:
            create: _create_customers
            list: _list_customers
            show: _get_customer
            edit: _patch_customers

analyses:
  - name: _list_customers
    description: List customers
    config:
      jinjat:
        method: get
        openapi:
          responses:
            200:
              description: OK
              content:
                application/json:
                  schema:
                    type: array
                    items:
                        $ref: "#/components/schemas/{{'model.' ~ project_name ~ '.customers'}}"
          parameters:
            - in: query
              name: sort
              schema:
                type: array
                items:
                  type: object
                  properties:
                    asc: 
                      type: boolean
                    field: 
                      type: string
            - in: query
              name: select
              schema:
                type: array
                items:
                  type: string
            - in: query
              name: filter
              schema:
                type: string
                -- $ref: "#/components/schemas/filter"
  - name: _create_customers
    description: Create customers
    config:
      jinjat:
        method: post
        fetch: false
        openapi:
          requestBody:
            content:
              application/json:
                schema:
                  $ref: "#/components/schemas/{{'model.' ~ project_name ~ '.customers'}}"
  - name: _get_customer
    description: Get customers
    config:
      jinjat:
        method: get
        transform:
          response:
            - jmespath: $[0]
        openapi:
          responses:
            200:
              description: OK
              content:
                application/json:
                  $ref: "#/components/schemas/{{'model.' ~ project_name ~ '.customers'}}"
  - name: _delete_customers
    description: Delete customers
    config:
      jinjat:
        method: delete
        fetch: false
  - name: _patch_customers
    description: Patch customers
    config:
      jinjat:
        method: patch
        fetch: false
        request_body: ref("customers")
        openapi:
          requestBody:
              content:
                application/json:
                  schema:
                    $ref: "#/components/schemas/{{'model.' ~ project_name ~ '.customers'}}"
{% endmacro %}