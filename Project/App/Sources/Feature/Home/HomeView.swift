//
//  HomeView.swift
//  ProductName
//
//  Created by Aiden.lee on 6/8/25.
//

import SwiftUI

import ComposableArchitecture

struct HomeView: View {
  @Bindable var store: StoreOf<HomeReducer>

  var body: some View {
    Text("Home")
  }
}
