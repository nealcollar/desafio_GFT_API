FROM python:3.11-slim

ENV LOG_LEVEL=trace
ENV SET_ENV=PIPE

# Instalar dependências do sistema
RUN apt-get update && \
    apt-get install -y curl --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#Instalar poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

ENV PATH="/root/.local/bin:$PATH"

WORKDIR /api-automation

#Separando quais arquivos preciso copiar
COPY resource /api-automation/resource
COPY tests /api-automation/tests
COPY pyproject.toml /api-automation/
COPY run_tests.py /api-automation/

RUN poetry install

CMD ["poetry", "run", "api"]