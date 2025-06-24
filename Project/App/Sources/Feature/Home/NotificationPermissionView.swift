//
//  NotificationPermissionView.swift
//  Flifin
//
//  Created by 김유빈 on 6/17/25.
//

import SwiftUI

import ComposableArchitecture

struct NotificationPermissionView: View {
  let store: StoreOf<NotificationPermissionReducer>

  init(store: StoreOf<NotificationPermissionReducer>) {
    self.store = store
  }

  var body: some View {
    EmptyView()
    // TODO: [IOS-25] BottomSheet 컴포넌트 PR 머지되면 주석 해제하기
//    DHCBottomSheetContent(
//      configuration: BottomSheetConfiguration(
//        title: "알림 설정을\n허용해주세요",
//        description: "서비스를 원활히 진행하기 위해서\n알림설정이 꼭 필요해요",
//        showCloseButton: true,
//        interactiveDisabled: true,
//        firstButton: .init(
//          title: "알림 허용하기",
//          action: {
//            store.send(.allowButtonTapped)
//          }
//        )
//      )
//    )
  }
}

#Preview {
  NotificationPermissionView(
    store: Store(
      initialState: .init(),
      reducer: NotificationPermissionReducer.init
    )
  )
}
