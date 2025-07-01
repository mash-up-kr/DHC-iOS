//
//  DHCToast.swift
//  Flifin
//
//  Created by 김유빈 on 7/1/25.
//

import SwiftUI

struct DHCToast: View {
  private let message: String

  init(
    message: String
  ) {
    self.message = message
  }

  var body: some View {
    Toast(
      message: message,
      backgroundColor: ColorResource.Neutral._500.color,
      cornerRadius: 12,
      textStyle: Typography.Body.body4,
      textColor: ColorResource.Text.main.color
    )
    .padding(.horizontal, 20)
  }
}

#Preview {
  DHCToast(message: "차근차근 잘하고 있어요!")
}
