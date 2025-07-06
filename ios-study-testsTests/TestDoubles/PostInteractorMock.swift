@testable import ios_study_tests
import XCTest

final class PostInteractorMock: PostInteractorProtocol {
    private(set) var loadPostsCalled = false
    private(set) var timesCalled = 0

    func loadPosts() async throws -> [Post] {
        loadPostsCalled = true
        timesCalled += 1

        // Podemos retornar posts fake aqui se quisermos
        return [
            Post(userId: 1, id: 42, title: "Post mockado", body: "Teste de mock")
        ]
    }

    func verifyCall(expectedCount: Int = 1) {
        XCTAssertTrue(loadPostsCalled, "Esperava que loadPosts() fosse chamado.")
        XCTAssertEqual(timesCalled, expectedCount, "loadPosts() deveria ter sido chamado \(expectedCount)x")
    }
}
