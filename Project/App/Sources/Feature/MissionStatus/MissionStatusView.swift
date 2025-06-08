//
//  MissionStatusView.swift
//  ProductName
//
//  Created by Aiden.lee on 6/8/25.
//

import SwiftUI

import ComposableArchitecture

struct MissionStatusView: View {
  @Bindable var store: StoreOf<MissionStatusReducer>

  var body: some View {
    Text("Mission Status")
  }
}
