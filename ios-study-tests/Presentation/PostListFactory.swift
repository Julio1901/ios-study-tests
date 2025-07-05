import SwiftUI

struct PostModuleFactory {
    @MainActor static func make() -> some View {
        let service    = PostServiceImpl()
        let interactor = PostInteractorImpl(service: service)
        let viewState  = PostViewState(interactor: interactor)
        return PostListView(state: viewState)
    }
}
