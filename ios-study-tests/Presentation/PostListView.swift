import SwiftUI

struct PostListView: View {
    @StateObject private var state: PostViewState

    init(state: PostViewState) {
        _state = StateObject(wrappedValue: state)
    }

    var body: some View {
        NavigationStack {
            List(state.posts) { post in
                VStack(alignment: .leading, spacing: 4) {
                    Text(post.title.capitalized)
                        .font(.headline)
                    Text(post.body)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .overlay { if state.isLoading { ProgressView() } }
            .navigationTitle("Posts")
            .task { await state.fetchPosts() }
        }
    }
}
