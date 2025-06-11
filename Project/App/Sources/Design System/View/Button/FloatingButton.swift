//
//  FloatingButton.swift
//  ProductName
//
//  Created by hyerin on 6/9/25.
//

import SwiftUI

struct FloatingButton: View {
	private let title: String
	private let action: () -> Void
  @Environment(\.isEnabled) private var isEnabled
  
  private var foregroundColor: Color {
    isEnabled ? ColorResource.Text.main.color : ColorResource.Neutral._400.color
  }
  private var backgroundColor: Color {
    isEnabled ? ColorResource.Violet._400.color : ColorResource.Neutral._500.color
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
