//
//  SettingListRowView.swift
//  ProductName
//
//  Created by Aiden.lee on 6/14/25.
//

import SwiftUI

struct SettingListRowView: View {
  private let iconName: String
  private let title: String
  private let toggleValue: Binding<Bool>?
  private let action: (() -> Void)?

  init(
    title: String,
    iconName: String,
    toggleValue: Binding<Bool>? = nil,
    action: (() -> Void)? = nil
  ) {
    self.title = title
    self.iconName = iconName
    self.toggleValue = toggleValue
    self.action = action
  }

  var body: some View {
    if let action {
      Button(action: action) {
        content
      }
    } else {
      content
    }
  }

  var content: some View {
    HStack {
      Image(iconName)
        .resizable()
        .frame(width: 20, height: 20)

      Text(title)
        .textStyle(.body3)
        .foregroundStyle(ColorResource.Text.main.color)

      Spacer()

      if let toggleValue {
        Toggle("", isOn: toggleValue)
          .labelsHidden()
          .toggleStyle(
            SwitchToggleStyle(
              tint: ColorResource.Violet._600.color
            )
          )
      }
    }
    .frame(height: 56)
  }
}
