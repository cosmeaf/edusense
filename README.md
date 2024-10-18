
# Edusense Scraper Application

## Finalidade

Este projeto é um **Scraper** que coleta dados sobre lições e usuários de uma plataforma de ensino, salvando ou atualizando as informações em um banco de dados PostgreSQL. Ele realiza login na plataforma, faz requisições HTTP e processa os dados obtidos, que são então armazenados no banco de dados.

## Requisitos

- Ruby
- PostgreSQL
- Gems: `httparty`, `pg`, `sequel`
- Docker e Docker Compose (para subir a aplicação via containers)

## Estrutura

- **Scraper**: Principal classe que realiza login e coleta dados de lições por cidade.
- **Banco de dados**: Conecta-se a um banco PostgreSQL para armazenar os dados coletados.
- **Login**: Acessa a plataforma de ensino via `HTTParty`, com autenticação via `Basic Auth`.

## Como executar a aplicação

### Subindo a aplicação com Docker Compose

1. **Clonar o repositório**:
   ```
   git clone https://github.com/seu-repositorio/edusense.git
   cd edusense
   ```

2. **Subir os serviços com Docker Compose**:
   O Docker Compose já está configurado para levantar a aplicação e o banco de dados. Certifique-se de que o `docker-compose.yml` está correto.

   Execute o seguinte comando para iniciar:
   ```
   docker-compose up -d --build
   ```

3. **Verificar os serviços**:
   Use o comando a seguir para verificar se os serviços estão rodando corretamente:
   ```
   docker-compose ps
   ```

### Acesso manual (sem Docker Compose)

1. **Instalar dependências**:
   Execute o comando para instalar as gems necessárias:
   ```
   bundle install
   ```

2. **Configurar o banco de dados**:
   A aplicação usa o PostgreSQL como banco de dados. Certifique-se de que as informações estão corretas para acessar o banco.

   - **IP**: `172.16.0.10`
   - **Banco de Dados**: `edusense_db`
   - **Usuário**: `postgres_user`
   - **Senha**: `edusenseDBpwd`
   - **Porta**: `5432`

   Exemplo de string de conexão:
   ```
   postgres://postgres_user:edusenseDBpwd@172.16.0.10:5432/edusense_db
   ```

3. **Rodar o Scraper**:
   Para iniciar a coleta de dados:
   ```
   ruby scraper.rb
   ```

## Acesso ao Banco de Dados

Abaixo estão os dados de acesso ao banco de dados configurado na aplicação:

- **IP**: `172.16.0.10`
- **Nome do banco de dados**: `edusense_db`
- **Usuário do banco**: `postgres_user`
- **Senha**: `edusenseDBpwd`
- **Porta**: `5432`

Exemplo de conexão:
```
postgres://postgres_user:edusenseDBpwd@147.79.106.108:5432/edusense_db
```

Para acessar o banco diretamente, você pode usar o seguinte comando:
```
psql -h 172.16.0.10 -U postgres_user -d edusense_db
```

## Sobre a Aplicação

- **`Scraper`**: Classe principal que realiza o scraping dos dados.
- **`Lesson`**: Modelo responsável por gerenciar as lições no banco de dados.

A aplicação usa a biblioteca `HTTParty` para realizar requisições HTTP e interagir com a API da plataforma de ensino.

## Observações

- O sistema está configurado para rodar com autenticação básica via `HTTParty` usando as credenciais definidas no código.
- Certifique-se de que o banco de dados PostgreSQL está acessível e configurado corretamente antes de rodar a aplicação.

## Suporte

Para dúvidas e suporte, entre em contato com o mantenedor do projeto.
