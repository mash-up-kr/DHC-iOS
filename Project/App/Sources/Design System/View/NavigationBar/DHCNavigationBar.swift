//
//  DHCNavigationBar.swift
//  ProductName
//
//  Created by hyerin on 6/12/25.
//

import SwiftUI

struct DHCNavigationBar: View {
  private let type: NavigationType
  private let backButtonAction: (() -> Void)?
  private let stackHeight: CGFloat = 44
  
  private var isNeedBackButton: Bool {
    backButtonAction != nil
  }
  
  init(
    type: NavigationType,
    backButtonAction: (() -> Void)? = nil
  ) {
    self.type = type
    self.backButtonAction = backButtonAction
  }
  
  var body: some View {
    navigationContentView(type: type)
      .padding(.horizontal, 12)
      .padding(.top, 8)
  }
  
  @ViewBuilder
  private func navigationContentView(type: NavigationType) -> some View {
    switch type {
      case .progress(let currentProgress, let totalProgress):
        progressView(
          currentProgress: currentProgress,
          totalProgress: totalProgress,
          isNeedBackButton: isNeedBackButton
        )
      case .title(let title):
        titleView(
          title: title,
          isNeedBackButton: isNeedBackButton
        )
    }
  }

  private func progressView(
    currentProgress: Int,
    totalProgress: Int,
    isNeedBackButton: Bool
  ) -> some View {
    HStack(spacing: 2) {
      Text(String(currentProgress))
        .textStyle(.h5)
        .foregroundStyle(ColorResource.Text.main.color)
      
      Text("/\(totalProgress)")
        .textStyle(.body3)
        .foregroundStyle(ColorResource.Text.main.color.opacity(0.2))
    }
    .frame(width: stackHeight, height: stackHeight)
    .frame(maxWidth: .infinity, alignment: .trailing)
    .overlay(alignment: .bottomLeading) {
      if isNeedBackButton {
        backButton
      }
    }
  }
  
  private func titleView(
    title: String,
    isNeedBackButton: Bool
  ) -> some View {
    Text(title)
      .textStyle(.body2)
      .foregroundStyle(ColorResource.Text.main.color)
      .frame(maxWidth: .infinity)
      .frame(height: stackHeight)
      .overlay(alignment: .bottomLeading) {
        if isNeedBackButton {
          backButton
        }
      }
  }
  
  private var backButton: some View {
    Button(
      action: {
        backButtonAction?()
      },
      label: {
        ImageResource.Chevron.left.image
          .padding(10)
      }
    )
  }
}

extension DHCNavigationBar {
  enum NavigationType {
    case progress(currentProgress: Int, totalProgress: Int)
    case title(String)
  }
}

#Preview {
  VStack {
    DHCNavigationBar(
      type: .progress(currentProgress: 1, totalProgress: 4),
      backButtonAction: {
        print("didTapBackButton")
      }
    )
    
    DHCNavigationBar(
      type: .progress(currentProgress: 1, totalProgress: 4)
    )
    
    DHCNavigationBar(
      type: .title("화면명"),
      backButtonAction: {
        print("didTapBackButton")
      }
    )
    
    DHCNavigationBar(
      type: .title("화면명")
    )
  }
}
