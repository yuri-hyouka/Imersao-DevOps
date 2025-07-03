# Use uma imagem oficial do Python como imagem base.
# FROM python:3.10-slim
FROM python:3.13.5-slim-bookworm

# Define o diretório de trabalho dentro do container.
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
# Copiar este arquivo separadamente aproveita o cache de camadas do Docker.
COPY requirements.txt .

# Instala as dependências.
# --no-cache-dir: Desabilita o cache do pip, o que pode reduzir o tamanho da imagem.
# --upgrade pip: Garante que estamos usando a versão mais recente do pip.
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta 8000 para permitir a comunicação com a aplicação.
EXPOSE 8000

# Comando para executar a aplicação quando o container for iniciado.
# O host 0.0.0.0 torna a aplicação acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

