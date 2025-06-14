//
//  CheckButton.swift
//  ProductName
//
//  Created by hyerin on 6/12/25.
//

import SwiftUI

struct CheckButton: View {
  private let title: String
  private let action: () -> Void
  @Binding private var isChecked: Bool
  
  private var foregroundColor: Color {
    isChecked ? Style.checked.foregroundColor : Style.default.foregroundColor
  }
  private var backgroundColor: Color {
    isChecked ? Style.checked.backgroundColor : Style.default.backgroundColor
  }
  private var checkMark: CheckMark {
    isChecked ? Style.checked.check : Style.default.check
  }
  
  init(
    title: String,
    action: @escaping () -> Void,
    isChecked: Binding<Bool>
  ) {
    self.title = title
    self.action = action
    self._isChecked = isChecked
  }
  
  var body: some View {
    Button(
      action: {
        action()
      },
      label: {
        HStack(spacing: 10) {
          checkMark
          
          Text(title)
            .foregroundStyle(ColorResource.Text.Body.primary.color)
            .textStyle(.h7)
        }
        .padding(.leading, 12)
        .padding(.trailing, 16)
        .padding(.vertical, 8)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 4))
      }
    )
  }
}

extension CheckButton {
  enum Style {
    case checked
    case `default`
    
    var backgroundColor: Color {
      switch self {
        case .checked:
          ColorResource.Background.badgePrimary.color
        case .default:
          ColorResource.Background.glassEffect.color
      }
    }
    
    var foregroundColor: Color {
      ColorResource.Text.Body.primary.color
    }
    
    var check: CheckMark {
      switch self {
        case .checked:
          CheckMark(size: .small, style: .active)
        case .default:
          CheckMark(size: .small, style: .enabled)
      }
    }
  }
}

#Preview {
  CheckButtonPreview()
}

struct CheckButtonPreview: View {
  @State private var isChecked = false
  
  var body: some View {
    CheckButton(
      title: "텍스트텍스트",
      action: {
        isChecked.toggle()
      },
      isChecked: $isChecked
    )
  }
}
