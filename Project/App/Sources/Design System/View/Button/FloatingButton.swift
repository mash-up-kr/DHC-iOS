//
//  FloatingButton.swift
//  Flifin
//
//  Created by hyerin on 6/9/25.
//

import SwiftUI

struct FloatingButton: View {
	private let title: String
	private let action: () -> Void
  @Environment(\.isEnabled) private var isEnabled
  
  private var foregroundColor: Color {
    isEnabled ? Style.enable.foregroundColor : Style.disable.foregroundColor
  }
  private var backgroundColor: Color {
    isEnabled ? Style.enable.backgroundColor : Style.disable.backgroundColor
  }
	
	init(
		title: String,
		action: @escaping () -> Void
	) {
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
					.textStyle(.h5)
					.foregroundStyle(foregroundColor)
					.padding(.vertical, 13)
					.padding(.horizontal, 20)
					.background(backgroundColor)
					.clipShape(Capsule())
			}
		)
	}
}

extension FloatingButton {
  enum Style {
    case enable
    case disable
    
    var foregroundColor: Color {
      switch self {
        case .enable:
          return ColorResource.Text.main.color
        case .disable:
          return ColorResource.Neutral._400.color
      }
    }
    
    var backgroundColor: Color {
      switch self {
        case .enable:
          return ColorResource.Violet._400.color
        case .disable:
          return ColorResource.Neutral._500.color
      }
    }
  }
}

#Preview {
	FloatingButton(
		title: "오늘 미션 끝내기",
		action: {}
	)
	
	FloatingButton(
		title: "오늘 미션 끝내기",
		action: {}
	)
  .disabled(true)
}
