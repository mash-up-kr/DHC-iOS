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
    configureTabBar()
  }

  var body: some View {
    TabView(selection: $store.selectedTab.sending(\.selectedTabChanged)) {
      Tab(value: .home) {
        IfLetStore(
          store.scope(state: \.homeTab, action: \.homeTab)
        ) { homeStore in
          HomeView(store: homeStore)
        }
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
    .onAppear {
      store.send(.onAppear)
    }
  }
}

extension MainTabView {
  private func configureTabBar() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    UITabBar.appearance().backgroundColor = ColorResource.Background.main.color.uiColor
    UITabBar.appearance().unselectedItemTintColor = ColorResource.Neutral._600.uiColor
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
  }
}
