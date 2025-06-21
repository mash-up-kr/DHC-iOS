//
//  DHCBottomSheetContent.swift
//  ProductName
//
//  Created by 김유빈 on 6/15/25.
//

import SwiftUI

struct BottomSheetConfiguration {
  var title: String
  var description: String
  var showCloseButton: Bool
  var interactiveDisabled: Bool
  var firstButton: ButtonConfig?
  var secondButton: ButtonConfig?

  struct ButtonConfig {
    var title: String
    var action: () -> Void
  }
}

struct DHCBottomSheetContent: View {
  let configuration: BottomSheetConfiguration

  var body: some View {
    VStack(spacing: 0) {
      if configuration.showCloseButton {
        closeButtonView()
      }

      VStack(spacing: 12) {
        Text(configuration.title)
          .textStyle(.h2)
          .foregroundStyle(ColorResource.Text.main.color)

        Text(configuration.description)
          .textStyle(.body3)
          .foregroundStyle(ColorResource.Neutral._200.color)

        buttonView()
          .padding(20)
      }
    }
    .multilineTextAlignment(.center)
    .padding(.vertical, 20)
    .interactiveDismissDisabled(configuration.interactiveDisabled)
  }

  private func closeButtonView() -> some View {
    Button {
      // TODO:
    } label: {
      Image("icon/cancel")
        .resizable()
        .frame(width: 28, height: 28)
    }
    .frame(maxWidth: .infinity, alignment: .trailing)
  }

  @ViewBuilder
  private func buttonView() -> some View {
    if let first = configuration.firstButton,
       let second = configuration.secondButton {
      VStack(spacing: 8) {
        CTAButton(
          size: .extraLarge,
          style: .primary,
          title: first.title,
          action: first.action
        )
        
        CTAButton(
          size: .extraLarge,
          style: .tertiary,
          title: second.title,
          action: second.action
        )
      }
    } else if let first = configuration.firstButton {
      CTAButton(
        size: .extraLarge,
        style: .primary,
        title: first.title,
        action: first.action
      )
    } else {
      EmptyView()
    }
  }
}

#Preview("One Button") {
  DHCBottomSheetContent(
    configuration: BottomSheetConfiguration(
      title: "알림 설정을\n허용해주세요",
      description: "서비스를 원활히 진행하기 위해서\n알림설정이 꼭 필요해요",
      showCloseButton: true,
      interactiveDisabled: true,
      firstButton: .init(
        title: "금전운 확인하고 시작하기",
        action: {}
      )
    )
  )
}

#Preview("Two Buttons") {
  DHCBottomSheetContent(
    configuration: BottomSheetConfiguration(
      title: "오늘의 미션을\n정말 마무리할까요?",
      description: "아직 한 개의 미션이 남아 있어요!",
      showCloseButton: false,
      interactiveDisabled: false,
      firstButton: .init(
        title: "금전운 확인하고 시작하기",
        action: {}
      ),
      secondButton: .init(
        title: "금전운 확인하고 시작하기",
        action: {}
      )
    )
  )
}
