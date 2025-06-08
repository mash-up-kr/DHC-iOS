//
//  DHC_iOSApp.swift
//  DHC-iOS
//
//  Created by 최혜린 on 4/14/25.
//

import SwiftUI

import ComposableArchitecture

@main
struct DHC_iOSApp: App {
	var body: some Scene {
		WindowGroup {
      RootView(
        store: Store(
          initialState: RootReducer.State(),
          reducer: RootReducer.init
        )
      )
		}
	}
}
