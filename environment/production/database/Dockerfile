FROM postgres:17.4-bullseye

# Define variáveis de ambiente para criar usuário e senha automaticamente
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

# Define um diretório de trabalho
WORKDIR /docker-entrypoint-initdb.d/

# Copia um script SQL opcional para inicialização (se necessário)
# COPY init.sql /docker-entrypoint-initdb.d/

# Expondo a porta padrão do PostgreSQL
EXPOSE 5432
