import Foundation

final class PostServiceImpl: PostServiceProtocol {
    func fetchPosts() async throws -> [Post] {
        // TODO: Refactor this: Remove the hardcoded String and organize it better.
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Post].self, from: data)
    }
}
