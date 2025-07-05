
final class PostInteractorImpl: PostInteractorProtocol {
    private let service: PostServiceImpl
    init(service: PostServiceImpl) { self.service = service }

    func loadPosts() async throws -> [Post] {
        try await service.fetchPosts()
    }
}
