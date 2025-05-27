//___FILEHEADER___

import SwiftUI

import ComposableArchitecture

struct ___FILEBASENAMEASIDENTIFIER___: View {
  let store: StoreOf<___VARIABLE_productName:identifier___Core>
  
  init(store: StoreOf<___VARIABLE_productName:identifier___Core>) {
    self.store = store
  }
  
  var body: some View {
    Text("Hello, World!")
  }
}

#Preview {
  ___FILEBASENAMEASIDENTIFIER___(
    store: Store(
      initialState: .init(),
      reducer: ___VARIABLE_productName:identifier___Core.init
    )
  )
}
