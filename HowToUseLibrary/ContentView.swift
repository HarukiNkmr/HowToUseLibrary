//
//  ContentView.swift
//  HowToUseLibrary
//
//  Created by Haruki Nakamura on 2024/08/19.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Form {
                NavigationLink("AlertToast") {
                    Demo(store: Store(initialState: AlertToastFeature.State()) { AlertToastFeature() }) { store in
                        AlertToastView(store: store)
                    }
                }
            }
        }
    }
}

/// Original code is here. (https://github.com/pointfreeco/swift-composable-architecture/tree/main/Examples/CaseStudies)
/// This wrapper provides an "entry" point into an individual demo that can own a store.
struct Demo<State, Action, Content: View>: View {
    @SwiftUI.State var store: Store<State, Action>
    let content: (Store<State, Action>) -> Content
    
    init(
        store: Store<State, Action>,
        @ViewBuilder content: @escaping (Store<State, Action>) -> Content
    ) {
        self.store = store
        self.content = content
    }
    
    var body: some View {
        content(store)
    }
}

#Preview {
    ContentView()
}
