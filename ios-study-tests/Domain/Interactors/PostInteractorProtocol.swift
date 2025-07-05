protocol PostInteractorProtocol {
    func loadPosts() async throws -> [Post]
}
