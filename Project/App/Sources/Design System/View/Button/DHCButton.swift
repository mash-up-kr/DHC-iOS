//
//  DHCButton.swift
//  ProductName
//
//  Created by hyerin on 6/9/25.
//

import SwiftUI

enum ButtonSize {
	case large
	case medium
}

enum ButtonStyle {
	case primary
	case secondary
	case teritary
	case disabled
	
	var backgroundColor: Color {
		switch self {
			case .primary:
				return ColorResource.Text.Highlights.primary.color
			case .secondary:
				return ColorResource.Background.glassEffect.color
			case .teritary:
				return .clear
			case .disabled:
				return ColorResource.Neutral._300.color
		}
	}
	
	var foregroundColor: Color {
		switch self {
			case .primary, .secondary:
				return ColorResource.Text.main.color
			case .teritary:
				return ColorResource.Neutral._300.color
			case .disabled:
				return ColorResource.Neutral._200.color
		}
	}
}

struct DHCButton: View {
	private let size: ButtonSize
	private let style: ButtonStyle
	private let title: String
	private let action: () -> Void
	private var isEnabled: Bool {
		style != .disabled
	}
	private var verticalOffset: CGFloat {
		switch size {
			case .large:
				return 15
			case .medium:
				return 12
		}
	}
	
	init(
		size: ButtonSize,
		style: ButtonStyle,
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
				if isEnabled {
					action()
				}
			},
			label: {
				HStack(spacing: 0) {
					Spacer()
					Text(title)
						.textStyle(.h5)
						.foregroundStyle(style.foregroundColor)
					Spacer()
				}
				.padding(.vertical, verticalOffset)
				.background {
					RoundedRectangle(cornerRadius: 8)
						.foregroundStyle(style.backgroundColor)
				}
			}
		)
		.disabled(!isEnabled)
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
			style: .teritary,
			title: "금전운 확인하고 시작하기",
			action: {}
		)
		
		DHCButton(
			size: .large,
			style: .disabled,
			title: "금전운 확인하고 시작하기",
			action: {}
		)
	}
}
