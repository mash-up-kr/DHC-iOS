//
//  LargeNavigationTitleView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/29/25.
//

import SwiftUI

struct LargeNavigationTitleView: View {
  let title: String

  var body: some View {
    Text(title)
      .textStyle(.h2_1)
      .foregroundStyle(ColorResource.Text.Body.primary.color)
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

#Preview {
  LargeNavigationTitleView(title: "마이페이지")
}
