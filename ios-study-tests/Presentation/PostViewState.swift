import Foundation

@MainActor
final class PostViewState: ObservableObject {
    @Published private(set) var posts: [Post] = []
    @Published private(set) var isLoading = false

    private let interactor: PostInteractorProtocol
    init(interactor: PostInteractorProtocol) { self.interactor = interactor }

    func fetchPosts() async {
        guard posts.isEmpty, !isLoading else { return }
        isLoading = true
        defer { isLoading = false }

        do { posts = try await interactor.loadPosts() }
        catch { print("Error loading posts: ", error) }
    }
}
