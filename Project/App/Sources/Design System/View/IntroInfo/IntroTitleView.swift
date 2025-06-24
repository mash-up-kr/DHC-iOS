//
//  IntroTitleView.swift
//  Flifin
//
//  Created by hyerin on 6/13/25.
//

import SwiftUI

struct IntroTitleView: View {
  private let style: Style
  private let title: String
  private let description: String?
  
  private let titleColor = ColorResource.Text.main.color
  private let descriptionColor = ColorResource.Neutral._300.color
  
  init(
    style: Style,
    title: String,
    description: String? = nil
  ) {
    self.style = style
    self.title = title
    self.description = description
  }
  
  var body: some View {
    VStack(alignment: style.contentAlignment, spacing: 16) {
      Text(title)
        .textStyle(style.titleFont)
        .foregroundStyle(titleColor)
      
      if let description {
        Text(description)
          .textStyle(.body3)
          .foregroundStyle(descriptionColor)
      }
    }
    .multilineTextAlignment(style.textAlignment)
    .padding(.top, 24)
    .padding(.horizontal, 20)
  }
}

extension IntroTitleView {
  enum Style {
    case intro
    case page
    
    var titleFont: Typography.TypographyStyle {
      Typography.Head.h2
    }
    
    var textAlignment: TextAlignment {
      switch self {
        case .intro:
          return .center
        case .page:
          return .leading
      }
    }
    
    var contentAlignment: HorizontalAlignment {
      switch self {
        case .intro:
          return .center
        case .page:
          return .leading
      }
    }
  }
}

#Preview {
  VStack {
    IntroTitleView(
      style: .intro,
      title: "매일매일 금전운 미션을 통해\n소비습관을 개선해보세요",
      description: "매일매일 금전운 미션을 통해\n소비습관을 개선해보세요"
    )
    
    IntroTitleView(
      style: .intro,
      title: "매일매일 금전운 미션을 통해\n소비습관을 개선해보세요"
    )
    
    IntroTitleView(
      style: .page,
      title: "매일매일 금전운 미션을 통해\n소비습관을 개선해보세요",
      description: "매일매일 금전운 미션을 통해\n소비습관을 개선해보세요"
    )
  }
}
