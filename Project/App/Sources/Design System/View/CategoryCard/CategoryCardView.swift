//
//  CategoryCardView.swift
//  ProductName
//
//  Created by Aiden.lee on 6/14/25.
//

import SwiftUI

import SDWebImageSwiftUI

struct CategoryCardView: View {
  private let imageURL: URL
  private let title: String
  private let isSelected: Bool
  private let action: (() -> Void)?
  
  private var textColor: Color {
    isSelected ? ColorResource.Text.Highlights.secondary.color : ColorResource.Text.Body.primary.color
  }
  private var backgroundColor: Color {
    isSelected ? ColorResource.Background.badgePrimary.color : ColorResource.Neutral._700.color
  }
  
  init(
    imageURL: URL,
    title: String,
    isSelected: Bool = false,
    action: (() -> Void)? = nil
  ) {
    self.imageURL = imageURL
    self.title = title
    self.isSelected = isSelected
    self.action = action
  }
  
  var body: some View {
    if let action {
      buttonView(action)
    } else {
      cardView
    }
  }
  
  private func buttonView(_ action: @escaping () -> Void) -> some View {
    Button(action: action) {
      contentView
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(alignment: .topTrailing) {
          if isSelected {
            CheckMark(size: .medium, style: .active)
              .padding(16)
          }
        }
    }
  }
  
  private var cardView: some View {
    contentView
      .frame(width: 120, alignment: .leading)
      .background(backgroundColor)
      .clipShape(RoundedRectangle(cornerRadius: 12))
  }
  
  private var contentView: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .textStyle(.h5)
        .foregroundStyle(textColor)
      
      WebImage(url: imageURL) { image in
        image
      }
      placeholder: {
        Rectangle()
          .background(Color.clear)
      }
      .resizable()
      .frame(width: 36, height: 36)
    }
    .padding(16)
  }
}
