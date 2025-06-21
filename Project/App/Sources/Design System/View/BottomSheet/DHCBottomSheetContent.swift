//
//  DHCBottomSheetContent.swift
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

struct DHCBottomSheetContent: View {
  let configuration: BottomSheetConfiguration

  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      if configuration.showXMark {
        xMarkView()
      }

      VStack(spacing: 12) {
        Text(configuration.title)
          .textStyle(.h2)
          .foregroundStyle(ColorResource.Text.main.color)

        Text(configuration.description)
          .textStyle(.body3)
          .foregroundStyle(ColorResource.Neutral._200.color)

        buttonView(for: configuration)
          .padding(20)
      }
    }
    .multilineTextAlignment(.center)
    .padding(.vertical, 20)
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
    .padding(.horizontal, 16)
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
  DHCBottomSheetContent(
    configuration: .oneButton(
      title: "DHCBottomSheet - One button case",
      description: "Description\nDescription Description",
      primaryButton: .init(title: "Primary Button", action: {})
    )
  )
}

#Preview("Two button") {
  DHCBottomSheetContent(
    configuration: .twoButtons(
      title: "DHCBottomSheet - Two button case",
      description: "Description\nDescription Description",
      primaryButton: .init(title: "Primary Button", action: {}),
      secondaryButton: .init(title: "Secondary Button", action: {})
    )
  )
}
