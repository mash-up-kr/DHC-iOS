//
//  MyPageView.swift
//  ProductName
//
//  Created by Aiden.lee on 6/8/25.
//

import SwiftUI

import ComposableArchitecture

struct MyPageView: View {
  @Bindable var store: StoreOf<MyPageReducer>

  var body: some View {
    Text("My Page")
  }
}
