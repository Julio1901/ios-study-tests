# 🧪 Guia de Estudo: Testes no Ambiente iOS (Swift)

Este documento reúne anotações, conceitos e exemplos sobre testes em projetos iOS, com foco em:

- ✅ Testes de Unidade
- 🧩 Testes de Integração
- 👁️ Testes de Interface (UI Tests)

---

## 📚 Sumário

- [1. Visão Geral dos Tipos de Testes](#1-visão-geral-dos-tipos-de-testes)
- [2. 
- [3. 
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

## Testes

```swift
// Exemplo retirado do arquivo MinhaViewModel.swift, linhas 10 a 15
@Published var isLoading = false

func fetchData() async {
    isLoading = true
    // ...
}
```


