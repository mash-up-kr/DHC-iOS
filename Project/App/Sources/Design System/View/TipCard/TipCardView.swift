//
//  TipCardView.swift
//  Flifin
//
//  Created by hyerin on 6/20/25.
//

import SwiftUI

import SDWebImageSwiftUI

struct TipCardView: View {
  private let imageURL: URL?
  private let title: String
  private let content: String
  private let contentColor: Color?
  
  init(
    imageURL: URL?,
    title: String,
    content: String,
    contentColor: Color?
  ) {
    self.imageURL = imageURL
    self.title = title
    self.content = content
    self.contentColor = contentColor
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(spacing: 4) {
        WebImage(
          url: imageURL,
          content: { image in
            image.resizable()
          },
          placeholder: {
            EmptyView()
          }
        )
        .frame(width: 20, height: 20)
        
        Text(title)
          .foregroundStyle(ColorResource.Neutral._400.color)
          .textStyle(.body5)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      HStack(spacing: 8) {
        if let contentColor {
          DotView(color: contentColor, size: 8)
        }
        
        Text(content)
          .foregroundStyle(contentColor ?? ColorResource.Text.Body.primary.color)
          .textStyle(.h3)
      }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 20)
    .background(ColorResource.Neutral._700.color)
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}
