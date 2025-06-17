//
//  CategoryCardView.swift
//  ProductName
//
//  Created by Aiden.lee on 6/14/25.
//

import SwiftUI

import SDWebImageSwiftUI

struct CategoryCardView: View {
  let imageURL: URL
  let title: String

  init(imageURL: URL, title: String) {
    self.imageURL = imageURL
    self.title = title
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.head5)
        .foregroundStyle(ColorResource.Text.Body.primary.color)

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
    .frame(width: 120, height: 98, alignment: .leading)
    .background(ColorResource.Neutral._700.color)
    .cornerRadius(12)
  }
}
