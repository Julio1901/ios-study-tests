# 🧪 Guia de Estudo: Testes no Ambiente iOS (Swift)

Este documento reúne anotações, conceitos e exemplos sobre testes em projetos iOS, com foco em:

- ✅ Testes de Unidade
- 🧩 Testes de Integração
- 👁️ Testes de Interface (UI Tests)

---

## 📚 Sumário

- [1. Visão Geral dos Tipos de Testes](#1-visão-geral-dos-tipos-de-testes)
- [2. Framework de Teste](#2-framework-de-teste)
  - [Estrutura de um teste unitário](#estrutura-de-um-teste-unitário)
- [3. Boas práticas](#boas-práticas)
- [4. Glossário de Testes no iOS](#-glossário-de-testes-no-ios)
- [5. Test Doubles](#test-doubles)
  - [Dummy](#dummy)
  - [Stub](#stub)
  - [Fake](#fake)
  - [Spy](#spy)
  - [Mock](#mock)
  - [Spy vs Mock no Swift (com XCTest)](#spy-vs-mock-no-swift-com-xctest)
- [6. Exemplos de testes com Fake](#exemplos-de-uso-do-fake)
- [7. Exemplos de Código](#testes)

---

# 🧪 Glossário de Testes no iOS

Este glossário reúne os termos mais comuns no contexto de testes unitários e automação no desenvolvimento iOS com Swift.

---

### ✅ SUT (System Under Test)

> **SUT** é o componente principal que está sendo testado.  
> Exemplo: Se você está testando `LoginViewModel`, ela é o seu SUT.

---

### ✅ Test Double

> Representa qualquer objeto que **substitui um componente real** durante o teste. Os tipos mais comuns são:

#### • Dummy

Objeto "burro", apenas para preencher argumentos.  
Ex: Um `User` vazio que é passado porque o método exige, mas não é usado.

#### • Stub

Objeto que **retorna dados fixos**, independentemente do input.  
Ex: `.fetchUser()` sempre retorna `"Julio"`.

#### • Fake

Tem **lógica real simples**, geralmente um mini banco de dados em memória.  
Ex: `.save(user)` e depois `.getUsers()` retorna o que salvou.

#### • Spy

Grava as chamadas feitas e permite **verificações depois**.  
Ex: Um `SpyLogger` que salva se o método `.log()` foi chamado com certo valor.

#### • Mock

Pré-programado com **expectativas** e verifica se elas foram atendidas.  
É o mais sofisticado dos doubles.

---

### ✅ XCTestCase

Classe base para seus testes no framework `XCTest`.  
Você herda dela para criar seus próprios testes.

---

### ✅ XCTAssert

Funções de asserção usadas para verificar condições esperadas.  
Exemplos:  
- `XCTAssertTrue(condition)`  
- `XCTAssertEqual(result, expectedValue)`

---

### ✅ setUp() / tearDown()

Métodos especiais chamados **antes e depois** de cada teste.  
Úteis para preparar ou limpar o ambiente de teste.

---

### ✅ Test Target

É o módulo de testes separado no projeto Xcode, com acesso ao seu código produtivo via `@testable import`.

---

### ✅ Code Coverage

Métrica que mostra **quantas linhas do seu código foram executadas pelos testes**.  
Ajuda a identificar o que ainda não está testado.

---

### ✅ TDD (Test-Driven Development)

Prática de desenvolvimento onde você **escreve o teste antes do código**.  
Fluxo típico:  
1. Escreve um teste que falha  
2. Escreve o código mínimo para passar  
3. Refatora

---

## 1. Visão Geral dos Tipos de Testes

> Resumo rápido das diferenças entre Unit, Integration e UI Tests.

- **Unit Test**: testa pequenas unidades isoladas (ex: uma função, um método de ViewModel)
- **Integration Test**: testa múltiplos componentes interagindo entre si
- **UI Test**: testa a interface como o usuário vê (com XCUITest)


---


## Framework de teste

O **XCTest** é o framework oficial da Apple para a realização de testes até o xCode 15 (Swift 5). A partir do xCode 16 (Swift6) o framework recomentado é o **Swift Testing**. 

• Um framework é um conjunto de ferramentas para resolver um problema específico. São códigos prontos para te ajudar a resolver um problema para que você não tenha que fazer tudo do zero.
 
• O XCTest é o framework da Apple que vem com coisas como:
    · Classes prontas como, por exemplo, XCTestCase.
    · Métodos úteis como XCTAssertEqual, XCTFail etc.,
    · Integração com o xCode para rodar e visualizar os testes

Em resumo, não precisamos criar um sistema de testes do zero. O XCTest cuida disso para nós.


### Estrutura de um teste unitário

• Exemplo de uma estrutura simples de testes.

```swift
import XCTest
@testable import MeuApp

final class CalculadoraTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Executa antes de cada teste
    }

    override func tearDown() {
        // Executa depois de cada teste
        super.tearDown()
    }

    func testSoma() {
        let resultado = 2 + 3
        XCTAssertEqual(resultado, 5)
    }
}
```

## Boas práticas

* O nome do teste deve começar com o prefixo "test" para o framework executá-lo  
* Use um padrão de nomenclatura claro que descreva o teste. Por exemplo:  
  * test_nomeDaFuncaoTestada_QuandoAcontecerAlgo_RetornoEsperado  
  * Ficaria algo assim: test_login_whenPasswordIsInvalid_ShouldReturnInvalidStatus      
  
  
  
# Test Doubles: 
## Existem vários tipos de Stub, esses test doubles são responsáveis por:

### * Isolar a unidade de código testada 
### * Controlar o comportamento de dependências externas no momento do teste
### * Evitar efeitos colaterais como chamadas de rede, banco de dados etc.,
### * Verificar iterações com objetos dependentes
 
## Tipos de Test Doubles:
## Abaixo, serão descritos os 5 tipos clássicos de Test Doubles

- [1. Dummy](##Dummy)
- [2. Stub](##Stub)
- [3. Fake](##Fake)
- [4. Spy](##Spy)
- [5. Mock](##Mock)

## Dummy
    - Dummy é um objeto vazio, ele serve apenas para preencher um parâmetro obrigatório. Ele não faz nada.
    
    ```swift
    
            protocol Logger {
            func log(_ message: String)
        }

        class DummyLogger: Logger {
            func log(_ message: String) {
                // Não faz nada
            }
        }

        class Calculator {
            let logger: Logger
            init(logger: Logger) {
                self.logger = logger
            }
            
            func add(_ a: Int, _ b: Int) -> Int {
                return a + b
            }
        }

        // Teste
        let calculator = Calculator(logger: DummyLogger()) // Só pra preencher
        XCTAssertEqual(calculator.add(2, 3), 5)
    
    ```
    
    - Nesse exemplo, temos uma classe responsável por realizar calculos que tem como dependência um objeto responsável por realizar logs. Criamos um Dummy que extende a interface apenas para passar por parâmetro no momento do teste. Esse **Dummy** não irá realizar nada, ou seja, não irá influenciar no momento do teste. O importante aqui, é testarmos os métodos da classe Calculator, sendo assim, não precisamos nos importar se ela está registrando os logs ou não, estamos preocupados apenas com as funcões de calculo.


## Stub
    - Stub é um objeto que responde com dados pré-definidos. Ele não grava chamadas, só responde previsivelmente.
    - Quando usar? Quando queremos controlar o retorno de uma dependência para facilitar o teste.


    ```swift
            protocol UserService {
            func fetchUserName() -> String
        }

        class UserServiceStub: UserService {
            func fetchUserName() -> String {
                return "Julio" // Valor fixo
            }
        }

        class WelcomeViewModel {
            let service: UserService
            init(service: UserService) {
                self.service = service
            }

            func welcomeMessage() -> String {
                "Hello, \(service.fetchUserName())"
            }
        }

        // Teste
        let viewModel = WelcomeViewModel(service: UserServiceStub())
        XCTAssertEqual(viewModel.welcomeMessage(), "Hello, Julio")
    ```

    - Nesse exemplo temos um Stub da nossa classe de serviço. Esse Stub extende a interface, posteriormente, nós definimos exatamente o dado que o método irá retornar para nós. Desse modo, quando passamos o **Stub** como dependência no nosso teste, conseguimos prever exatamente o modo como nosso método deveria se comportar. Se eu não houvesse fixado o retorno sempre como "Julio" seria impossível realizar um assert para saber se meu método estava montando a mensagem de boas vindas corretamente chegando ao resultado "Hello, Julio".

## Fake
 - Fake é uma implementação funcional de uma classe, porém, alternativa. O que isso significa? Que criaremos sim uma classe que contém lógica e executa métodos dentro dela, porém, é uma classe com uma implementação mais simples do que a real, que servirá para substituir a classe real.
 - Ela é uma classe que pode substituir uma classe que realiza operações no banco de dados, por exemplo:
 
 ```swift 
         protocol Storage {
            func save(_ item: String)
            func getAll() -> [String]
        }

        class InMemoryStorage: Storage { // Fake
            private var data: [String] = []

            func save(_ item: String) {
                data.append(item)
            }

            func getAll() -> [String] {
                return data
            }
        }

        // Teste
        let storage = InMemoryStorage()
        storage.save("Item 1")
        XCTAssertEqual(storage.getAll(), ["Item 1"])
 ```

  - Ela pode se parecer com a Stub, mas a Stub sempre temos dados fixos dentro enquanto que a fake nos retornará dados de acordo com o que inputarmos nela etc., ou seja, de acordo com nossa interação real com ela. o **Stub** só devolve valores fixos, enquanto o **Fake** executa lógica real simplificada.
  - Um Fake é um dublê de teste que funciona de verdade, mas sua implementação é mais simples ou menos robusta que a versão real. Ele pode armazenar dados, executar lógica, mas não é usado em produção.

  * Ele é útil quando:
  ** Você quer testar a integração entre objetos, mas sem envolver o mundo real (como banco, disco ou rede).
  ** Você quer uma resposta que depende do input, mas sem depender de infraestrutura externa.
  
    | Aspecto          | Stub                                     | Fake                                                          |
    |------------------|------------------------------------------|---------------------------------------------------------------|
    | Retorno          | Sempre fixo                              | Pode variar conforme o input                                  |
    | Lógica interna   | Nenhuma (ou mínima)                      | Simples, mas funcional                                        |
    | Uso típico       | Testes de unidade                        | Testes de integração sem dependências reais                   |
    | Exemplo          | `.fetchUser() → "Julio"`                 | `.save(user)` e depois `.getUsers()` retorna o que foi salvo  |
     
     
     
### Exemplos de uso do Fake:  

📦 Exemplo 1 — Fake de banco de dados  
    Situação:  
    Temos um serviço que salva dados em um banco. No teste, não queremos um banco de verdade, então criamos um Fake que guarda os dados em memória.  
    
  ```swift
      protocol UserStorage {
        func save(_ user: String)
        func fetchAll() -> [String]
    }
      
      //FAKE:
      
      class InMemoryUserStorage: UserStorage {
        private var users: [String] = []

        func save(_ user: String) {
            users.append(user)
        }

        func fetchAll() -> [String] {
            return users
        }
    }
  ```
  - Essa classe simula um banco, mas usa uma array local. Não é fixa (como um Stub) — o resultado depende do que você fez antes.  
  
  ### ✔️ Teste com esse Fake:  
  
  ```swift
  
      func testSaveUser() {
        let storage = InMemoryUserStorage()
        storage.save("Julio")
        XCTAssertEqual(storage.fetchAll(), ["Julio"])
    }
  
  ```
  
  📦 Exemplo 2 — Fake de serviço de envio de email  
  Imagine que o serviço real envia um e-mail via rede. No teste, criamos um Fake:
  
  ```swift 
        protocol EmailService {
        func send(to: String, message: String)
    }

    class FakeEmailService: EmailService {
        var sentMessages: [(to: String, message: String)] = []

        func send(to: String, message: String) {
            sentMessages.append((to: to, message: message))
        }
    }
  ```
  
  📦 Exemplo 3 — Fake do URLSession (simulando chamadas de API)  

Este é um uso muito comum de Fake: você substitui o URLSession.shared por uma versão falsa que responde do jeito que você quiser:

```swift
     class URLSessionFake: URLSession {
        override func data(for request: URLRequest) async throws -> (Data, URLResponse) {
            let json = """
            [{"id":1,"userId":1,"title":"Post Fake","body":"Conteúdo"}]
            """
            let data = Data(json.utf8)
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (data, response)
        }
    }
```
  
  - Essa fake session devolve dados reais em JSON, mas não faz nenhuma chamada externa. Isso seria muito útil no seu projeto com a API de posts.
  
  ## Se estou usando um Fake, e ele não é idêntico ao comportamento de produção, o que exatamente estou testando? E vale a pena?
  
  ### Resposta: Você está testando a lógica da ViewModel, ViewState ou qualquer outra classe que depende do fake em si, não a infraestrutura (que foi substituída pelo fake).
  
  
  * Supondo que estamos utilizando um fake como dependência passada para uma viewModel:
  
  - ✅ O foco do teste com Fake é:  
  - Se a ViewModel está tomando as decisões certas com base nas respostas da dependência.  
  - Se está chamando os métodos certos na ordem correta.  
  - Se os dados trafegam como esperado dentro da ViewModel.  
  
  Exemplo:  
  
  ```swift 
  
  protocol TaskStorageProtocol {
    func save(_ task: Task)
    func getAll() -> [Task]
}

final class FakeTaskStorage: TaskStorageProtocol {
    private var tasks: [Task] = []

    func save(_ task: Task) {
        tasks.append(task)
    }

    func getAll() -> [Task] {
        return tasks
    }
}

final class TaskViewModel {
    private let storage: TaskStorageProtocol

    init(storage: TaskStorageProtocol) {
        self.storage = storage
    }

    func addTask(title: String) {
        let task = Task(id: UUID(), title: title)
        storage.save(task)
    }

    func fetchTasks() -> [Task] {
        storage.getAll()
    }
}

// Teste usando o Fake

import XCTest

final class TaskViewModelTests: XCTestCase {
    func testAddTask_DeveSalvarETrazerDeVolta() {
        let fakeStorage = FakeTaskStorage()
        let viewModel = TaskViewModel(storage: fakeStorage)

        viewModel.addTask(title: "Estudar testes")
        viewModel.addTask(title: "Ler sobre Clean Architecture")

        let tasks = viewModel.fetchTasks()

        XCTAssertEqual(tasks.count, 2)
        XCTAssertEqual(tasks[0].title, "Estudar testes")
        XCTAssertEqual(tasks[1].title, "Ler sobre Clean Architecture")
    }
  
  ```
  
  ### 🎯 O que você está realmente testando com Fake?    
    - Se addTask(title:) cria uma Task corretamente.  
    - Se essa Task está sendo enviada para o storage.save().  
    - Se ao chamar fetchTasks(), você recupera as tarefas salvas.  
    - 🟢 Mesmo que o storage real fosse CoreData, Realm ou banco remoto, o contrato é o mesmo (TaskStorageProtocol).  
    - 🧪 Então o comportamento da ViewModel se mantém válido.  
  
  
## Spy
    - Um dublê que grava chamadas ou interações, permitindo que você verifique depois o que aconteceu.  
    - Um objeto que registra informações durante o teste, como:  
    - Se um método foi chamado  
    - Com quais argumentos  
    - Quantas vezes  
    - Você mesmo verifica depois essas informações com asserts.


    🧠 Quando usar:  
        * Quando você quer saber se algo foi chamado, quantas vezes, com quais parâmetros, etc.
        * Quando você quer observar o comportamento, mas não precisa simular retorno complexo


### Exemplo básico usando um Spy

```swift
        class LoggerSpy: Logger {
            var messages: [String] = []

            func log(_ message: String) {
                messages.append(message)
            }
        }

        // Teste
        let spy = LoggerSpy()
        let calculator = Calculator(logger: spy)
        _ = calculator.add(2, 3)
        XCTAssertTrue(spy.messages.isEmpty) // Se add() não chama log

```

### Mais um exemplo usando um Spy

```swift
        protocol AnalyticsTracker {
            func track(event: String)
        }

        class AnalyticsTrackerSpy: AnalyticsTracker {
            var calledEvents: [String] = []

            func track(event: String) {
                calledEvents.append(event)
            }
        }

        class SignUpViewModel {
            let analytics: AnalyticsTracker

            init(analytics: AnalyticsTracker) {
                self.analytics = analytics
            }

            func signUp() {
                analytics.track(event: "SignUpStarted")
                // lógica de cadastro...
            }
        }

        func testSignUp_DeveDispararEventoDeAnalytics() {
            let spy = AnalyticsTrackerSpy()
            let viewModel = SignUpViewModel(analytics: spy)

            viewModel.signUp()

            XCTAssertEqual(spy.calledEvents, ["SignUpStarted"])
        }

```


### Exemplo de Spy com verificação de número de chamadas


```swift 
    class SpyCounter {
        private(set) var timesCalled = 0

        func increment() {
            timesCalled += 1
        }
    }

    func testIncrement_SpyVerificaChamadas() {
        let spy = SpyCounter()

        spy.increment()
        spy.increment()

        XCTAssertEqual(spy.timesCalled, 2)
    }
```

 🧪 Resumo do SPY:  
    Você faz as asserções no final  
    Não exige frameworks externos  
    Ideal para testes de comportamento leve  
    
## 🎭 Mock (ator de mentira)
    🎯  O que é um Mock?  
    * Um Mock é um dublê de teste que imita o comportamento de uma dependência e ainda permite você:  
        * Definir expectativas (ex: “esse método deve ser chamado com esses parâmetros”)  
        * Registrar chamadas  
        * Fornecer retornos controlados  
        * Falhar explicitamente se a expectativa não for atendida    
    
    Ou seja: ele é um Spy com atitude — ele não apenas grava o que aconteceu, mas reclama se algo esperado não acontecer.  
    
    ✅ Quando usar:  
        * Quando você precisa de verificação rigorosa  
        * Quando quer testar interações específicas e obrigatórias  



    🧠 O foco do Mock é o comportamento esperado da unidade testada.  
    * Você está testando interações, e não lógica de retorno (isso é coisa de stub/fake).    

    🧪 Exemplo genérico de Mock (sem framework)  
    Vamos simular uma EmailService e verificar se ela foi chamada com o texto certo:  
    
    ```swift
    
        protocol EmailService {
        func send(to: String, subject: String)
    }
        final class EmailServiceMock: EmailService {
        private(set) var wasCalled = false
        private(set) var capturedTo: String?
        private(set) var capturedSubject: String?

        func send(to: String, subject: String) {
            wasCalled = true
            capturedTo = to
            capturedSubject = subject
        }

        func verify(expectedTo: String, expectedSubject: String) {
            XCTAssertTrue(wasCalled, "Esperava que o método send fosse chamado.")
            XCTAssertEqual(capturedTo, expectedTo)
            XCTAssertEqual(capturedSubject, expectedSubject)
        }
    }

    func testSendEmail_DeveChamarComParametrosCorretos() {
        let mock = EmailServiceMock()
        let sender = EmailSender(service: mock)

        sender.sendWelcome(to: "julio@email.com")

        mock.verify(expectedTo: "julio@email.com", expectedSubject: "Bem-vindo!")
    }
    
    ```
    
    
    
### 📦 Exemplo — Mock com verificação de expectativa manual

```swift

    class AnalyticsTrackerMock: AnalyticsTracker {
        private(set) var wasTrackCalled = false
        private(set) var eventReceived: String?

        func track(event: String) {
            wasTrackCalled = true
            eventReceived = event
        }

        func verify() {
            XCTAssertTrue(wasTrackCalled, "Esperava que track(event:) fosse chamado")
            XCTAssertEqual(eventReceived, "SignUpStarted", "Evento errado enviado")
        }
    }


    func testSignUp_DeveDispararEventoDeAnalytics_MockVerifica() {
        let mock = AnalyticsTrackerMock()
        let viewModel = SignUpViewModel(analytics: mock)

        viewModel.signUp()

        mock.verify()
    }

```

# 🕵️‍♂️ SPY vs MOCK no Swift (com XCTest)


🧠 O que os dois têm em comum:
Tanto Spy quanto Mock são dublês usados para:

Observar se métodos foram chamados

Registrar argumentos

Verificar interações entre objetos



#Onde parei: Eu terminei de ver a diferença entre os stubs. Agora vou para o tópico 3: Testes de integração.


Prompt para o chatGPT:


Vamos retomar no:

### 3. **Testes de Integração**

- Diferença entre testes de integração e unitários
- Quando e como escrever testes de integração
- Como estruturar testes que verificam a colaboração entre camadas
- Ex: ViewModel + Service ou Service + Repository






#MEUS QUESTIONAMENTOS (Pare pesquisar)
- O que significa o nome Stub?


## Testes

```swift
// Exemplo retirado do arquivo MinhaViewModel.swift, linhas 10 a 15
@Published var isLoading = false

func fetchData() async {
    isLoading = true
    // ...
}
```


