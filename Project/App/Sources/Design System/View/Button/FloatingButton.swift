//
//  FloatingButton.swift
//  ProductName
//
//  Created by hyerin on 6/9/25.
//

import SwiftUI

enum FloatingButtonState {
	case enabled
	case disabled
	
	var foregroundColor: Color {
		switch self {
			case .enabled:
				return ColorResource.Text.main.color
			case .disabled:
				return ColorResource.Neutral._400.color
		}
	}
	
	var backgroundColor: Color {
		switch self {
			case .enabled:
				return ColorResource.Violet._400.color
			case .disabled:
				return ColorResource.Neutral._500.color
		}
	}
}

struct FloatingButton: View {
	private let state: FloatingButtonState
	private let title: String
	private let action: () -> Void
	private var isEnabled: Bool {
		state == .enabled
	}
	
	init(
		state: FloatingButtonState,
		title: String,
		action: @escaping () -> Void
	) {
		self.state = state
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
				Text(title)
					.textStyle(.h5)
					.foregroundStyle(state.foregroundColor)
					.padding(.vertical, 13)
					.padding(.horizontal, 20)
					.background(state.backgroundColor)
					.clipShape(Capsule())
			}
		)
	}
}

#Preview {
	FloatingButton(
		state: .enabled,
		title: "오늘 미션 끝내기",
		action: {}
	)
	
	FloatingButton(
		state: .disabled,
		title: "오늘 미션 끝내기",
		action: {}
	)
}
