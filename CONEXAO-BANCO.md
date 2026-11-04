# TA Ops - conexão com o Laboratório SQL

Esta etapa verifica a conexão e a leitura das quatro tabelas. Ainda não há
cadastro pela interface, autenticação de usuários ou permissões por equipe.

## 1. Extrair o projeto

Pare a aplicação antiga com Ctrl+C. Extraia este ZIP em uma pasta nova.
Abra a pasta que contém pom.xml e iniciar.cmd.
O iniciar.cmd continua abrindo somente a interface, sem banco.
Para testar o banco, use iniciar-banco.cmd após os passos abaixo.

## 2. Definir a senha do usuário restrito (uma vez)

No Supabase, abra o projeto Laboratório SQL e o SQL Editor.
O papel taops_app já foi criado com NOLOGIN e somente SELECT nas quatro tabelas.
Escolha uma senha exclusiva e forte (por exemplo, 24 ou mais caracteres aleatórios).
Guarde-a em seu gerenciador de senhas. Não envie a senha no chat.

Substitua o texto entre aspas por sua senha e execute, somente no painel Supabase:

```sql
ALTER ROLE taops_app WITH LOGIN PASSWORD 'SUBSTITUA_PELA_SUA_SENHA';
```

Não execute com o texto de exemplo. Se houver uma aspa simples na senha,
ela deve ser duplicada dentro do SQL. Depois remova a senha do texto da consulta
salva no editor. Não copie essa consulta preenchida para arquivos do projeto.
Não use a senha de postgres nem chaves anon/service_role no aplicativo.

## 3. Obter Host e certificado

No mesmo projeto, clique em Connect e selecione Session pooler.
Copie somente o campo Host. A porta utilizada é 5432.
O script já utiliza taops_app.tkubetvrizvujluddhir como usuário.
Não copie a URL inteira, que pode conter credenciais.

Em Database Settings, seção SSL Configuration, baixe o certificado CA.
Guarde-o em uma pasta e copie o caminho completo, por exemplo:
C:\Users\acrom\Downloads\prod-ca-2021.crt
O nome real deve ser o do arquivo que você baixou.

## 4. Iniciar

Dê dois cliques em iniciar-banco.cmd. Ele pergunta o Host, o caminho do
certificado e a senha. A senha fica oculta e é passada ao Java por variável
de ambiente do processo; não é salva pelo script em disco nem passada como
argumento de linha de comando.

O iniciador usa PowerShell com permissão de execução apenas para esse processo;
não altera a política de execução permanente do Windows.

Aguarde a mensagem:

TA Ops: conexao com o banco confirmada; leitura das quatro tabelas OK.

Depois abra http://localhost:8080. A tela continua igual: esta etapa só verifica
a conexão. Para parar, pressione Ctrl+C e feche a janela.

## Configuração técnica

- Java alvo 21; Spring Boot 4.1.2; versões do driver e JPA gerenciadas pelo parent.
- Perfil visual: sem DataSource, funciona sem banco.
- Perfil banco: Hikari com até duas conexões, JDBC PostgreSQL e JPA/Hibernate.
- TLS verify-full: verifica certificado e hostname; não reduzir para disable/require.
- Hibernate ddl-auto=none e SQL init=never: a aplicação não cria nem altera tabelas.
- Usuário taops_app sem privilégios administrativos, bypass de RLS ou escrita.
- As políticas SELECT permitem a leitura pelo backend; RBAC dos usuários virá depois.
- O verificador de inicialização é JDBC, sem endpoint público de diagnóstico.
- Acesso HTTP limitado a 127.0.0.1. Não publicar esta versão.
- Campos versao e tabelas serão mapeados em entidades na etapa dos cadastros.

## Problemas comuns

- Porta 8080 ocupada: pare a aplicação anterior.
- Falha de senha: confirme que ativou LOGIN e use a senha de taops_app.
- Falha TLS: confira o arquivo CA do projeto e o Host do Session pooler.
  Não desative a verificação TLS para contornar o erro.
- Falha no download Maven: confira rede e mensagens do Maven.
- Não apareceu a confirmação: o teste de conexão ainda não foi concluído.

## Validação desta entrega

Permissões de leitura e bloqueios de escrita/DDL foram testados no PostgreSQL
com SET ROLE, sem ativar login e sem credenciais. Isso não testa autenticação
por senha, rede do seu computador nem o certificado.
A compilação Java e o teste real JDBC dependem do ambiente e da configuração
local. Não foram confirmados no ambiente de preparação, que tem apenas JDK 17 e nao conseguiu resolver repo.maven.apache.org para baixar as dependencias.

Documentação:
- https://supabase.com/docs/guides/database/connecting-to-postgres
- https://supabase.com/docs/guides/platform/ssl-enforcement
- https://docs.spring.io/spring-boot/reference/using/auto-configuration.html

Os scripts em database/applied sao copias versionadas das migracoes ja aplicadas no Supabase. Nao execute novamente nesse projeto.
