@testable import ios_study_tests
import XCTest

final class PostInteractorTests: XCTestCase {
    
 // Test feito usando um Test Double Fake
 func testWhenLoadPosts_withSucess_thenShouldReturnPostsFromFakeService() async throws {
     let fakeService = FakePostService()
     
     fakeService.storedPosts = [
         Post(userId: 1, id: 1, title: "Fake Post", body: "Lorem ipsum")
     ]
     
     let sut = PostInteractorImpl(service: fakeService)
     
     let posts = try await sut.loadPosts()
     
     XCTAssertEqual(posts.count, 1)
     XCTAssertEqual(posts[0].title, "Fake Post")
     
    }
    
    /*
     ✅ Vantagens do Fake:
        🔄 Rápido, previsível, sem rede
        🧪 Excelente para testes de lógica isolada
        🧼 Sem erros externos (API fora do ar, latência etc.)
    */

  // Test feito usando a API real
    func testWhenLoadPosts_withSucess_thenShouldReturnPostsFromRealService() async throws {
        let service = PostServiceImpl()
        let posts = try await service.fetchPosts()

        XCTAssertFalse(posts.isEmpty)
        XCTAssertGreaterThan(posts.count, 1)
        XCTAssertFalse(posts[0].title.isEmpty)
    }
 
    /*
     ✅ Vantagens da Integração real:
        ✅ Verifica se a API está funcionando
        ✅ Valida o JSON e o Decodable
        ✅ Testa a cadeia completa: URL → rede → dados → modelo

     ⚠️ Desvantagens:
        🌐 Depende da internet
        ❌ Lento e instável se a API cair
        🧪 Não recomendado para rodar em CI/CD sem isolamento
     */
    
    
}
