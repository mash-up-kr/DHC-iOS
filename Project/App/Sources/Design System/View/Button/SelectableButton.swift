//
//  SelectableButton.swift
//  ProductName
//
//  Created by hyerin on 6/12/25.
//

import SwiftUI

struct SelectableButton: View {
  private let title: String
  private let size: Size
  private let action: () -> Void
  @Binding private var isSelected: Bool

  private var foregroundColor: Color {
    isSelected ? Style.selected.foregroundColor : Style.default.foregroundColor
  }
  private var backgroundColor: Color {
    isSelected ? Style.selected.backgroundColor : Style.default.backgroundColor
  }
  
  init(
    title: String,
    size: Size,
    action: @escaping () -> Void,
    isSelected: Binding<Bool>
  ) {
    self.title = title
    self.size = size
    self.action = action
    self._isSelected = isSelected
  }
  
  var body: some View {
    Button(
      action: {
        action()
      },
      label: {
        Text(title)
        .textStyle(.h7)
        .foregroundStyle(foregroundColor)
        .padding(.vertical, size.verticalOffset)
        .padding(.horizontal, size.horizontalOffset)
        .background {
          RoundedRectangle(cornerRadius: size.cornerRadius)
            .foregroundStyle(backgroundColor)
        }
      }
    )
  }
}

extension SelectableButton {
  enum Size {
    case medium
    case small
    
    var verticalOffset: CGFloat {
      switch self {
        case .medium:
          return 12
        case .small:
          return 8
      }
    }
    
    var horizontalOffset: CGFloat {
      switch self {
        case .medium:
          return 63.5
        case .small:
          return 21.5
      }
    }
    
    var cornerRadius: CGFloat {
      switch self {
        case .medium:
          return 8
        case .small:
          return 4
      }
    }
  }
  
  enum Style {
    case selected
    case `default`
    
    var foregroundColor: Color {
      ColorResource.Text.Body.primary.color
    }
    
    var backgroundColor: Color {
      switch self {
        case .selected:
          return ColorResource.Text.Highlights.primary.color
        case .default:
          return ColorResource.Background.glassEffect.color
      }
    }
  }
}

#Preview {
  SelectableButtonPreview()
}

struct SelectableButtonPreview: View {
  @State private var isFirstButtonSelected: Bool = true
  @State private var isSecondButtonSelected: Bool = false
  
  var body: some View {
    VStack {
      SelectableButton(
        title: "첫번째",
        size: .medium,
        action: {
          isFirstButtonSelected.toggle()
        },
        isSelected: $isFirstButtonSelected
      )
      
      SelectableButton(
        title: "두번째",
        size: .small,
        action: {
          isSecondButtonSelected.toggle()
        },
        isSelected: $isSecondButtonSelected
      )
    }
  }
}
