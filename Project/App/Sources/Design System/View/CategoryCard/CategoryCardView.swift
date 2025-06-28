//
//  CategoryCardView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/14/25.
//

import SwiftUI

import SDWebImageSwiftUI

fileprivate struct CategoryCardContentView: View {
  private let imageURL: URL?
  private let title: String
  @Binding private var isSelected: Bool
  
  private var textColor: Color {
    isSelected ? ColorResource.Text.Highlights.secondary.color : ColorResource.Text.Body.primary.color
  }
  
  init(
    imageURL: URL?,
    title: String,
    isSelected: Binding<Bool>
  ) {
    self.imageURL = imageURL
    self.title = title
    self._isSelected = isSelected
  }
  
  var body: some View {
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

struct CategoryCardView: View {
  private let imageURL: URL?
  private let title: String

  init(
    imageURL: URL?,
    title: String
  ) {
    self.imageURL = imageURL
    self.title = title
  }
  
  var body: some View {
    CategoryCardContentView(
      imageURL: imageURL,
      title: title,
      isSelected: .constant(false)
    )
    .frame(width: 120, alignment: .leading)
    .background(ColorResource.Neutral._700.color)
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}


struct CategoryCardButton: View {
  private let imageURL: URL
  private let title: String
  @Binding private var isSelected: Bool

  init(
    imageURL: URL,
    title: String,
    isSelected: Binding<Bool>
  ) {
    self.imageURL = imageURL
    self.title = title
    self._isSelected = isSelected
  }
  
  var body: some View {
    Toggle(
      "카테고리 선택 토글",
      isOn: $isSelected
    )
    .toggleStyle(CategoryCardToggleStyle(imageURL: imageURL, title: title))
  }
}

struct CategoryCardToggleStyle: ToggleStyle {
  private let imageURL: URL
  private let title: String
  private func backgroundColor(isSelected: Bool) -> Color {
    isSelected ? ColorResource.Background.badgePrimary.color : ColorResource.Neutral._700.color
  }
  
  init(imageURL: URL, title: String) {
    self.imageURL = imageURL
    self.title = title
  }

  func makeBody(configuration: Configuration) -> some View {
    Button(
      action: {
        configuration.isOn.toggle()
      },
      label: {
        CategoryCardContentView(
          imageURL: imageURL,
          title: title,
          isSelected: configuration.$isOn
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(backgroundColor(isSelected: configuration.isOn))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(alignment: .topTrailing) {
          if configuration.isOn {
            CheckMark(size: .medium, style: .active)
              .padding(16)
          }
        }
      }
    )
  }
}
