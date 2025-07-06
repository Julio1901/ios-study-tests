@testable import ios_study_tests
import XCTest

@MainActor
final class PostViewStateTests: XCTestCase {
    func testFetchPosts_DeveChamarLoadPostsDoInteractor() async {
        let mock = PostInteractorMock()
        let viewState = PostViewState(interactor: mock)

        await viewState.fetchPosts()

        mock.verifyCall(expectedCount: 1)
        XCTAssertEqual(viewState.posts.count, 1)
        XCTAssertEqual(viewState.posts.first?.id, 42)
    }
    
    /*
     
     ✅ O que foi testado aqui?
        * A ViewModel chamou o método correto do Interactor
        * Esse método foi chamado exatamente uma vez
        * O retorno foi aplicado no @Published posts
    
     ⚠️ Cuidados com Mocks:
        * Use mocks apenas quando for realmente necessário verificar chamadas/argumentos
        * Evite "overmocking": se você tem que mockar tudo, talvez sua arquitetura esteja muito acoplada
        * Prefira Fakes para testes de lógica e Mocks para testes de comportamento
     
     🧠 Dica profissional
        * Mocks são ótimos quando:
            * Você quer garantir que ações específicas aconteceram
            * Precisa verificar fluxo de chamadas entre camadas
            * Está aplicando TDD com foco em comportamento (BDD)
     
     */
}
