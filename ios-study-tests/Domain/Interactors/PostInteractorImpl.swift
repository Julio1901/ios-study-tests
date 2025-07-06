
final class PostInteractorImpl: PostInteractorProtocol {
    private let service: PostServiceProtocol
    init(service: PostServiceProtocol) { self.service = service }

    func loadPosts() async throws -> [Post] {
        try await service.fetchPosts()
    }
}
