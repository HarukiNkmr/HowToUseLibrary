//
//  ImageViewerView.swift
//  HowToUseLibrary
//
//  Created by Haruki Nakamura on 2024/08/25.
//

import SwiftUI
import ComposableArchitecture
import ImageViewer

struct ImageViewerView: View {
    @Bindable var store: StoreOf<ImageViewerFeature>
    
    var body: some View {
        VStack {
            Button {
                store.send(.showImageButtonTapped)
            } label: {
                Text("Show Image!!")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(ImageViewer(image: $store.image.sending(\.imageBinded), viewerShown: $store.showImage.sending(\.showImageBinded)))
    }
}

@Reducer
struct ImageViewerFeature {
    @ObservableState
    struct State: Equatable {
        var image = Image("IMG_8389")
        var showImage = false
    }
    
    enum Action {
        case showImageButtonTapped
        case imageBinded(Image)
        case showImageBinded(Bool)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .showImageButtonTapped:
                state.showImage = true
                return .none
                
            case let .imageBinded(image):
                state.image = image
                return .none
                
            case let .showImageBinded(show):
                state.showImage = show
                return .none
            }
        }
    }
}

#Preview {
    ImageViewerView(
        store: Store(
            initialState: ImageViewerFeature.State()
        ) {
            ImageViewerFeature()
        }
    )
}
