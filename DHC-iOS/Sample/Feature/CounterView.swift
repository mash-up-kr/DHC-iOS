//
//  CounterView.swift
//  DHC-iOS
//
//  Created by hyerin on 5/27/25.
//

import SwiftUI

import ComposableArchitecture

struct CounterView: View {
  let store: StoreOf<CounterCore>
  
  init(store: StoreOf<CounterCore>) {
    self.store = store
  }
  
  var body: some View {
    Form {
      Section {
        Text("\(store.state.count)")
        Button("Decrement") {
          store.send(.decrementButtonTapped)
        }
        Button("Increment") {
          store.send(.incrementButtonTapped)
        }
      }
      Section {
        Button {
          store.send(.getFactButtonTapped)
        } label: {
          HStack {
            Text("Get fact")
            if store.isLoadingFact {
              Spacer()
              ProgressView()
            }
          }
        }
        if let fact = store.fact {
          Text(fact)
        }
      }
    }
  }
}

#Preview {
  CounterView(
    store: Store(
      initialState: .init(),
      reducer: CounterCore.init
    )
  )
}
