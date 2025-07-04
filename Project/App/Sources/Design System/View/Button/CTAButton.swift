//
//  CTAButton.swift
//  Flifin
//
//  Created by hyerin on 6/9/25.
//

import SwiftUI

struct CTAButton: View {
  private let size: Size
  private let style: Style
	private let title: String
	private let action: () -> Void
  
  @Environment(\.isEnabled) private var isEnabled
  
  private var foregroundColor: Color {
    isEnabled ? style.foregroundColor : style.disabledForegroundColor
  }
  private var backgroundColor: Color {
    isEnabled ? style.backgroundColor : style.disabledBackgroundColor
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
        Text(title)
          .textStyle(size.font)
          .foregroundStyle(foregroundColor)
          .padding(.vertical, size.verticalOffset)
          .frame(maxWidth: .infinity)
          .background {
            RoundedRectangle(cornerRadius: 8)
              .foregroundStyle(backgroundColor)
          }
      }
    )
	}
}

extension CTAButton {
  enum Size {
    case extraLarge
    case large
    
    var verticalOffset: CGFloat {
      switch self {
        case .extraLarge:
          return 15
        case .large:
          return 14
      }
    }
    
    var font: Typography.TypographyStyle {
      switch self {
        case .extraLarge:
          return Typography.Head.h5
        case .large:
          return Typography.Head.h6
      }
    }
  }

  enum Style {
    case primary
    case secondary
    case tertiary
    
    var foregroundColor: Color {
      switch self {
        case .primary, .secondary:
          return ColorResource.Text.main.color
        case .tertiary:
          return ColorResource.Neutral._300.color
      }
    }
    
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
    
    var disabledForegroundColor: Color {
      switch self {
        case .primary:
          return ColorResource.Neutral._200.color
        case .secondary:
          return ColorResource.Neutral._300.color
        case .tertiary:
          return ColorResource.Neutral._300.color
      }
    }
    
    var disabledBackgroundColor: Color {
      switch self {
        case .primary:
          return ColorResource.Neutral._300.color
        case .secondary:
          return ColorResource.Neutral._500.color
        case .tertiary:
          return .clear
      }
    }
  }
}

#Preview {
	VStack {
    CTAButton(
      size: .extraLarge,
			style: .primary,
			title: "금전운 확인하고 시작하기",
			action: {}
		)
		
    CTAButton(
			size: .extraLarge,
			style: .secondary,
			title: "금전운 확인하고 시작하기",
      action: {}
		)
		
    CTAButton(
			size: .large,
			style: .tertiary,
			title: "금전운 확인하고 시작하기",
      action: {}
		)
		
    CTAButton(
			size: .large,
      style: .primary,
			title: "금전운 확인하고 시작하기",
      action: {}
		)
    .disabled(true)
    
    CTAButton(
      size: .large,
      style: .secondary,
      title: "금전운 확인하고 시작하기",
      action: {}
    )
    .disabled(true)
	}
}
