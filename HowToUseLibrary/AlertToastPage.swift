//
//  AlertToastView.swift
//  HowToUseLibrary
//
//  Created by Haruki Nakamura on 2024/08/19.
//

import SwiftUI
import ComposableArchitecture
import AlertToast

struct AlertToastView: View {
    @Bindable var store: StoreOf<AlertToastFeature>
    var body: some View {
        NavigationStack {
            List {
                ForEach(alertToastTypes.allCases, id: \.self) { item in
                    Text(item.rawValue)
                        .onTapGesture {
                            store.send(.showAlertToastButtonTapped(item))
                        }
                }
            }
            .toast(isPresenting: $store.showAlertToast.sending(\.alertToastStateChanged)) {
                switch store.selectedType {
                case .regularAlert:
                    AlertToast(displayMode: .alert, type: .regular, title: "RegularAlert!")
                case .completeBanner:
                    AlertToast(displayMode: .banner(.pop), type: .complete(.green), title: "CompleteBanner!")
                case .errorToast:
                    AlertToast(displayMode: .hud, type: .error(.red), title: "ErrorToast!")
                case .systemImageBanner:
                    AlertToast(displayMode: .banner(.slide), type: .systemImage("gear", .blue), title: "SystemImageBanner!")
                case .loadingAlert:
                    AlertToast(displayMode: .alert, type: .loading, title: "LoadingAlert")
                }
            }
        }
    }
}

enum alertToastTypes: String, CaseIterable {
    case regularAlert = "RegularAlert"
    case completeBanner = "CompleteBanner"
    case errorToast = "ErrorToast"
    case systemImageBanner = "SystemImageBanner"
    case loadingAlert = "LoadingAlert"
}

@Reducer
struct AlertToastFeature {
    @ObservableState
    struct State: Equatable {
        var showAlertToast = false
        var selectedType: alertToastTypes = .regularAlert
    }
    
    enum Action {
        case showAlertToastButtonTapped(alertToastTypes)
        case alertToastStateChanged(Bool)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case let .showAlertToastButtonTapped(selected):
                state.showAlertToast = true
                state.selectedType = selected
                return .none
                
            case let .alertToastStateChanged(show):
                state.showAlertToast = show
                return .none
            }
        }
    }
}





#Preview {
    AlertToastView(
        store: Store(
            initialState: AlertToastFeature.State()
        ) {
            AlertToastFeature()
        }
    )
}
