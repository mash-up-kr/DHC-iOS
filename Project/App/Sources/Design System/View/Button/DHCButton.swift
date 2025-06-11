//
//  DHCButton.swift
//  ProductName
//
//  Created by hyerin on 6/9/25.
//

import SwiftUI

struct DHCButton: View {
  private let size: Size
  private let style: Style
	private let title: String
	private let action: () -> Void
  @Environment(\.isEnabled) private var isEnabled
  
	private var verticalOffset: CGFloat {
		switch size {
			case .large:
				return 15
			case .medium:
				return 12
		}
	}
	
	init(
		size: Size,
		style: Style,
		title: String,
		action: @escaping () -> Void
	) {
		self.size = size
		self.style = style
		self.title = title
		self.action = action
	}
	
	var body: some View {
		Button(
			action: {
        action()
			},
			label: {
				HStack(spacing: 0) {
					Spacer()
					Text(title)
						.textStyle(.h5)
            .foregroundStyle(isEnabled ? style.foregroundColor : Self.DisabledStyle.disabledForegroundColor)
					Spacer()
				}
				.padding(.vertical, verticalOffset)
				.background {
					RoundedRectangle(cornerRadius: 8)
            .foregroundStyle(isEnabled ? style.backgroundColor : Self.DisabledStyle.disabledBackgroundColor)
				}
			}
		)
	}
}

extension DHCButton {
  enum Size {
    case large
    case medium
  }

  enum Style {
    case primary
    case secondary
    case tertiary
    
    var backgroundColor: Color {
      switch self {
        case .primary:
          return ColorResource.Text.Highlights.primary.color
        case .secondary:
          return ColorResource.Background.glassEffect.color
        case .tertiary:
          return .clear
      }
    }
    
    var foregroundColor: Color {
      switch self {
        case .primary, .secondary:
          return ColorResource.Text.main.color
        case .tertiary:
          return ColorResource.Neutral._300.color
      }
    }
  }

  enum DisabledStyle {
    static let disabledForegroundColor: Color =  ColorResource.Neutral._200.color
    static let disabledBackgroundColor: Color = ColorResource.Neutral._300.color
  }
}

#Preview {
	VStack {
		DHCButton(
			size: .large,
			style: .primary,
			title: "금전운 확인하고 시작하기",
			action: {}
		)
		
		DHCButton(
			size: .large,
			style: .secondary,
			title: "금전운 확인하고 시작하기",
      action: {}
		)
		
		DHCButton(
			size: .large,
			style: .tertiary,
			title: "금전운 확인하고 시작하기",
      action: {}
		)
		
		DHCButton(
			size: .large,
      style: .primary,
			title: "금전운 확인하고 시작하기",
      action: {}
		)
    .disabled(true)
	}
}
