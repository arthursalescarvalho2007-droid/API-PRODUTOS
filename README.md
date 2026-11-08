# API Java + Supabase

Projeto base para construirmos uma API REST juntos usando Java 21, Spring Boot, Maven e PostgreSQL do Supabase. O código de CRUD ainda será escrito por você, passo a passo.

## Abrir o projeto

1. Abra esta pasta no VS Code.
2. Instale as extensões recomendadas: **Extension Pack for Java** e **Spring Boot Extension Pack**.
3. Siga as etapas em [TASKS.md](TASKS.md), começando por criar o projeto no Supabase.

O projeto ainda não inicia até configurar a conexão `SUPABASE_DB_URL` e criar o schema `app` no Supabase. Isso é intencional: primeiro vamos entender e configurar o banco juntos. A porta local da API está definida como `8081` porque a `8080` estava ocupada neste computador.

## Conexão com Supabase

No painel do projeto Supabase, use **Connect** e copie a string da aba **JDBC**. Para este backend local, prefira o **Session pooler** na porta `5432` se a rede não oferecer IPv6. Evite o Transaction pooler para Hibernate, pois ele depende de prepared statements. Mantenha a senha fora dos arquivos do projeto.

No terminal integrado do VS Code, defina a variável de ambiente para a sessão atual do PowerShell e inicie a aplicação:

```powershell
$env:SUPABASE_DB_URL = "jdbc:postgresql://HOST:5432/postgres?user=USUARIO&password=SENHA&sslmode=require"
./iniciar.cmd
```

Substitua a URL inteira pelos dados copiados do painel; os valores acima são apenas um formato de exemplo. A API ficará em `http://localhost:8081`.

## Referências de configuração

- [Guia oficial Supabase + Spring Boot](https://supabase.com/docs/guides/getting-started/quickstarts/spring-boot)
- [Conexões PostgreSQL do Supabase](https://supabase.com/docs/guides/database/connecting-to-postgres)
