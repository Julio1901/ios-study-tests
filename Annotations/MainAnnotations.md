# 🧪 Guia de Estudo: Testes no Ambiente iOS (Swift)

Este documento reúne anotações, conceitos e exemplos sobre testes em projetos iOS, com foco em:

- ✅ Testes de Unidade
- 🧩 Testes de Integração
- 👁️ Testes de Interface (UI Tests)

---

## 📚 Sumário

- [1. Visão Geral dos Tipos de Testes](#1-visão-geral-dos-tipos-de-testes)
- [2. Frameworks utilizados para teste no iOS
- [3. Boas práticas
- [4. 
- [5. 
- [6. 
- [7.

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
  
  
  
# Onde parei: Estava criando um projeto simples usando viper obtendo os dados do jsonPlaceHolder para começar a criar os testes

     
 

    
    



























## Testes

```swift
// Exemplo retirado do arquivo MinhaViewModel.swift, linhas 10 a 15
@Published var isLoading = false

func fetchData() async {
    isLoading = true
    // ...
}
```


