@testable import ios_study_tests

final class FakePostService: PostServiceProtocol {
    
    var storedPosts: [Post] = []
    
    func fetchPosts() async throws -> [Post] {
        return storedPosts
    }
    
}
