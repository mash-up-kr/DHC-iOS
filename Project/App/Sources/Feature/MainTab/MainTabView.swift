//
//  MainTabView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import SwiftUI

import ComposableArchitecture

struct MainTabView: View {
  @Bindable var store: StoreOf<MainTabReducer>

  init(store: StoreOf<MainTabReducer>) {
    self.store = store
    UITabBar.appearance().unselectedItemTintColor = ColorResource.Neutral._600.uiColor
  }

  var body: some View {
    TabView(selection: $store.selectedTab.sending(\.selectedTabChanged)) {
      Tab(value: .home) {
        HomeView(
          store: store.scope(
            state: \.homeTab,
            action: \.homeTab
          )
        )
      } label: {
        Image(.Icon.home)
          .renderingMode(.template)
        Text(TabKind.home.title)
      }

      Tab(value: .report) {
        NavigationStack {
          ReportView(
            store: store.scope(
              state: \.reportTab,
              action: \.reportTab
            )
          )
        }
      } label: {
        Image(.Icon.status)
          .renderingMode(.template)
        Text(TabKind.report.title)
      }

      Tab(value: .myPage) {
        NavigationStack {
          MyPageView(
            store: store.scope(
              state: \.myPageTab,
              action: \.myPageTab
            )
          )
        }
      } label: {
        Image(.Icon.mypage)
          .renderingMode(.template)
        Text(TabKind.myPage.title)
      }
    }
    .tint(ColorResource.Neutral._200.color)
  }
}
