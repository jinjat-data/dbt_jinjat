FROM jinjat/jinjat:latest

RUN apt update -qq && \
    apt install -y build-essential curl git wget gcc

RUN poetry add dbt-duckdb@^1.5.0 && poetry install

COPY ./ /project

ENV DBT_PROJECT_DIR=/project/integration_tests
ENV DBT_PROFILES_DIR=/project/integration_tests
ENV DUCKDB_DATABASE_PATH=/project/integration_tests/duckdb.db

RUN poetry run dbt deps && poetry run dbt seed && poetry run dbt run

ENTRYPOINT ["poetry", "run", "jinjat", "serve"]