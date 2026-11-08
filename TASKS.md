# Roteiro: construir o CRUD juntos

Vamos avançar uma etapa por vez. Você escreve o código; eu explico o próximo passo, reviso o que você fizer e ajudo a corrigir erros.

## Analogia com C# e ASP.NET Core

| Java / Spring | C# / ASP.NET Core que você conhece |
| --- | --- |
| `@RestController` e `@RequestMapping` | Controller com `[ApiController]` e `[Route]` |
| `@GetMapping`, `@PostMapping`, `@PutMapping`, `@DeleteMapping` | `[HttpGet]`, `[HttpPost]`, `[HttpPut]`, `[HttpDelete]` |
| Classe `Service` anotada com `@Service` | Serviço registrado no DI e injetado no controller |
| Interface `Repository` estendendo `JpaRepository` | Repositório/`DbContext` do Entity Framework Core; o Spring gera a implementação |
| Entidade JPA com `@Entity` | Entidade do EF Core mapeada para uma tabela |
| Entidade Java recebida no corpo da requisição | Entidade C# recebida diretamente como parâmetro da action |
| `application.properties` e variáveis de ambiente | `appsettings.json` com configuração sobrescrita por ambiente |
| Injeção pelo construtor | Constructor injection no ASP.NET Core |

Um pedido HTTP entra no **Controller**, passa para o **Service** e chega ao **Repository**, que consulta ou altera o PostgreSQL do Supabase. O resultado volta pelo mesmo caminho como resposta HTTP/JSON.

## Etapas

- [ ] **0. Escolher o que vamos controlar** — definir o recurso do CRUD e seus campos. Exemplo: produtos, clientes ou tarefas. É o equivalente a decidir o modelo de domínio antes de criar uma classe C#.
- [ ] **1. Criar o projeto Supabase** — criar um projeto, guardar a senha do banco e copiar a conexão JDBC em **Connect**. A senha não vai para o Git nem para `application.properties`.
- [ ] **2. Preparar o banco** — executar `create schema if not exists app;` no SQL Editor do Supabase. O schema é parecido com um agrupador de tabelas dentro do banco.
- [ ] **3. Conectar Spring ao Supabase** — configurar `SUPABASE_DB_URL` no terminal do VS Code e entender `application.properties`. Equivale a configurar a connection string do EF Core por ambiente.
- [ ] **4. Criar a entidade** — escrever a classe Java que representa um registro e mapear seus campos para a tabela. Analogia: entidade C# usada pelo EF Core.
- [ ] **5. Criar o Repository** — declarar a interface estendendo `JpaRepository<Entidade, TipoDoId>`. Comparar os métodos fornecidos pelo Spring com `DbSet`, `FindAsync`, `Add` e `SaveChangesAsync` no EF Core.
- [ ] **6. Criar o Service** — implementar as regras do recurso e usar o repository. Comparar com uma classe de serviço C# injetada por DI.
- [ ] **7. Criar o Controller** — adicionar as rotas HTTP e delegar o trabalho ao service. Comparar cada anotação Spring com os atributos `[Http...]` do ASP.NET Core.
- [ ] **8. Validar e tratar erros** — validar os campos da própria entidade e responder com códigos HTTP apropriados, como 400, 404 e 201.
- [ ] **9. Exercitar a API** — enviar requisições e observar os registros no Supabase; depois conferir logs e fluxo por cada camada.

## Responsabilidade de cada camada

1. **Controller:** traduz HTTP para chamadas da aplicação e escolhe status/resposta. Deve ser fino.
2. **Service:** concentra as regras e coordena os passos. Não deve conhecer detalhes do HTTP.
3. **Repository:** lê e grava dados. Não deve decidir regras de negócio.

Não precisamos criar todas as camadas de uma vez. Começaremos pela etapa 0 e construiremos cada classe quando chegar a hora.

Neste projeto, não vamos criar DTOs: o Controller receberá a entidade `Produto` diretamente no corpo das requisições e ela também será usada nas respostas.
