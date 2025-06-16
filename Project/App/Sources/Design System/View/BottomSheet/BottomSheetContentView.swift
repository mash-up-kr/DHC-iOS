//
//  BottomSheetContentView.swift
//  ProductName
//
//  Created by 김유빈 on 6/15/25.
//

import SwiftUI

enum BottomSheetConfiguration {
  case oneButton(title: String, description: String, primaryButton: ButtonConfig)
  case twoButtons(title: String, description: String, primaryButton: ButtonConfig, secondaryButton: ButtonConfig)

  struct ButtonConfig {
    let title: String
    let action: () -> Void
  }
}

extension BottomSheetConfiguration {
  var title: String {
    switch self {
    case .oneButton(let title, _, _),
         .twoButtons(let title, _, _, _):
      return title
    }
  }

  var description: String {
    switch self {
    case .oneButton(_, let description, _),
         .twoButtons(_, let description, _, _):
      return description
    }
  }

  var showXMark: Bool {
    if case .oneButton = self { return true }
    return false
  }

  var interactiveDisabled: Bool {
    if case .oneButton = self { return true }
    return false
  }
}

struct BottomSheetContentView: View {
  let configuration: BottomSheetConfiguration

  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      if configuration.showXMark {
        xMarkView()
      }

      Text(configuration.title)
        .font(.head2)
        .foregroundStyle(ColorResource.Text.main.color)
        .padding(.bottom, 12)

      Text(configuration.description)
        .font(.body3)
        .foregroundStyle(ColorResource.Neutral._200.color)
        .padding(.bottom, 32)

      buttonView(for: configuration)
    }
    .multilineTextAlignment(.center)
    .padding(.horizontal, 20)
    .interactiveDismissDisabled(configuration.interactiveDisabled)
  }

  private func xMarkView() -> some View {
    HStack {
      Spacer()

      Button {} label: {
        Image("icon/cancel")
          .resizable()
          .frame(width: 28, height: 28)
      }
    }
    .padding(.top, 32)
  }

  @ViewBuilder
  private func buttonView(for config: BottomSheetConfiguration) -> some View {
    switch config {
    case .oneButton(_, _, let primary):
      CTAButton(size: .extraLarge, style: .primary, title: primary.title, action: primary.action)

    case .twoButtons(_, _, let primary, let secondary):
      VStack(spacing: 8) {
        CTAButton(size: .extraLarge, style: .primary, title: primary.title, action: primary.action)
        CTAButton(
          size: .extraLarge,
          style: .tertiary,
          title: secondary.title,
          action: secondary.action
        )
      }
    }
  }
}

#Preview("One Button") {
  BottomSheetContentView(
    configuration: .oneButton(
      title: "알림 설정을\n허용해주세요",
      description: "서비스를 원활히 진행하기 위해서\n알림설정이 꼭 필요해요",
      primaryButton: .init(title: "금전운 확인하고 시작하기", action: {})
    )
  )
}

#Preview("Two Buttons") {
  BottomSheetContentView(
    configuration: .twoButtons(
      title: "오늘 미션을\n정말 마무리할까요?",
      description: "아직 한 개의 미션이 남아있어요!",
      primaryButton: .init(title: "금전운 확인하고 시작하기", action: {}),
      secondaryButton: .init(title: "금전운 확인하고 시작하기", action: {})
    )
  )
}
