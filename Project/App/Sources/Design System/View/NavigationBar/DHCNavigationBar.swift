//
//  DHCNavigationBar.swift
//  ProductName
//
//  Created by hyerin on 6/12/25.
//

import SwiftUI

struct DHCNavigationBar: View {
  private let type: NavigationType
  private let isNeedBackbutton: Bool
  private let backButtonAction: () -> Void
  private let stackHeight: CGFloat = 44
  
  init(
    type: NavigationType,
    isNeedBackbutton: Bool,
    backButtonAction: @escaping () -> Void = {}
  ) {
    self.type = type
    self.isNeedBackbutton = isNeedBackbutton
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
          isNeedBackbutton: isNeedBackbutton
        )
      case .title(let title):
        titleView(
          title: title,
          isNeedBackbutton: isNeedBackbutton
        )
    }
  }

  private func progressView(
    currentProgress: Int,
    totalProgress: Int,
    isNeedBackbutton: Bool
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
      if isNeedBackbutton {
        backButton
      }
    }
  }
  
  private func titleView(
    title: String,
    isNeedBackbutton: Bool
  ) -> some View {
    Text(title)
      .textStyle(.body2)
      .foregroundStyle(ColorResource.Text.main.color)
      .frame(maxWidth: .infinity)
      .frame(height: stackHeight)
      .overlay(alignment: .bottomLeading) {
        if isNeedBackbutton {
          backButton
        }
      }
  }
  
  private var backButton: some View {
    Button(
      action: {
        backButtonAction()
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
      isNeedBackbutton: false
    )
    
    DHCNavigationBar(
      type: .progress(currentProgress: 1, totalProgress: 4),
      isNeedBackbutton: true
    )
    
    DHCNavigationBar(
      type: .title("화면명"),
      isNeedBackbutton: false
    )
    
    DHCNavigationBar(
      type: .title("화면명"),
      isNeedBackbutton: true
    )
  }
}
